import pandas as pd
import numpy as np
from collections import Counter


def run(namelist, path_model, sub_model, stat_model):
    df_stat = pd.DataFrame(None, columns=namelist)
    trendlist = ['pos', 'neg']

    df_result = pd.DataFrame(None, columns=['C1', 'C2', 'C3', 'C4'])

    for name in namelist:
        index_maxsub_s = []
        index_secsub_s = []
        print()
        print(name)
        for trend in trendlist:
            subgraph_path = sub_model % (trend, name)
            print(subgraph_path, end=" ")
            with open(subgraph_path, 'r') as f:
                lines = f.readlines()
                points_list = lines[0].split(', ')
                points_list2 = lines[1].split(', ')
            points_list = [pre.replace("'", "").strip() for pre in points_list]
            points_list2 = [pre.replace("'", "").strip() for pre in points_list2]
            print(len(points_list))
            index_maxsub_s.append(points_list)
            index_secsub_s.append(points_list2)
            df_stat.at['sub_' + trend + '_points', name] = len(list(set(points_list)))
            df_stat.at['sec_' + trend + '_points', name] = len(list(set(points_list2)))

        node_count_s = []
        for i, trend in enumerate(trendlist):
            data_path = path_model % (trend, name)
            data = pd.read_csv(data_path)
            df_stat.at['all_' + trend + '_edges', name] = data.shape[0]
            df_stat.at['all_' + trend + '_points', name] = len(
                list(set(data['Node_A'].tolist() + data['Node_B'].tolist())))
            print(data.shape, end="->")

            data_sec = data[data['Node_A'].isin(index_secsub_s[i])]
            data_sec = data_sec[data_sec['Node_B'].isin(index_secsub_s[i])]
            print(data_sec.shape)
            df_stat.at['sec_' + trend + '_edges', name] = data_sec.shape[0]

            data = data[data['Node_A'].isin(index_maxsub_s[i])]
            data = data[data['Node_B'].isin(index_maxsub_s[i])]
            print(data.shape, data_path)
            df_stat.at['sub_' + trend + '_edges', name] = data.shape[0]

            index = data['Node_A'].tolist() + data['Node_B'].tolist()
            df_stat.at['sub_' + trend + '_points', name] = len(list(set(index)))
            result = Counter(index)
            node_count_pre = pd.DataFrame(list(result.most_common()), columns=['Node', trend + '_num'])
            node_count_pre.set_index(["Node"], inplace=True)

            print(i, "node count", node_count_pre.shape)
            node_count_s.append(node_count_pre)
        node_count_df = node_count_s[0].join(node_count_s[1], how='outer')
        print("all node count", node_count_df.shape)

        node_count_df = node_count_df.fillna(0)
        c1 = node_count_df[(node_count_df[trendlist[0] + '_num'] != 0) & (node_count_df[trendlist[1] + '_num'] != 0)]
        c2 = node_count_df[(node_count_df[trendlist[0] + '_num'] > 5) & (node_count_df[trendlist[1] + '_num'] > 5)]
        c3_pos = node_count_df[
            (node_count_df[trendlist[0] + '_num'] >= 1) & (node_count_df[trendlist[1] + '_num'] == 0)]
        c3_neg = node_count_df[
            (node_count_df[trendlist[0] + '_num'] == 0) & (node_count_df[trendlist[1] + '_num'] >= 1)]

        df_result.loc[name] = [c1.shape[0],
                               c2.shape[0],
                               c3_pos.shape[0],
                               c3_neg.shape[0]]

    df_stat = df_stat.sort_index()
    print(df_stat)
    df_stat.to_csv(stat_model)


if __name__ == '__main__':
    namelist = ['LUAD', 'KIRC', 'THCA', 'COAD', 'HNSC']
    path_model = ".../cache/result_fnl/pre_networks/%s_%s.csv"  # pos/neg name
    sub_model = ".../cache/result_fnl/pre_networks/subgraph_%s_%s.txt"  # pos/neg name

    stat_model = ".../cache/result_fnl/pre_networks/stat_all.csv"
    run(namelist, path_model, sub_model, stat_model)
