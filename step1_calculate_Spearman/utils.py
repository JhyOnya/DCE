import datetime
import os
import pickle
from texttable import Texttable
import shutil

# 初始化
log_fl = False
start = datetime.datetime.now()
zeroToday = start - datetime.timedelta(hours=start.hour, minutes=start.minute, seconds=start.second,
                                       microseconds=start.microsecond)
now_time = datetime.timedelta(hours=start.hour, minutes=start.minute, seconds=start.second,
                              microseconds=start.microsecond)


def tab_printer(args):
    """
    Function to print the logs in a nice tabular format.
    :param args: Parameters used for the model.
    """
    args = vars(args)
    keys = args.keys()
    # keys = sorted(args.keys())

    t = Texttable()
    t.set_precision(5)
    t.set_deco(Texttable.VLINES)
    t.set_cols_align(["r", "l"])
    # t.header(("Parameter", "Value"))
    t.add_rows([[k.replace("_", " ").capitalize(), args[k]] for k in keys], header=False)
    print(t.draw())


def print_init():
    printT("start time:", start)
    return


def printT(*oup, end='\n'):
    print((datetime.datetime.now() - start + zeroToday).strftime('%H:%M:%S'), *oup, end=end)


def save(data, filePath):
    data_name_list = [name for name, value in vars(data).items() if not name.startswith("_")]
    data_list = [value for name, value in vars(data).items() if not name.startswith("_")]
    print()
    printT("~ save data:", data_name_list, "\n  ")

    with open(filePath, 'wb') as fw:
        pickle.dump(data_list, fw, 0)


def read(data, filePath):
    filePath = filePath
    printT("~ read data from:", filePath)

    with open(filePath, 'rb') as fr:
        data_cache = pickle.load(fr)

    data_name_list = [name for name, value in vars(data).items() if not name.startswith("_")]
    printT("~ read data:", data_name_list)
    for pre_name, pre_value in zip(data_name_list, data_cache):
        setattr(data, pre_name, pre_value)
