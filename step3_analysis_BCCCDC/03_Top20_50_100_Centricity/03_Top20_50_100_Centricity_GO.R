# Set running path
setwd("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/step3_analysis_BCCCDC/03_Top20_50_100_Centricity/")
###################################################################################################################################################################################
###################################################################################################################################################################################
### 三、Here we perform a functional enrichment analysis on the first 20, 50, and 100 intersection nodes of the rising and falling in the largest connected subgraph taken out ####
###################################################################################################################################################################################
###################################################################################################################################################################################


######
# 01 #
#########################################################
# Import the required data                              #
############################################################################################################################################################
Gene_List <- read.table("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/RData/gene_symbol_list.txt",sep = "\t",stringsAsFactors = FALSE)#
load("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/RData/all_pathway_canonica_GO_bp_unify.1.RData")                                   #
############################################################################################################################################################


######
# 02 #
###############################################################
# Here we write the function of enrichment analysis           #
# 参数datafile：List of genes we need for enrichment analysis #
###########################################################################################################################################
###########################################################################################################################################
Enrichment <- function(datafile){                                                                                                         #
  data=datafile                                                                                                                           #
  up=data[data[,2]==1,1]                                                                                                                  #
  all_pathway=all_pathway_canonica_GO_bp_unify.1                                                                                          #
  all_symbol=data[,1]                                                                                                                     #
  all_list=as.character(unique(all_pathway[,1]))                                                                                          #
  pathway_enrich_up=NULL                                                                                                                  #
  pvalue=c()                                                                                                                              #
  for(i in 1:length(all_list)){                                                                                                           #
    gene_pathway=as.character(all_pathway[which(all_pathway[,1]==all_list[i]),2])                                                         #
    up_no=length(intersect(gene_pathway,up))                                                                                              #
    hit_no=length(intersect(gene_pathway,all_symbol))                                                                                     #
    pval_up=1-phyper(up_no,length(up),length(all_symbol)-length(up),hit_no)                                                               #
    pathway_enrich_up=rbind(pathway_enrich_up,list(as.character(all_list[i]),pval_up,up_no,hit_no,intersect(gene_pathway,up)))            #
    pvalue=c(pvalue,pval_up)                                                                                                              #
  }                                                                                                                                       #
  pathway_enrich_up <- data.frame(pathway_enrich_up,stringsAsFactors = FALSE)                                                             #
  colnames(pathway_enrich_up)=c("pathway","pval_up","up_no","hit_no","gene_list")                                                        ##
  oid=order(as.numeric(pvalue))                                                                                                          ##
  final_pathway_enrich_up=pathway_enrich_up[oid,]                                                                                        ##
  return(final_pathway_enrich_up)                                                                                                        ##
}                                                                                                                                        ##
###########################################################################################################################################
###########################################################################################################################################



############
# 02：COAD #
######################################################################################################
# Here we perform enrichment analysis on the intersection of the first 20, 50, and 100 nodes of COAD #
########################################################################################################################################################################################
# Import the data of the intersection of COAD Top 20, 50, and 100 nodes                                                                                                                #
load("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/COAD_Centricity_Top20.RData")                                #
load("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/COAD_Centricity_Top50.RData")                                #
load("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/COAD_Centricity_Top100.RData")                               #
COAD_Centricity_Top20[[1]] <- na.omit(COAD_Centricity_Top20[[1]])                                                                                                                      #
COAD_Centricity_Top20[[2]] <- na.omit(COAD_Centricity_Top20[[2]])                                                                                                                      #
COAD_Centricity_Top50[[1]] <- na.omit(COAD_Centricity_Top50[[1]])                                                                                                                      #
COAD_Centricity_Top50[[2]] <- na.omit(COAD_Centricity_Top50[[2]])                                                                                                                      #
COAD_Centricity_Top100[[1]] <- na.omit(COAD_Centricity_Top100[[1]])                                                                                                                    #
COAD_Centricity_Top100[[2]] <- na.omit(COAD_Centricity_Top100[[2]])                                                                                                                    #

