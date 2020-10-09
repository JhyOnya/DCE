####################################################################################################
############################ 一、这里我们对Node2、3、4中的节点进行富集分析 #########################
####################################################################################################


######
# 01 #
#########################################################
# 导入前期需要的数据：                                  #
# 1、gene_symbol_list.txt：基因列表                     #
# 2、all_pathway_canonica_GO_bp_unify.1.RData：通路数据 #
############################################################################################################################################################
Gene_List <- read.table("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_2to3/RData/gene_symbol_list.txt",sep = "\t",stringsAsFactors = FALSE)#
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_2to3/RData/all_pathway_canonica_GO_bp_unify.1.RData")                                   #
############################################################################################################################################################


######
# 02 #
#####################################################################
# Here we write the function of enrichment analysis                 #
# parameter datafile：List of genes we need for enrichment analysis #
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
# 03 #
###########################
# Import Node2, 3, 4 data #
############################################################################################################################################
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/01_Coexpression_Trend_Node_Degree/0103_Degree_Greater5/Node2.RData")  #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/01_Coexpression_Trend_Node_Degree/0103_Degree_Greater5/Node3.RData")  #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/01_Coexpression_Trend_Node_Degree/0103_Degree_Greater5/Node4.RData")  #
############################################################################################################################################


######
# 04 #
################################################
# Create a list of enrichment analysis results #
################################################
Node2_GO <- list()                             #
Node3_GO <- list()                             #
Node4_GO <- list()                             #
################################################


######
# 05 #
###############################
# Perform enrichment analysis #
###################################################################
for (j in 1:4) {                                                  #
  print("Node2")                                                  #
  Gene_List <- as.character(unlist(Gene_List[,1]))                #
  Cancer_Gene_List <- as.character(unlist(Node2[[j]]))            #
  #                                                               #
  site1 <- which((Gene_List %in% Cancer_Gene_List)  == TRUE)      #
  site2 <- which((Gene_List %in% Cancer_Gene_List)  == FALSE)     #
  #                                                               #
  Gene_List <- as.data.frame(Gene_List,stringsAsFactors = FALSE)  #
  Gene_List[site1,2] <- 1                                         #
  Gene_List[site2,2] <- 0                                         #
  #                                                               #
  Node2_GO[[j]] <- Enrichment(Gene_List)                          #
  #                                                               #
  print("Node3")                                                  #
  Gene_List <- as.character(unlist(Gene_List[,1]))                #
  Cancer_Gene_List <- as.character(unlist(Node3[[j]]))            #
  #                                                               #
  site1 <- which((Gene_List %in% Cancer_Gene_List)  == TRUE)      #
  site2 <- which((Gene_List %in% Cancer_Gene_List)  == FALSE)     #
  #                                                               #
  Gene_List <- as.data.frame(Gene_List,stringsAsFactors = FALSE)  #
  Gene_List[site1,2] <- 1                                         #
  Gene_List[site2,2] <- 0                                         #
  #                                                               #
  Node3_GO[[j]] <- Enrichment(Gene_List)                          #
  #                                                               #
  print("Node4")                                                  #
  Gene_List <- as.character(unlist(Gene_List[,1]))                #
  Cancer_Gene_List <- as.character(unlist(Node4[[j]]))            #
  #                                                               #
  site1 <- which((Gene_List %in% Cancer_Gene_List)  == TRUE)      #
  site2 <- which((Gene_List %in% Cancer_Gene_List)  == FALSE)     #
  #                                                               #
  Gene_List <- as.data.frame(Gene_List,stringsAsFactors = FALSE)  #
  Gene_List[site1,2] <- 1                                         #
  Gene_List[site2,2] <- 0                                         #
  #                                                               #
  Node4_GO[[j]] <- Enrichment(Gene_List)                          #
}                                                                 #
###################################################################


######
# 05 #
############################
# Name and store the list  #
##############################################################################################################################################################
names(Node2_GO) <- names(Node2)                                                                                                                              #
names(Node3_GO) <- names(Node2)                                                                                                                              #
names(Node4_GO) <- names(Node2)                                                                                                                              #
save(Node2_GO,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/01_Coexpression_Trend_Node_Degree/0103_Node2_3_4_GO/Node2_GO.RData")    #
save(Node3_GO,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/01_Coexpression_Trend_Node_Degree/0103_Node2_3_4_GO/Node3_GO.RData")    #
save(Node4_GO,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/01_Coexpression_Trend_Node_Degree/0103_Node2_3_4_GO/Node4_GO.RData")    #
##############################################################################################################################################################