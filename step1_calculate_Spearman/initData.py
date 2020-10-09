import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import os
from utils import printT

'''
trans_rdata < -function(file_name_rdata)
{
    r_file = load(file_name_rdata)
    data = eval(parse(text=r_file))
    write.table(data, "result.csv", sep=",", row.names = FALSE, quote = F)
}
'''


def createDataSet():
    def changeIndex():
        if not os.path.exists(args.index_path):
            printT("don't find index file, fail to change index.")
            return
        # change index
        with open(args.index_path, 'r') as f:
            lines = f.readlines()
        index = [line.strip() for line in lines]

        for i in range(data.type_num):
            data.trainDatas_df[i].index = index

    def readFile(path):
        dataSet = pd.read_csv(path, sep='\t')
        printT(' ' + path, dataSet.shape)
        data.trainDatas_df.append(dataSet)
        return

    dataList = []
    for maindir, subdir, file_name_list in os.walk(args.data_dir):
        for filename in file_name_list:
            if not str(filename).endswith('.txt'):
                continue
            apath = os.path.join(maindir, filename)
            dataList.append(apath)
    dataList.sort()
    for apath in dataList:
        readFile(apath)
    data.type_num = len(data.trainDatas_df)
    changeIndex()


def cutOffByMin(minNum):
    remainIndexs = None
    for i in range(data.type_num):
        meanFt = data.trainDatas_df[i].mean(1)  # get mean
        remainIndex = meanFt[meanFt > minNum].index
        if remainIndexs is None:
            remainIndexs = remainIndex
        else:
            remainIndexs = remainIndexs & remainIndex
    for i in range(data.type_num):
        data.trainDatas_df[i] = data.trainDatas_df[i].loc[remainIndexs]
    printT('  remain features count:', data.trainDatas_df[0].shape[0])

    return


def toLog():
    for i in range(data.type_num):
        data.trainDatas_df[i] = np.log(data.trainDatas_df[i] + 1)  # log(x+1)
    return


def init(dataCache, argsCache):
    global data
    data = dataCache
    global args
    args = argsCache
    return
