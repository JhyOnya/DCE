# 设置运行路径
setwd("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/step3_analysis_BCCCDC/04_Wilconxon_Differential_Coexpression/")
####################################################################################################
####################################################################################################
###################### 四、这里我们对差异表达的基因进行富集分析 ####################################
####################################################################################################
####################################################################################################


######
# 01 #
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


######
# 02 #
############################################################
# 首先我们载入以下富集分析所必须的数据：                   #
########################################################################################################################################################################
#
Gene_List <- read.table("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/RData/gene_symbol_list.txt",sep = "\t",stringsAsFactors = FALSE)            #
#
load("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/RData/all_pathway_canonica_GO_bp_unify.1.RData")                                               #
########################################################################################################################################################################


######
# 03 #
########
# COAD #
#############################################################################################################################################################################
# 导入 COAD 差异表达基因的数据                                                                                                                                              #
load("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/RData/COAD_wilconxon.RData")                                                                        #
# 创建存放COAD富集分析的结果的列表                                                                                                                                          #
COAD_wilconxon_GO <- list()                                                                                                                                                 #
# 对上升和下降的网络中的差异表达的基因进行富集分析                                                                                                                          #
for (i in 1:2) {                                                                                                                                                            #
  print(i)                                                                                                                                                                  #
  Gene_List <- as.character(unlist(Gene_List[,1]))                                                                                                                          #
  Cancer_Gene_List <- as.character(unlist(COAD_wilconxon[[i]]))                                                                                                             #
  #                                                                                                                                                                         #
  site1 <- which((Gene_List %in% Cancer_Gene_List)  == TRUE)                                                                                                                #
  site2 <- which((Gene_List %in% Cancer_Gene_List)  == FALSE)                                                                                                               #
  #                                                                                                                                                                         #
  Gene_List <- as.data.frame(Gene_List,stringsAsFactors = FALSE)                                                                                                            #
  Gene_List[site1,2] <- 1                                                                                                                                                   #
  Gene_List[site2,2] <- 0                                                                                                                                                   #
  #                                                                                                                                                                         #
  COAD_wilconxon_GO[[i]] <- Enrichment(Gene_List)                                                                                                                           #
}                                                                                                                                                                           #
names(COAD_wilconxon_GO) <- names(COAD_wilconxon)                                                                                                                           #
save(COAD_wilconxon_GO,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/04_Wilconxon_Differential_Coexpression/Enrichment/COAD_wilconxon_GO.RData")   #
#############################################################################################################################################################################



######
# 04 #
########
# KIRC #
#############################################################################################################################################################################
load("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/RData/KIRC_wilconxon.RData")                                                                        #
#                                                                                                                                                                           #
KIRC_wilconxon_GO <- list()                                                                                                                                                 #
for (i in 1:2) {                                                                                                                                                            #
  print(i)                                                                                                                                                                  #
  Gene_List <- as.character(unlist(Gene_List[,1]))                                                                                                                          #
  Cancer_Gene_List <- as.character(unlist(KIRC_wilconxon[[i]]))                                                                                                             #
  #                                                                                                                                                                         #
  site1 <- which((Gene_List %in% Cancer_Gene_List)  == TRUE)                                                                                                                #
  site2 <- which((Gene_List %in% Cancer_Gene_List)  == FALSE)                                                                                                               #
  #                                                                                                                                                                         #
  Gene_List <- as.data.frame(Gene_List,stringsAsFactors = FALSE)                                                                                                            #
  Gene_List[site1,2] <- 1                                                                                                                                                   #
  Gene_List[site2,2] <- 0                                                                                                                                                   #
  #                                                                                                                                                                         #
  KIRC_wilconxon_GO[[i]] <- Enrichment(Gene_List)                                                                                                                           #
}                                                                                                                                                                           #
names(KIRC_wilconxon_GO) <- names(KIRC_wilconxon)                                                                                                                           #
save(KIRC_wilconxon_GO,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/04_Wilconxon_Differential_Coexpression/Enrichment/KIRC_wilconxon_GO.RData")   #
#############################################################################################################################################################################




######
# 05 #
########
# LUAD #
#############################################################################################################################################################################
load("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/RData/LUAD_wilconxon.RData")                                                                        #
#                                                                                                                                                                           #
LUAD_wilconxon_GO <- list()                                                                                                                                                 #
for (i in 1:2) {                                                                                                                                                            #
  print(i)                                                                                                                                                                  #
  Gene_List <- as.character(unlist(Gene_List[,1]))                                                                                                                          #
  Cancer_Gene_List <- as.character(unlist(LUAD_wilconxon[[i]]))                                                                                                             #
  #                                                                                                                                                                         #
  site1 <- which((Gene_List %in% Cancer_Gene_List)  == TRUE)                                                                                                                #
  site2 <- which((Gene_List %in% Cancer_Gene_List)  == FALSE)                                                                                                               #
  #                                                                                                                                                                         #
  Gene_List <- as.data.frame(Gene_List,stringsAsFactors = FALSE)                                                                                                            #
  Gene_List[site1,2] <- 1                                                                                                                                                   #
  Gene_List[site2,2] <- 0                                                                                                                                                   #
  #                                                                                                                                                                         #
  LUAD_wilconxon_GO[[i]] <- Enrichment(Gene_List)                                                                                                                           #
}                                                                                                                                                                           #
names(LUAD_wilconxon_GO) <- names(LUAD_wilconxon)                                                                                                                           #
save(LUAD_wilconxon_GO,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/04_Wilconxon_Differential_Coexpression/Enrichment/LUAD_wilconxon_GO.RData")   #
#############################################################################################################################################################################


######
# 06 #
########
# THCA #
#############################################################################################################################################################################
load("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/RData/THCA_wilconxon.RData")                                                                        #
#                                                                                                                                                                           #
THCA_wilconxon_GO <- list()                                                                                                                                                 #
for (i in 1:2) {                                                                                                                                                            #
  print(i)                                                                                                                                                                  #
  Gene_List <- as.character(unlist(Gene_List[,1]))                                                                                                                          #
  Cancer_Gene_List <- as.character(unlist(THCA_wilconxon[[i]]))                                                                                                             #
  #                                                                                                                                                                         #
  site1 <- which((Gene_List %in% Cancer_Gene_List)  == TRUE)                                                                                                                #
  site2 <- which((Gene_List %in% Cancer_Gene_List)  == FALSE)                                                                                                               #
  #                                                                                                                                                                         #
  Gene_List <- as.data.frame(Gene_List,stringsAsFactors = FALSE)                                                                                                            #
  Gene_List[site1,2] <- 1                                                                                                                                                   #
  Gene_List[site2,2] <- 0                                                                                                                                                   #
  #                                                                                                                                                                         #
  THCA_wilconxon_GO[[i]] <- Enrichment(Gene_List)                                                                                                                           #
}                                                                                                                                                                           #
names(THCA_wilconxon_GO) <- names(THCA_wilconxon)                                                                                                                           #
save(THCA_wilconxon_GO,file = "/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/04_Wilconxon_Differential_Coexpression/Enrichment/THCA_wilconxon_GO.RData")   #
#############################################################################################################################################################################



