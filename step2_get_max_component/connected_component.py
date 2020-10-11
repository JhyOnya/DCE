import numpy as np
import pandas as pd

import multiprocessing

import functools

from utils import printT


def cmp(list1, list2):
    return len(list2) - len(list1)


def cal_connected_graph(adj, n):
    connect_graph = np.linalg.matrix_power(adj / n + np.eye(n), n - 1)  # (I+A/n)^(n-1)
    connect_graph[connect_graph != 0] = 1
    return connect_graph


def cal_out_subgraph(connect_graph, data_name, index, trend_data_pre, subgraphs_model, trend_pre,
                     subgraph_nodelist_model_new,
                     subgraphs_max_edges_model, subgraphs_max_model_edges_v_new):
    connect_graph_pd = pd.DataFrame(connect_graph, index=index, columns=index)

    remainIndex = connect_graph_pd.index

    subgraphs = []
    added_index = []
    for pre in remainIndex:
        if pre in added_index:
            continue
        pre_index = connect_graph_pd.loc[connect_graph_pd[pre] >= 1].index
        subgraphs.append(pre_index.tolist())
        added_index.extend(pre_index)

    printT(data_name, trend_pre, "subgraph count:", len(subgraphs))

    subgraphs.sort(key=functools.cmp_to_key(cmp))

    output = open(subgraphs_model % (trend_pre, data_name), 'w')
    for row in subgraphs:
        row_str = str(row).replace("[", "").replace("]", "")
        output.write(row_str + '\n')
    submax_pd = pd.DataFrame(subgraphs[0])
    submax_pd.to_csv(subgraph_nodelist_model_new % (data_name, trend_pre), header=None, index=False)

    subnet = trend_data_pre[trend_data_pre['Node_A'].isin(subgraphs[0]) & trend_data_pre['Node_B'].isin(subgraphs[0])]
    printT(data_name, trend_pre, "subnet nodes count", len(subgraphs[0]))
    printT(data_name, trend_pre, "subnet edges count", subnet.shape[0])
    subnet[['Node_A', 'Node_B']].to_csv(subgraphs_max_edges_model % (trend_pre, data_name), index=False, sep="\t")

    subnet.to_csv(subgraphs_max_model_edges_v_new % (trend_pre, data_name), index=False)


def cal(data_name, trend_pre, subgraphs_model, trend_model, subgraph_nodelist_model_new, subgraphs_max_edges_model,
        subgraphs_max_model_edges_v_new):
    trend_data_pre = pd.read_csv(trend_model % (trend_pre, data_name))

    # node_list to adj
    index_pre = list(set(trend_data_pre['Node_A'].tolist() + trend_data_pre['Node_B'].tolist()))
    useful_connect_pd = pd.DataFrame(np.zeros((len(index_pre), len(index_pre))),
                                     index=index_pre, columns=index_pre)
    n1 = [index_pre.index(pre) for pre in trend_data_pre['Node_A'].tolist()]
    n2 = [index_pre.index(pre) for pre in trend_data_pre['Node_B'].tolist()]
    useful_connect_pd.values[n1, n2] = 1
    useful_connect_pd = np.minimum(useful_connect_pd + useful_connect_pd.T, 1)

    connect_graph = cal_connected_graph(useful_connect_pd, len(index_pre))
    cal_out_subgraph(connect_graph, data_name, index_pre, trend_data_pre, subgraphs_model, trend_pre,
                     subgraph_nodelist_model_new, subgraphs_max_edges_model, subgraphs_max_model_edges_v_new)


def run(data_list, trend_model, subgraphs_model, subgraph_nodelist_model_new, subgraphs_max_edges_model,
        subgraphs_max_model_edges_v_new):
    trends = ['pos', 'neg']
    pl = multiprocessing.Pool(processes=10)
    resultBuffer = []
    for data_name in data_list:
        for trend_pre in trends:
            resultBuffer.append(
                pl.apply_async(cal, (
                    data_name, trend_pre, subgraphs_model, trend_model, subgraph_nodelist_model_new,
                    subgraphs_max_edges_model, subgraphs_max_model_edges_v_new,)))
    pl.close()
    pl.join()


if __name__ == '__main__':
    data_list = ['LUAD', 'KIRC', 'THCA', 'COAD', 'HNSC']
    trend_model = "../cache/result_fnl/pre_networks/%s_%s.csv"  # neg/pos name
    subgraphs_model = "../cache/result_fnl/pre_networks/subgraph_%s_%s.txt"  # neg/pos name

    run(data_list, trend_model, subgraphs_model)
