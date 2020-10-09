import numpy as np
import pandas as pd

import multiprocessing

from utils import printT


def each_data(data_name, cor_cut, limit_up, limit_down,
              model_4trend, path_model_cor, dir_int_str,
              trends_pos_int_list, trends_neg_int_list,
              model_edges_count):
    adj_sum = None
    na_num_list = []

    cors_ori_pd = []
    cors_sign_np = []
    cal_sign_np = None
    for i in range(5):
        # init
        printT(path_model_cor % (data_name, i))
        cor_pre_pd = pd.read_csv(path_model_cor % (data_name, i), index_col=0)
        cor_pre_np = np.triu(cor_pre_pd.values, 1)
        cor_pre_pd[np.abs(cor_pre_pd) < cor_cut] = 0
        cor_pre_pd = pd.DataFrame(cor_pre_np, index=cor_pre_pd.index, columns=cor_pre_pd.columns)

        cor_pre_pd = cor_pre_pd.fillna(0)

        if adj_sum is None:
            adj_sum = cor_pre_pd
        else:
            adj_sum = adj_sum + abs(cor_pre_pd)
        na_num_list.append((cor_pre_pd != 0).sum().sum())

        # cal signal
        cors_ori_pd.append(cor_pre_pd)
        cors_sign_pre_np = np.where(cor_pre_pd > 0, 1, cor_pre_pd)
        cors_sign_pre_np = np.where(cors_sign_pre_np < 0, 10, cor_pre_pd)
        cors_sign_np.append(cors_sign_pre_np)
        if cal_sign_np is None:
            cal_sign_np = cors_sign_pre_np
        else:
            cal_sign_np = cal_sign_np + cors_sign_pre_np
    na_num_list.append((adj_sum != 0).sum().sum())
    pd.DataFrame(na_num_list).to_csv(model_edges_count % data_name)

    # set abs or ori
    cal_sign_np = np.where((cal_sign_np % 10 == 0) & (cal_sign_np != 0), -1, 1)  # all<0 | all=0
    cors_abs = []
    printT("calculate sign", data_name)
    for i in range(5):
        cors_abs.append(cal_sign_np * cors_ori_pd[i])

    # cal trend up
    printT("calculate trend", data_name)
    trends = None
    trends_add = None
    for i in range(4):
        pre_distance = cors_abs[i + 1] - cors_abs[i]

        if i == 0:
            pre_distance[pre_distance >= limit_up] = 1
            pre_distance[pre_distance <= -limit_up] = -1
            pre_distance[(pre_distance < limit_up) & (pre_distance > -limit_up)] = 0
        else:
            """
            add>0 (-d,u)
            add=0 (-u,u)
            add<0 (-u,d)
            """

            pre_distance[(pre_distance >= limit_up) &
                         (trends_add >= 0)] = 1
            pre_distance[(pre_distance >= limit_down) &
                         (trends_add < 0)] = 1

            pre_distance[(pre_distance <= -limit_down) &
                         (trends_add > 0)] = -1
            pre_distance[(pre_distance <= -limit_up) &
                         (trends_add <= 0)] = -1

            pre_distance[(pre_distance < limit_up) &
                         (pre_distance > -limit_down) &
                         (trends_add > 0)] = 0
            pre_distance[(pre_distance < limit_up) &
                         (pre_distance > -limit_up) &
                         (trends_add == 0)] = 0
            pre_distance[(pre_distance < limit_down) &
                         (pre_distance > -limit_up) &
                         (trends_add < 0)] = 0

        if trends is None:
            trends = pre_distance
            trends_add = pre_distance
        else:
            trends = trends * 10 + pre_distance
            trends_add = trends_add + pre_distance

    # output

    index = trends.index
    columns = trends.columns

    for trend_pre, trends_int_list in zip(["pos", "neg"], [trends_pos_int_list, trends_neg_int_list]):
        trends4_pre = pd.DataFrame(None, columns=["trend", "Node_A", "Node_B", "0", "1", "2", "3", "4"])

        printT("collect", data_name, trend_pre)
        for pre_trend in trends_int_list:
            locs = np.where(trends == pre_trend)
            index_pre_name = [index[i] for i in locs[0]]
            columns_pre_name = [columns[i] for i in locs[1]]

            pd_pre = pd.DataFrame(None, columns=trends4_pre.columns)
            pd_pre["Node_A"] = index_pre_name
            pd_pre["Node_B"] = columns_pre_name
            for i in range(5):
                pd_pre[str(i)] = [cors_ori_pd[i].at[a, b] for a, b in zip(index_pre_name, columns_pre_name)]
            pd_pre["trend"] = dir_int_str[pre_trend]
            trends4_pre = pd.concat([trends4_pre, pd_pre], axis=0)

        printT(data_name, trend_pre, trends4_pre.shape, "output", model_4trend % ("pos", data_name))
        trends4_pre.to_csv(model_4trend % (trend_pre, data_name))


def run(cor_cut, limit_up, limit_down, model_4trend, path_model_cor, name_list,
        model_edges_count):
    dir_int_str = {}

    trends_pos_int_list = []
    trends_neg_int_list = []

    trends81_int_list = []
    for a in range(3):
        a_ = a - 1
        for b in range(3):
            b_ = b - 1
            for c in range(3):
                c_ = c - 1
                for d in range(3):
                    d_ = d - 1

                    pre = a_ * 1000 + b_ * 100 + c_ * 10 + d_
                    pre_str = "%2d%2d%2d%2d" % (a_, b_, c_, d_)

                    trends81_int_list.append(pre)

                    dir_int_str[pre] = pre_str
                    sum_ = a_ + b_ + c_ + d_
                    if (sum_ > 2) & (a_ == 1):
                        trends_pos_int_list.append(pre)
                    elif (sum_ < -2) & (a_ == -1):
                        trends_neg_int_list.append(pre)
    printT(dir_int_str)
    printT(trends81_int_list)

    pl = multiprocessing.Pool(processes=5)
    resultBuffer = []
    for name in name_list:
        resultBuffer.append(pl.apply_async(each_data, (name, cor_cut, limit_up, limit_down,
                                                       model_4trend, path_model_cor, dir_int_str,
                                                       trends_pos_int_list, trends_neg_int_list,
                                                       model_edges_count)))
    pl.close()
    pl.join()


if __name__ == '__main__':
    limit_up = 0.08
    limit_down = 0.04
    cor_cut = 0.4
    model_zh = "../cache/result_fnl/pre_networks/zh_%s_%s.csv"  # trend name
    model_4trend = "../cache/result_fnl/pre_networks/%s_%s.csv"  # trend name
    model_8trend = "../cache/result_fnl/pre_networks/8trends_%s.csv"  # name
    model_81trend = "../cache/result_fnl/pre_networks/81trends_%s.csv"  # name
    name_list = ['LUAD', 'KIRC', 'THCA', 'COAD']
    path_model_cor = "../cache/result_fnl/pre_networks/%s/%d_cor_new.csv"

    model_edges_count = "../cache/result_fnl/pre_networks/edges_count_%s.csv"
    run(cor_cut, limit_up, limit_down, model_zh, model_4trend, model_8trend, path_model_cor, name_list,
        model_edges_count)
