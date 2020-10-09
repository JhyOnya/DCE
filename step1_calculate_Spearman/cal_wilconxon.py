import numpy as np
import rpy2.robjects as robjects
from rpy2.robjects import pandas2ri
from rpy2.robjects.packages import importr

import pandas as pd

pandas2ri.activate()
import_Hmisc = importr('Hmisc')


def get_wilcox():
    # python's spearman is too slow to stand
    # the matrix is symmetric matrix, so remain its triangular matrix

    simiR = '''
    getDEG2<-function(PData,NData)
    {
      cancer_label=rep(0,nrow(PData))
      candi_upindex=c()
      candi_downindex=c()
      pvalue=rep(1,nrow(PData))
      for (j in 1:nrow(PData))
      {
        ttesttemp1=wilcox.test(PData[j,],NData[j,],alternative="greater")
        ttesttemp1$p.value[is.na(ttesttemp1$p.value)]=1
        ttesttemp2=wilcox.test(PData[j,],NData[j,],alternative="less")
        ttesttemp2$p.value[is.na(ttesttemp2$p.value)]=1
        if(ttesttemp1$p.value<0.05)     #0.08
        { candi_upindex=c(candi_upindex,j)
        pvalue[j]=ttesttemp1$p.value
        }
        else if (ttesttemp2$p.value<0.05)    #0.08
        {   candi_downindex=c(candi_downindex,j)
        pvalue[j]=ttesttemp2$p.value
        }
        # print(j)
      }
      cancer_label[candi_upindex]=1
      cancer_label[candi_downindex]=-1
      gene_symbol=row.names(PData)
      gene_label_p=cbind(gene_symbol,cancer_label,pvalue)
      return (gene_label_p)
    }
    '''
    robjects.r(simiR)
    simi_pd = None
    for i, A_pd, B_pd in zip(range(len(data.trainDatas_df) - 1), data.trainDatas_df[0:-1], data.trainDatas_df[1:]):
        simi = robjects.r['getDEG2'](A_pd.values, B_pd.values)
        if simi_pd is None:
            simi_pd = pd.DataFrame(0, index=A_pd.index, columns=["trend"])
        simi_pd["up_down_" + str(i)] = simi[:, 0]
        simi_pd["p_value_" + str(i)] = simi[:, 1]
        simi_pd["trend"] = simi_pd["trend"] + simi_pd["up_down_" + str(i)]
    print(simi_pd)
    wil_pos_pd = simi_pd.loc[(simi_pd['trend'] >= 2) & (simi_pd['up_down_0'] == 1),]
    wil_neg_pd = simi_pd.loc[(simi_pd['trend'] <= -2) & (simi_pd['up_down_0'] == -1),]
    wil_pos_pd['trend_each'] = 0
    wil_neg_pd['trend_each'] = 0
    for i in range(len(data.trainDatas_df) - 1):
        wil_pos_pd['trend_each'] = wil_pos_pd['trend_each'] * 10 + wil_pos_pd["up_down_" + str(i)]
        wil_neg_pd['trend_each'] = wil_neg_pd['trend_each'] * 10 + wil_neg_pd["up_down_" + str(i)]

    wil_pos_pd.to_csv(args.result_dir + "wilconxon_pos.csv")
    wil_neg_pd.to_csv(args.result_dir + "wilconxon_neg.csv")

    return simi_pd


def init(dataCache, argsCache):
    global data
    data = dataCache
    global args
    args = argsCache
    return