COAD_Centricity_Top20_GO <- list()                                                                                                                                                     #
COAD_Centricity_Top50_GO <- list()                                                                                                                                                     #
COAD_Centricity_Top100_GO <- list()                                                                                                                                                    #

for (i in 1:2) {                                                                                                                                                                       #
  print(i)                                                                                                                                                                             #
  
  Gene_List20 <- as.character(unlist(Gene_List[,1]))                                                                                                                                   #
  Gene_List50 <- as.character(unlist(Gene_List[,1]))                                                                                                                                   #
  Gene_List100 <- as.character(unlist(Gene_List[,1]))                                                                                                                                  #
  
  Cancer_Gene_List20 <- as.character(unlist(COAD_Centricity_Top20[[i]]))                                                                                                               #
  Cancer_Gene_List50 <- as.character(unlist(COAD_Centricity_Top50[[i]]))                                                                                                               #
  Cancer_Gene_List100 <- as.character(unlist(COAD_Centricity_Top100[[i]]))                                                                                                             #
  # Top20                                                                                                                                                                              #
  site20_1 <- which((Gene_List20 %in% Cancer_Gene_List20)  == TRUE)                                                                                                                    #
  site20_2 <- which((Gene_List20 %in% Cancer_Gene_List20)  == FALSE)                                                                                                                   #
  # Top50                                                                                                                                                                              #
  site50_1 <- which((Gene_List50 %in% Cancer_Gene_List50)  == TRUE)                                                                                                                    #
  site50_2 <- which((Gene_List50 %in% Cancer_Gene_List50)  == FALSE)                                                                                                                   #
  # Top100                                                                                                                                                                             #
  site100_1 <- which((Gene_List100 %in% Cancer_Gene_List100)  == TRUE)                                                                                                                 #
  site100_2 <- which((Gene_List100 %in% Cancer_Gene_List100)  == FALSE)                                                                                                                #
  # Top20
  Gene_List20 <- as.data.frame(Gene_List20,stringsAsFactors = FALSE)                                                                                                                   #
  Gene_List20[site20_1,2] <- 1                                                                                                                                                         #
  Gene_List20[site20_2,2] <- 0                                                                                                                                                         #
  COAD_Centricity_Top20_GO[[i]] <- Enrichment(Gene_List20)                                                                                                                             #
  # Top50
  Gene_List50 <- as.data.frame(Gene_List50,stringsAsFactors = FALSE)                                                                                                                   #
  Gene_List50[site50_1,2] <- 1                                                                                                                                                         #
  Gene_List50[site50_2,2] <- 0                                                                                                                                                         #
  COAD_Centricity_Top50_GO[[i]] <- Enrichment(Gene_List50)                                                                                                                             #
  # Top100
  Gene_List100 <- as.data.frame(Gene_List100,stringsAsFactors = FALSE)                                                                                                                 #
  Gene_List100[site100_1,2] <- 1                                                                                                                                                       #
  Gene_List100[site100_2,2] <- 0                                                                                                                                                       #
  COAD_Centricity_Top100_GO[[i]] <- Enrichment(Gene_List100)                                                                                                                           #
}                                                                                                                                                                                      #
#                                                                                                                                                                                      #
names(COAD_Centricity_Top20_GO) <- names(COAD_Centricity_Top20)                                                                                                                        #
names(COAD_Centricity_Top50_GO) <- names(COAD_Centricity_Top50)                                                                                                                        #
names(COAD_Centricity_Top100_GO) <- names(COAD_Centricity_Top100)                                                                                                                      #
#                                                                                                                                                                                      #
save(COAD_Centricity_Top20_GO,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/03_Enrichment/Top20/COAD_Centricity_Top20_GO.RData")   #
save(COAD_Centricity_Top50_GO,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/03_Enrichment/Top50/COAD_Centricity_Top50_GO.RData")   #
save(COAD_Centricity_Top100_GO,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/03_Enrichment/Top100/COAD_Centricity_Top100_GO.RData")#
########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################


############
# 03：KIRC #
######################################################################################################
# Here we perform enrichment analysis on the intersection of the first 20, 50, and 100 nodes of KIRC #
########################################################################################################################################################################################
# Import the data of the intersection of KIRC Top20, 50, and 100 nodes                                                                                                                 #
load("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/KIRC_Centricity_Top20.RData")                                #
load("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/KIRC_Centricity_Top50.RData")                                #
load("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/KIRC_Centricity_Top100.RData")                               #

KIRC_Centricity_Top20[[1]] <- na.omit(KIRC_Centricity_Top20[[1]])                                                                                                                      #
KIRC_Centricity_Top20[[2]] <- na.omit(KIRC_Centricity_Top20[[2]])                                                                                                                      #
KIRC_Centricity_Top50[[1]] <- na.omit(KIRC_Centricity_Top50[[1]])                                                                                                                      #
KIRC_Centricity_Top50[[2]] <- na.omit(KIRC_Centricity_Top50[[2]])                                                                                                                      #
KIRC_Centricity_Top100[[1]] <- na.omit(KIRC_Centricity_Top100[[1]])                                                                                                                    #
KIRC_Centricity_Top100[[2]] <- na.omit(KIRC_Centricity_Top100[[2]])                                                                                                                    #

KIRC_Centricity_Top20_GO <- list()                                                                                                                                                     #
KIRC_Centricity_Top50_GO <- list()                                                                                                                                                     #
KIRC_Centricity_Top100_GO <- list()                                                                                                                                                    #

for (i in 1:2) {                                                                                                                                                                       #
  print(i)                                                                                                                                                                             #
  
  Gene_List20 <- as.character(unlist(Gene_List[,1]))                                                                                                                                   #
  Gene_List50 <- as.character(unlist(Gene_List[,1]))                                                                                                                                   #
  Gene_List100 <- as.character(unlist(Gene_List[,1]))                                                                                                                                  #
  
  Cancer_Gene_List20 <- as.character(unlist(KIRC_Centricity_Top20[[i]]))                                                                                                               #
  Cancer_Gene_List50 <- as.character(unlist(KIRC_Centricity_Top50[[i]]))                                                                                                               #
  Cancer_Gene_List100 <- as.character(unlist(KIRC_Centricity_Top100[[i]]))                                                                                                             #
  # Top20                                                                                                                                                                              #
  site20_1 <- which((Gene_List20 %in% Cancer_Gene_List20)  == TRUE)                                                                                                                    #
  site20_2 <- which((Gene_List20 %in% Cancer_Gene_List20)  == FALSE)                                                                                                                   #
  # Top50                                                                                                                                                                              #
  site50_1 <- which((Gene_List50 %in% Cancer_Gene_List50)  == TRUE)                                                                                                                    #
  site50_2 <- which((Gene_List50 %in% Cancer_Gene_List50)  == FALSE)                                                                                                                   #
  # Top100                                                                                                                                                                             #
  site100_1 <- which((Gene_List100 %in% Cancer_Gene_List100)  == TRUE)                                                                                                                 #
  site100_2 <- which((Gene_List100 %in% Cancer_Gene_List100)  == FALSE)                                                                                                                #
  # Top20
  Gene_List20 <- as.data.frame(Gene_List20,stringsAsFactors = FALSE)                                                                                                                   #
  Gene_List20[site20_1,2] <- 1                                                                                                                                                         #
  Gene_List20[site20_2,2] <- 0                                                                                                                                                         #
  KIRC_Centricity_Top20_GO[[i]] <- Enrichment(Gene_List20)                                                                                                                             #
  # Top50
  Gene_List50 <- as.data.frame(Gene_List50,stringsAsFactors = FALSE)                                                                                                                   #
  Gene_List50[site50_1,2] <- 1                                                                                                                                                         #
  Gene_List50[site50_2,2] <- 0                                                                                                                                                         #
  KIRC_Centricity_Top50_GO[[i]] <- Enrichment(Gene_List50)                                                                                                                             #
  # Top10
  Gene_List100 <- as.data.frame(Gene_List100,stringsAsFactors = FALSE)                                                                                                                 #
  Gene_List100[site100_1,2] <- 1                                                                                                                                                       #
  Gene_List100[site100_2,2] <- 0                                                                                                                                                       #
  KIRC_Centricity_Top100_GO[[i]] <- Enrichment(Gene_List100)                                                                                                                           #
}                                                                                                                                                                                      #
#
names(KIRC_Centricity_Top20_GO) <- names(KIRC_Centricity_Top20)                                                                                                                        #
names(KIRC_Centricity_Top50_GO) <- names(KIRC_Centricity_Top50)                                                                                                                        #
names(KIRC_Centricity_Top100_GO) <- names(KIRC_Centricity_Top100)                                                                                                                      #
#
save(KIRC_Centricity_Top20_GO,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/03_Enrichment/Top20/KIRC_Centricity_Top20_GO.RData")   #
save(KIRC_Centricity_Top50_GO,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/03_Enrichment/Top50/KIRC_Centricity_Top50_GO.RData")   #
save(KIRC_Centricity_Top100_GO,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/03_Enrichment/Top100/KIRC_Centricity_Top100_GO.RData")#
########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################



############
# 04：LUAD #
#########################################################
# 这里我们对 LUAD 的前20、50、100节点的交集进行富集分析 #
########################################################################################################################################################################################
# Import the data of the intersection of LUAD Top20, 50, and 100 nodes                                                                                                                 #
load("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/LUAD_Centricity_Top20.RData")                                #
load("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/LUAD_Centricity_Top50.RData")                                #
load("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/LUAD_Centricity_Top100.RData")                               #
#
LUAD_Centricity_Top20[[1]] <- na.omit(LUAD_Centricity_Top20[[1]])                                                                                                                      #
LUAD_Centricity_Top20[[2]] <- na.omit(LUAD_Centricity_Top20[[2]])                                                                                                                      #
LUAD_Centricity_Top50[[1]] <- na.omit(LUAD_Centricity_Top50[[1]])                                                                                                                      #
LUAD_Centricity_Top50[[2]] <- na.omit(LUAD_Centricity_Top50[[2]])                                                                                                                      #
LUAD_Centricity_Top100[[1]] <- na.omit(LUAD_Centricity_Top100[[1]])                                                                                                                    #
LUAD_Centricity_Top100[[2]] <- na.omit(LUAD_Centricity_Top100[[2]])                                                                                                                    #
#
LUAD_Centricity_Top20_GO <- list()                                                                                                                                                     #
LUAD_Centricity_Top50_GO <- list()                                                                                                                                                     #
LUAD_Centricity_Top100_GO <- list()                                                                                                                                                    #
#
for (i in 1:2) {                                                                                                                                                                       #
  print(i)                                                                                                                                                                             #
  #
  Gene_List20 <- as.character(unlist(Gene_List[,1]))                                                                                                                                   #
  Gene_List50 <- as.character(unlist(Gene_List[,1]))                                                                                                                                   #
  Gene_List100 <- as.character(unlist(Gene_List[,1]))                                                                                                                                  #
  #
  Cancer_Gene_List20 <- as.character(unlist(LUAD_Centricity_Top20[[i]]))                                                                                                               #
  Cancer_Gene_List50 <- as.character(unlist(LUAD_Centricity_Top50[[i]]))                                                                                                               #
  Cancer_Gene_List100 <- as.character(unlist(LUAD_Centricity_Top100[[i]]))                                                                                                             #
  # Top20                                                                                                                                                                              #
  site20_1 <- which((Gene_List20 %in% Cancer_Gene_List20)  == TRUE)                                                                                                                    #
  site20_2 <- which((Gene_List20 %in% Cancer_Gene_List20)  == FALSE)                                                                                                                   #
  # Top50                                                                                                                                                                              #
  site50_1 <- which((Gene_List50 %in% Cancer_Gene_List50)  == TRUE)                                                                                                                    #
  site50_2 <- which((Gene_List50 %in% Cancer_Gene_List50)  == FALSE)                                                                                                                   #
  # Top100                                                                                                                                                                             #
  site100_1 <- which((Gene_List100 %in% Cancer_Gene_List100)  == TRUE)                                                                                                                 #
  site100_2 <- which((Gene_List100 %in% Cancer_Gene_List100)  == FALSE)                                                                                                                #
  # Top20
  Gene_List20 <- as.data.frame(Gene_List20,stringsAsFactors = FALSE)                                                                                                                   #
  Gene_List20[site20_1,2] <- 1                                                                                                                                                         #
  Gene_List20[site20_2,2] <- 0                                                                                                                                                         #
  LUAD_Centricity_Top20_GO[[i]] <- Enrichment(Gene_List20)                                                                                                                             #
  # Top50
  Gene_List50 <- as.data.frame(Gene_List50,stringsAsFactors = FALSE)                                                                                                                   #
  Gene_List50[site50_1,2] <- 1                                                                                                                                                         #
  Gene_List50[site50_2,2] <- 0                                                                                                                                                         #
  LUAD_Centricity_Top50_GO[[i]] <- Enrichment(Gene_List50)                                                                                                                             #
  # Top100
  Gene_List100 <- as.data.frame(Gene_List100,stringsAsFactors = FALSE)                                                                                                                 #
  Gene_List100[site100_1,2] <- 1                                                                                                                                                       #
  Gene_List100[site100_2,2] <- 0                                                                                                                                                       #
  LUAD_Centricity_Top100_GO[[i]] <- Enrichment(Gene_List100)                                                                                                                           #
}                                                                                                                                                                                      #
#
names(LUAD_Centricity_Top20_GO) <- names(LUAD_Centricity_Top20)                                                                                                                        #
names(LUAD_Centricity_Top50_GO) <- names(LUAD_Centricity_Top50)                                                                                                                        #
names(LUAD_Centricity_Top100_GO) <- names(LUAD_Centricity_Top100)                                                                                                                      #
#
save(LUAD_Centricity_Top20_GO,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/03_Enrichment/Top20/LUAD_Centricity_Top20_GO.RData")   #
save(LUAD_Centricity_Top50_GO,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/03_Enrichment/Top50/LUAD_Centricity_Top50_GO.RData")   #
save(LUAD_Centricity_Top100_GO,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/03_Enrichment/Top100/LUAD_Centricity_Top100_GO.RData")#
########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################



############
# 05：THCA #
######################################################################################################
# Here we perform enrichment analysis on the intersection of the first 20, 50, and 100 nodes of THCA #
########################################################################################################################################################################################
# Import the data of the intersection of THCA Top20, 50, and 100 nodes                                                                                                                  #
load("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/THCA_Centricity_Top20.RData")                                #
load("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/THCA_Centricity_Top50.RData")                                #
load("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/THCA_Centricity_Top100.RData")                               #
#
THCA_Centricity_Top20[[1]] <- na.omit(THCA_Centricity_Top20[[1]])                                                                                                                      #
THCA_Centricity_Top20[[2]] <- na.omit(THCA_Centricity_Top20[[2]])                                                                                                                      #
THCA_Centricity_Top50[[1]] <- na.omit(THCA_Centricity_Top50[[1]])                                                                                                                      #
THCA_Centricity_Top50[[2]] <- na.omit(THCA_Centricity_Top50[[2]])                                                                                                                      #
THCA_Centricity_Top100[[1]] <- na.omit(THCA_Centricity_Top100[[1]])                                                                                                                    #
THCA_Centricity_Top100[[2]] <- na.omit(THCA_Centricity_Top100[[2]])                                                                                                                    #
#
THCA_Centricity_Top20_GO <- list()                                                                                                                                                     #
THCA_Centricity_Top50_GO <- list()                                                                                                                                                     #
THCA_Centricity_Top100_GO <- list()                                                                                                                                                    #
#
for (i in 1:2) {                                                                                                                                                                       #
  print(i)                                                                                                                                                                             #
  #
  Gene_List20 <- as.character(unlist(Gene_List[,1]))                                                                                                                                   #
  Gene_List50 <- as.character(unlist(Gene_List[,1]))                                                                                                                                   #
  Gene_List100 <- as.character(unlist(Gene_List[,1]))                                                                                                                                  #
  #
  Cancer_Gene_List20 <- as.character(unlist(THCA_Centricity_Top20[[i]]))                                                                                                               #
  Cancer_Gene_List50 <- as.character(unlist(THCA_Centricity_Top50[[i]]))                                                                                                               #
  Cancer_Gene_List100 <- as.character(unlist(THCA_Centricity_Top100[[i]]))                                                                                                             #
  # Top20                                                                                                                                                                              #
  site20_1 <- which((Gene_List20 %in% Cancer_Gene_List20)  == TRUE)                                                                                                                    #
  site20_2 <- which((Gene_List20 %in% Cancer_Gene_List20)  == FALSE)                                                                                                                   #
  # Top50                                                                                                                                                                              #
  site50_1 <- which((Gene_List50 %in% Cancer_Gene_List50)  == TRUE)                                                                                                                    #
  site50_2 <- which((Gene_List50 %in% Cancer_Gene_List50)  == FALSE)                                                                                                                   #
  # Top100                                                                                                                                                                             #
  site100_1 <- which((Gene_List100 %in% Cancer_Gene_List100)  == TRUE)                                                                                                                 #
  site100_2 <- which((Gene_List100 %in% Cancer_Gene_List100)  == FALSE)                                                                                                                #
  # Top20
  Gene_List20 <- as.data.frame(Gene_List20,stringsAsFactors = FALSE)                                                                                                                   #
  Gene_List20[site20_1,2] <- 1                                                                                                                                                         #
  Gene_List20[site20_2,2] <- 0                                                                                                                                                         #
  THCA_Centricity_Top20_GO[[i]] <- Enrichment(Gene_List20)                                                                                                                             #
  # Top50
  Gene_List50 <- as.data.frame(Gene_List50,stringsAsFactors = FALSE)                                                                                                                   #
  Gene_List50[site50_1,2] <- 1                                                                                                                                                         #
  Gene_List50[site50_2,2] <- 0                                                                                                                                                         #
  THCA_Centricity_Top50_GO[[i]] <- Enrichment(Gene_List50)                                                                                                                             #
  # Top100
  Gene_List100 <- as.data.frame(Gene_List100,stringsAsFactors = FALSE)                                                                                                                 #
  Gene_List100[site100_1,2] <- 1                                                                                                                                                       #
  Gene_List100[site100_2,2] <- 0                                                                                                                                                       #
  THCA_Centricity_Top100_GO[[i]] <- Enrichment(Gene_List100)                                                                                                                           #
}                                                                                                                                                                                      #
#
names(THCA_Centricity_Top20_GO) <- names(THCA_Centricity_Top20)                                                                                                                        #
names(THCA_Centricity_Top50_GO) <- names(THCA_Centricity_Top50)                                                                                                                        #
names(THCA_Centricity_Top100_GO) <- names(THCA_Centricity_Top100)                                                                                                                      #
#
save(THCA_Centricity_Top20_GO,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/03_Enrichment/Top20/THCA_Centricity_Top20_GO.RData")   #
save(THCA_Centricity_Top50_GO,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/03_Enrichment/Top50/THCA_Centricity_Top50_GO.RData")   #
save(THCA_Centricity_Top100_GO,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/03_Enrichment/Top100/THCA_Centricity_Top100_GO.RData")#
########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################