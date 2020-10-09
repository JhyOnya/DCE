import multiprocessing
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
import pandas as pd

import pickle

from utils import printT


def draw_boxplot(name, f_list, data_path_model, data_path_p_model, out_path_pic_model, ):
    data_f = []
    for f in f_list:
        data_f_pre = []
        for i in range(5):
            printT("read data ", data_path_model % (name, name, i, f))
            with open(data_path_model % (name, name, i, f), 'rb') as fr:
                data_pre = pickle.load(fr)[0]
            with open(data_path_p_model % (name, name, i, f), 'rb') as fr:
                p_pre = pickle.load(fr)[0]

            data_pre[p_pre > 0.01] = 0
            data_pre[data_pre < 0] = -data_pre
            data_pre_np = data_pre.values
            data_list = data_pre_np.ravel()[np.flatnonzero(data_pre_np)]
            data_f_pre.append(data_list)
        data_f.append(data_f_pre)

    plt.figure(figsize=(20, 10))

    p_list = ["Normal", "S1", "S2", "S3", "S4"]

    y = np.linspace(0, 1, 6)
    printT("draw ", name)

    plt.subplot(1, 2, 1)
    plt.boxplot(data_f[0], labels=p_list)
    plt.yticks(y)
    plt.title(f_list[0])

    plt.subplot(1, 2, 2)
    plt.boxplot(data_f[1], labels=p_list)
    plt.yticks(y)
    plt.title(f_list[1])

    plt.suptitle(name)

    printT("save ", name)
    plt.savefig(out_path_pic_model % name)
    plt.savefig(out_path_pdf_model % name)
    printT("finish ", name, f)


def run_boxplot(data_path_p_model, data_path_cor_model, out_path_pic_model):
    f_list = ['unfold', 'fold']

    name_list = ['LUAD', 'KIRC', 'THCA', 'COAD']
    pl = multiprocessing.Pool(processes=4)
    resultBuffer = []
    for name in name_list:
        resultBuffer.append(pl.apply_async(draw_boxplot,
                                           (name, f_list, data_path_cor_model, data_path_p_model, out_path_pic_model,)))
    pl.close()
    pl.join()


def draw_heatmap(name, f_list, data_path_model, out_path_pic_model, ):
    sort_by = ["4", "0"]
    for i, f in enumerate(f_list):
        printT("read data ", data_path_model % (f, name))
        edges_pre = pd.read_csv(data_path_model % (f, name))
        edges_pre.sort_values(sort_by)

        printT("draw ", name)

        plt.figure()
        plt.suptitle(name + f)

        sns.clustermap(edges_pre[["0", "1", "2", "3", "4"]], col_cluster=False,
                       cmap=sns.diverging_palette(270, 5, as_cmap=True))

        plt.savefig(out_path_pic_model % (name, f))

    printT("finish ", name)


def run_heatmap(data_path_model, out_path_pic_model):
    f_list = ['pos', 'neg']

    draw_heatmap('LUAD', f_list, data_path_model, out_path_pic_model, )

    name_list = ['COAD', 'KIRC', 'LUAD', 'THCA']
    pl = multiprocessing.Pool(processes=4)
    resultBuffer = []
    for name in name_list:
        resultBuffer.append(pl.apply_async(draw_heatmap,
                                           (name, f_list, data_path_model, out_path_pic_model,)))
    pl.close()
    pl.join()


#
if __name__ == '__main__':
    run_heatmap()
    run_boxplot()
