import os

import parser

import initData
import calculate
import cal_wilconxon

from utils import print_init, printT, read, save, tab_printer


class data():
    trainDatas_df = []
    edges_df_all = []


def initFile(args):
    folder = os.path.exists(args.result_dir)
    if not folder:  # create directory
        os.makedirs(args.result_dir)

    print_init()
    tab_printer(args)
    print()

    return


def initCode():
    initData.init(dataCache=data, argsCache=args)
    calculate.init(dataCache=data, argsCache=args)
    cal_wilconxon.init(dataCache=data, argsCache=args)


def runAll():
    initFile(args)
    initCode()

    # start

    printT("1.0 read data")
    initData.createDataSet()

    printT("1.1 initData min by", args.cut_value)
    initData.cutOffByMin(minNum=args.cut_value)
    printT("1.2 change data to log")
    initData.toLog()

    printT("2 calculate the similarity matrix")
    calculate.getSprearmon(need_output=True)

    printT("3 delete pvalue larger than", args.remain_p_value)
    calculate.del_non_value()

    # # if want to compare co-expression with expression value
    # printT("cal wilcox")
    # cal_wilconxon.get_wilcox()

    printT("over.")


if __name__ == '__main__':
    args = parser.parameter_parser()
    runAll()
