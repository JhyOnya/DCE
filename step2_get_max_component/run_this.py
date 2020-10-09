import cal_8trends
import connected_component
import cal_edges_points
import get_node34_component
import draw_plot

import pandas as pd
import os


def stat_msgs(model, name_list, out_model):
    dt_all = None
    for name in name_list:
        dt_pre = pd.read_csv(model % name, index_col=0)
        dt_pre.columns = [name]
        if dt_all is None:
            dt_all = dt_pre
        else:
            dt_all = pd.concat([dt_all, dt_pre], axis=1)
    dt_all.index = ["Normal", "S1", "S2", "S3", "S4", "sum"]
    print(dt_all)
    dt_all.to_csv(out_model)


def stat_msgs_trend4(name_list, model_edges_all_count, model_edges_trend4_count):
    all_edges_count = pd.read_csv(model_edges_all_count, index_col=0)
    result_both_pd = pd.DataFrame(None, index=["up_edge", "up_edge_per", "up_point",
                                               "down_edge", "down_edge_per", "down_point", "co_point", "all_edges"])
    for name in name_list:
        resul_pre = []
        nodeset_list = []
        for trend in ["pos", "neg"]:
            pre_data = pd.read_csv(model_4trend % (trend, name), index_col=0)
            node_set = set(pre_data['Node_A'].tolist() + pre_data['Node_B'].tolist())

            resul_pre.append(pre_data.shape[0])
            resul_pre.append(pre_data.shape[0] / all_edges_count.at["sum", name])
            resul_pre.append(len(node_set))

            nodeset_list.append(node_set)
        resul_pre.append(len(nodeset_list[0] & nodeset_list[1]))
        resul_pre.append(all_edges_count.at["sum", name])
        result_both_pd[name] = resul_pre
    result_both_pd = result_both_pd.T

    result_both_pd[["up_edge", "up_point", "down_edge", "down_point", "co_point", "all_edges"]] = result_both_pd[
        ["up_edge", "up_point", "down_edge", "down_point", "co_point", "all_edges"]].astype('int')
    result_both_pd["up_edge_per"] = result_both_pd["up_edge_per"].apply(lambda x: format(x, '.2%'))
    result_both_pd["down_edge_per"] = result_both_pd["down_edge_per"].apply(lambda x: format(x, '.2%'))
    print(result_both_pd)
    result_both_pd.to_csv(model_edges_trend4_count)


name_list = ['COAD', 'KIRC', 'LUAD', 'THCA']

path_main_input = "../cache/result_1to23/"
path_main_23 = "../cache/result_2to3/"
path_main_out = "../cache/result_2/"

if not os.path.exists(path_main_out):  # create directory
    os.makedirs(path_main_out)
if not os.path.exists(path_main_23):  # create directory
    os.makedirs(path_main_23)

path_model_cor = path_main_input + "%s/%d_cor_new.csv"

# new_8trends
print("\n\n\n8trends")
limit_up = 0.08
limit_down = 0.04
cor_cut = 0.4
model_4trend = path_main_23 + "edges_trend4_%s_%s.csv"  # trend name
model_edges_count = path_main_out + "edges_count_%s.csv"  # name
cal_8trends.run(cor_cut, limit_up, limit_down,
                model_4trend, path_model_cor, name_list, model_edges_count)

# out stat
model_edges_all_count = path_main_out + "edges_count_all.csv"
stat_msgs(model_edges_count, name_list, model_edges_all_count)

# out trend4 edges count
model_edges_trend4_count = path_main_out + "edges_trend4_count_all.csv"  # name
stat_msgs_trend4(name_list, model_edges_all_count, model_edges_trend4_count)

#

###########
#	new node34 component
print("\n\n\nnode34_component")
model_4trend_new = path_main_out + "nonboth_%s_%s.csv"  # pos/neg name
node2_model = path_main_out + "nonboth_node2_%s.txt"  # name
get_node34_component.run(name_list, model_4trend, model_4trend_new, node2_model)

# new connected component
print("\n\n\nconnected_component")
subgraphs_model_new = path_main_out + "nonboth_subgraph_%s_%s.txt"  # pos/neg name
subgraphs_max_model_edges_new = path_main_out + "nonboth_subgraph_edges_%s_%s.txt"  # name pos/negname
subgraphs_max_model_edges_v_new = path_main_out + "nonboth_subgraph_edges_%s_%s.csv"  # name pos/neg
subgraphs_max_nodes_model_new = path_main_23 + "nonboth_subgraph_nodes_%s_%s.txt"
connected_component.run(name_list, model_4trend_new, subgraphs_model_new, subgraphs_max_nodes_model_new,
                        subgraphs_max_model_edges_new, subgraphs_max_model_edges_v_new)

# new caledges points
print("\n\n\ncaledges_points")
stat_model_new = path_main_out + "nonboth_stat_all.csv"

subgraphs_max_edges_model_new = path_main_out + "nonboth_subgraph_edges.txt"
cal_edges_points.run(name_list, model_4trend_new, subgraphs_model_new, stat_model_new)

# draw
print("\n\n\ndraw")
data_path_model = subgraphs_max_model_edges_v_new
out_path_pic_heatmap_model = path_main_out + "heatmap_%s_%s_cor_by_p.png"  # dataname trend
draw_plot.run_heatmap(data_path_model, out_path_pic_heatmap_model)

# # need to have output the spearmon without fold in step1
# data_path_p_model = path_main_input + "%s/%s_%d_p_%s.pkl"  # dataname 0-5 fold/unfold
# data_path_cor_model = path_main_input + "%s/%s_%d_cor_%s.pkl"  # dataname 0-5 fold/unfold
# out_path_pic_model = path_main_out + "boxplot_%s_cor_by_p.png"  # dataname fold/unfold
# draw_plot.run_boxplot()
