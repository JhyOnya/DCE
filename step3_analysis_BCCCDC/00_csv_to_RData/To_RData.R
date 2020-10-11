#######################################################################################################################################################################################
#######################################################################################################################################################################################
#######################################################################################################################################################################################
#######################################################################################################################################################################################
setwd("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/step3_analysis_BCCCDC/00_csv_to_RData/")
######
# 01 #
######
##################################################################################################################################################################################################
nonboth_neg <- list()                                                                                                                                                          #
nonboth_neg[[1]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2/nonboth_neg_COAD.csv",sep = ",",stringsAsFactors = FALSE)[,c(2,3)] #
nonboth_neg[[2]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2/nonboth_neg_KIRC.csv",sep = ",",stringsAsFactors = FALSE)[,c(2,3)] #
nonboth_neg[[3]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2/nonboth_neg_LUAD.csv",sep = ",",stringsAsFactors = FALSE)[,c(2,3)] #
nonboth_neg[[4]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2/nonboth_neg_THCA.csv",sep = ",",stringsAsFactors = FALSE)[,c(2,3)] #
names(nonboth_neg) <- c("COAD","KIRC","LUAD","THCA")                                                                                                                           #
save(nonboth_neg,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/RData/nonboth_neg.RData")                                                        #
##################################################################################################################################################################################################


######
# 02 #
######
##################################################################################################################################################################################################
nonboth_pos <- list()                                                                                                                                                          #
nonboth_pos[[1]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2/nonboth_pos_COAD.csv",sep = ",",stringsAsFactors = FALSE)[,c(2,3)] #
nonboth_pos[[2]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2/nonboth_pos_KIRC.csv",sep = ",",stringsAsFactors = FALSE)[,c(2,3)] #
nonboth_pos[[3]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2/nonboth_pos_LUAD.csv",sep = ",",stringsAsFactors = FALSE)[,c(2,3)] #
nonboth_pos[[4]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2/nonboth_pos_THCA.csv",sep = ",",stringsAsFactors = FALSE)[,c(2,3)] #
names(nonboth_pos) <- c("COAD","KIRC","LUAD","THCA")                                                                                                                           #
save(nonboth_pos,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/RData/nonboth_pos.RData")                                                        #
##################################################################################################################################################################################################






#######################################################################################################################################################################################
#######################################################################################################################################################################################
#######################################################################################################################################################################################
#######################################################################################################################################################################################
######
# 01 #
######
###################################################################################################################################################################################################################
nonboth_subgraph_edges_neg <- list()                                                                                                                                                                       #
nonboth_subgraph_edges_neg[[1]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2/nonboth_subgraph_edges_neg_COAD.csv",sep = ",",stringsAsFactors = FALSE)[,c(2,3)] #
nonboth_subgraph_edges_neg[[2]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2/nonboth_subgraph_edges_neg_KIRC.csv",sep = ",",stringsAsFactors = FALSE)[,c(2,3)] #
nonboth_subgraph_edges_neg[[3]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2/nonboth_subgraph_edges_neg_LUAD.csv",sep = ",",stringsAsFactors = FALSE)[,c(2,3)] #
nonboth_subgraph_edges_neg[[4]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2/nonboth_subgraph_edges_neg_THCA.csv",sep = ",",stringsAsFactors = FALSE)[,c(2,3)] #
names(nonboth_subgraph_edges_neg) <- c("COAD","KIRC","LUAD","THCA")                                                                                                                                        #
save(nonboth_subgraph_edges_neg,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/RData/nonboth_subgraph_edges_neg.RData")                                                                 #
###################################################################################################################################################################################################################


######
# 02 #
######
###################################################################################################################################################################################################################
nonboth_subgraph_edges_pos <- list()                                                                                                                                                                       #
nonboth_subgraph_edges_pos[[1]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2/nonboth_subgraph_edges_pos_COAD.csv",sep = ",",stringsAsFactors = FALSE)[,c(2,3)] #
nonboth_subgraph_edges_pos[[2]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2/nonboth_subgraph_edges_pos_KIRC.csv",sep = ",",stringsAsFactors = FALSE)[,c(2,3)] #
nonboth_subgraph_edges_pos[[3]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2/nonboth_subgraph_edges_pos_LUAD.csv",sep = ",",stringsAsFactors = FALSE)[,c(2,3)] #
nonboth_subgraph_edges_pos[[4]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2/nonboth_subgraph_edges_pos_THCA.csv",sep = ",",stringsAsFactors = FALSE)[,c(2,3)] #
names(nonboth_subgraph_edges_pos) <- c("COAD","KIRC","LUAD","THCA")                                                                                                                                        #
save(nonboth_subgraph_edges_pos,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/RData/nonboth_subgraph_edges_pos.RData")                                                                 #
###################################################################################################################################################################################################################

edges_trend4_neg <- list()
edges_trend4_neg[[1]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/edges_trend4_neg_COAD.csv",sep = ",",stringsAsFactors = FALSE)
edges_trend4_neg[[2]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/edges_trend4_neg_KIRC.csv",sep = ",",stringsAsFactors = FALSE)
edges_trend4_neg[[3]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/edges_trend4_neg_LUAD.csv",sep = ",",stringsAsFactors = FALSE)
edges_trend4_neg[[4]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/edges_trend4_neg_THCA.csv",sep = ",",stringsAsFactors = FALSE)
names(edges_trend4_neg) <- c("COAD","KIRC","LUAD","THCA")
save(edges_trend4_neg,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/RData/edges_trend4_neg.RData")


edges_trend4_pos <- list()
edges_trend4_pos[[1]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/edges_trend4_pos_COAD.csv",sep = ",",stringsAsFactors = FALSE)
edges_trend4_pos[[2]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/edges_trend4_pos_KIRC.csv",sep = ",",stringsAsFactors = FALSE)
edges_trend4_pos[[3]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/edges_trend4_pos_LUAD.csv",sep = ",",stringsAsFactors = FALSE)
edges_trend4_pos[[4]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/edges_trend4_pos_THCA.csv",sep = ",",stringsAsFactors = FALSE)
names(edges_trend4_pos) <- c("COAD","KIRC","LUAD","THCA")
save(edges_trend4_pos,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/RData/edges_trend4_pos.RData")



COAD_wilconxon <- list()
COAD_wilconxon[[1]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_1to23/COAD/wilconxon_pos.csv",sep = ",",stringsAsFactor = FALSE)[,1]
COAD_wilconxon[[2]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_1to23/COAD/wilconxon_neg.csv",sep = ",",stringsAsFactor = FALSE)[,1]
names(COAD_wilconxon) <- c("pos","neg")


KIRC_wilconxon <- list()
KIRC_wilconxon[[1]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_1to23/KIRC/wilconxon_pos.csv",sep = ",",stringsAsFactor = FALSE)[,1]
KIRC_wilconxon[[2]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_1to23/KIRC/wilconxon_neg.csv",sep = ",",stringsAsFactor = FALSE)[,1]
names(KIRC_wilconxon) <- c("pos","neg")


LUAD_wilconxon <- list()
LUAD_wilconxon[[1]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_1to23/LUAD/wilconxon_pos.csv",sep = ",",stringsAsFactor = FALSE)[,1]
LUAD_wilconxon[[2]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_1to23/LUAD/wilconxon_neg.csv",sep = ",",stringsAsFactor = FALSE)[,1]
names(LUAD_wilconxon) <- c("pos","neg")


THCA_wilconxon <- list()
THCA_wilconxon[[1]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_1to23/THCA/wilconxon_pos.csv",sep = ",",stringsAsFactor = FALSE)[,1]
THCA_wilconxon[[2]] <- read.csv("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_1to23/THCA/wilconxon_neg.csv",sep = ",",stringsAsFactor = FALSE)[,1]
names(THCA_wilconxon) <- c("pos","neg")

save(COAD_wilconxon,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/RData/COAD_wilconxon.RData")
save(KIRC_wilconxon,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/RData/KIRC_wilconxon.RData")
save(LUAD_wilconxon,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/RData/LUAD_wilconxon.RData")
save(THCA_wilconxon,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/RData/THCA_wilconxon.RData")













