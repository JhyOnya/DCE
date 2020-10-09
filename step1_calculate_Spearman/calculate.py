import numpy as np
import pandas as pd
from random import shuffle
import multiprocessing
import shutil
from scipy import stats

from utils import printT


def getSimilarAndPvalue(sampleDataFrame):
    spearman_np, p_np = stats.spearmanr(sampleDataFrame.T)
    np.fill_diagonal(spearman_np, 0)
    np.fill_diagonal(p_np, 1)
    return spearman_np, p_np


# 2 get all similarity matrix  multi
def each_process_fold(sample_num, i, trainDataFrame, need_output):  # non-multi
    import pickle
    printT("  calculate spearmon %d, " % i, trainDataFrame.shape)

    # # doesn't use fold
    # scc_unfold, p_unfold = getSimilarAndPvalue(trainDataFrame)
    # cDF_unfold = pd.DataFrame(scc_unfold, index=trainDataFrame.index, columns=trainDataFrame.index)
    # pDF_unfold = pd.DataFrame(p_unfold, index=trainDataFrame.index, columns=trainDataFrame.index)
    # printT("  output file", args.result_dir + args.data_name + '_' + str(i) + '_cor_unfold.pkl')
    # with open(args.result_dir + args.data_name + '_' + str(i) + '_cor_unfold.pkl', 'wb') as fw:
    #     pickle.dump([cDF_unfold], fw, 0)
    # printT("  output file", args.result_dir + args.data_name + '_' + str(i) + '_p_unfold.pkl')
    # with open(args.result_dir + args.data_name + '_' + str(i) + '_p_unfold.pkl', 'wb') as fw:
    #     pickle.dump([pDF_unfold], fw, 0)

    np.random.seed(66)

    fold_num = 10
    sccDF = 0
    pDF = 1

    need_g = 1 + int((sample_num * fold_num) / data.trainDatas_df[i].shape[1])
    list_all = []
    for nee in range(need_g):
        list_pre = [j for j in range(data.trainDatas_df[i].shape[1])]
        shuffle(list_pre)
        list_all.extend(list_pre)

    for j in range(fold_num):  # 10-fold
        train_index = list_all[j * sample_num:(j + 1) * sample_num]
        printT("  spearmon %d by fold=%d/%d %d sample=%s" % (i, j, fold_num, len(train_index), train_index))

        trainDataFrame_pre = trainDataFrame.iloc[:, train_index]
        scc, p = getSimilarAndPvalue(trainDataFrame_pre)
        sccDF_pre = pd.DataFrame(scc, index=trainDataFrame_pre.index, columns=trainDataFrame_pre.index)
        pDF_pre = pd.DataFrame(p, index=trainDataFrame_pre.index, columns=trainDataFrame_pre.index)

        sccDF = sccDF + sccDF_pre
        pDF = pDF * pDF_pre

    printT("  spearmon %d finish" % i)
    cDF_result = sccDF / fold_num
    pDF_result = pDF ** (1 / fold_num)
    if need_output:
        printT("  output file", args.result_dir + args.data_name + '_' + str(i) + '_cor_fold.pkl')
        with open(args.result_dir + args.data_name + '_' + str(i) + '_cor_fold.pkl', 'wb') as fw:
            pickle.dump([cDF_result], fw, 0)

        printT("  output file", args.result_dir + args.data_name + '_' + str(i) + '_p_fold.pkl')
        with open(args.result_dir + args.data_name + '_' + str(i) + '_p_fold.pkl', 'wb') as fw:
            pickle.dump([pDF_result], fw, 0)

    printT("  delete spearmon %d by p>%f" % (i, args.remain_p_value))
    cDF_result[pDF_result > args.remain_p_value] = np.nan

    printT("  calculate spearmon %d finish" % i)
    return cDF_result


def getSprearmon(need_output=False):
    sample_num_all = []
    for pre_df in data.trainDatas_df:
        sample_num_all.append(pre_df.shape[1])
    sample_num = int(min(sample_num_all) * 0.9)  # get int largest one less than pre

    # if use multiprocessing
    pl = multiprocessing.Pool(processes=args.max_process)
    resultBuffer = []

    for i, trainDataFrame in enumerate(data.trainDatas_df):
        resultBuffer.append(pl.apply_async(each_process_fold, (sample_num, i, trainDataFrame, need_output,)))
    pl.close()
    pl.join()

    for i, result in enumerate(resultBuffer):
        cDF_result = result.get()
        data.edges_df_all.append(cDF_result)

    # # if don't use multiprocessing
    # for i, trainDataFrame in enumerate(data.trainDatas_df):
    #     data.edges_df_all.append(each_process_fold(sample_num, i, trainDataFrame, need_output))


def del_non_value():
    remainIndexs = None
    for i in range(data.type_num):
        nanIndex = data.edges_df_all[i][data.edges_df_all[i].isnull().all()].index
        remainIndexs = nanIndex if remainIndexs is None else remainIndexs & nanIndex

    for i in range(data.type_num):
        data.edges_df_all[i] = data.edges_df_all[i].drop(index=remainIndexs, columns=remainIndexs)
        printT("  output file", args.result_dir + str(i) + '_cor_new.csv')
        data.edges_df_all[i].to_csv(args.result_dir + str(i) + '_cor_new.csv')
    printT(" remain shape", data.edges_df_all[0].shape)


def init(dataCache, argsCache):
    global data
    data = dataCache
    global args
    args = argsCache
    return
