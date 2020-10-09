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


def printT(*oup, end='\n'):
    print((datetime.datetime.now() - start + zeroToday).strftime('%H:%M:%S'), *oup, end=end)
