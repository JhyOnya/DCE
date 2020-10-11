import pandas as pd
from collections import Counter
from utils import printT


def run(namelist, path_model, path_model_new, node2_model):
    trendlist = ['pos', 'neg']

    df_result = pd.DataFrame(None, columns=['C1', 'C2', 'C3', 'C4', "C3'", "C4'"])

    for name in namelist:
        datas = []
        node_count_s = []
        for i, trend in enumerate(trendlist):
            data_path = path_model % (trend, name)
            data = pd.read_csv(data_path, index_col=0)

            index = data['Node_A'].tolist() + data['Node_B'].tolist()
            result = Counter(index)
            node_count_pre = pd.DataFrame(list(result.most_common()), columns=['Node', trend + '_num'])
            node_count_pre.set_index(["Node"], inplace=True)

            printT(name, trend, "edges", data.shape[0], "->", "nodes", node_count_pre.shape[0])
            node_count_s.append(node_count_pre)
            datas.append(data)
        node_count_df = node_count_s[0].join(node_count_s[1], how='outer')
        printT(name, "all node count", node_count_df.shape)

        node_count_df = node_count_df.fillna(0)
        c1 = node_count_df[(node_count_df[trendlist[0] + '_num'] != 0) & (node_count_df[trendlist[1] + '_num'] != 0)]
        c2 = node_count_df[(node_count_df[trendlist[0] + '_num'] > 5) & (node_count_df[trendlist[1] + '_num'] > 5)]
        c3_pos = node_count_df[(node_count_df[trendlist[0] + '_num'] >= 1) &
                               (node_count_df[trendlist[1] + '_num'] == 0)]
        c3_neg = node_count_df[(node_count_df[trendlist[0] + '_num'] == 0) &
                               (node_count_df[trendlist[1] + '_num'] >= 1)]

        df_result.loc[name] = [c1.shape[0],
                               c2.shape[0],
                               c3_pos.shape[0],
                               c3_neg.shape[0], 0, 0]

        # node2
        c2_pd = pd.DataFrame(list(c2.index))
        c2_pd.to_csv(node2_model % name, header=False, index=False)

        # get new network node34
        for data, trend_pre, c34, pre_c in zip(datas, trendlist, [c3_pos, c3_neg], ["C3'", "C4'"]):
            data_new = data[data['Node_A'].isin(c34.index) & data['Node_B'].isin(c34.index)]
            printT(trend_pre, name, "C34 count", data_new.shape[0])
            df_result.at[name, pre_c] = data_new.shape[0]
            data_new.to_csv(path_model_new % (trend_pre, name), index=False)

    print(df_result)


if __name__ == '__main__':
    namelist = ['LUAD', 'KIRC', 'THCA', 'COAD', 'HNSC']
    path_model = ".../cache/result_fnl/pre_networks/%s_%s_08.csv"  # pos/neg name

    path_model_new = ".../cache/result_fnl/pre_networks/%s_%s_nonboth.csv"  # pos/neg name
    path_model_new1 = ".../cache/result_fnl/pre_networks/node2_%s_%s.txt"  # pos/neg name
    run(namelist, path_model, path_model_new, path_model_new1)
