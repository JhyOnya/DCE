# Set running path
setwd("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/step3_analysis_BCCCDC/02_Calculate_Centricity/")
###############################################################################################################################################################
###################### 二、Calculate the centrality of each node in the largest connected subgraph in the rising and falling network ##########################
###############################################################################################################################################################
# Here we calculate the three centrality degrees of the progressiveness of the maximum connected subgraph in the obtained ascending and descending network    #
# 1、Import the largest connected subgraph, the data format is: two columns of nodes；                                                                        #
# 2、Here I use the igraph package and write a function myself: init.igraph calculates the centrality of nodes in the network；                               #
# 3、The three centralities of each cancer we will store here in the list of corresponding cancers, the names of the lists are：                              #
#  （1）COAD_Centricity_neg                                                                                                                                   #
#  （2）KIRC_Centricity_neg                                                                                                                                   #
#  （3）LUAD_Centricity_neg                                                                                                                                   #
#  （4）THCA_Centricity_neg                                                                                                                                   #
###############################################################################################################################################################

install.packages("igraph")
######
# 01 #
###############################################################################################
# Load the R package igraph and create the init.igraph function to calculate node centrality；#
###############################################################################################
library(igraph)                                                                              ##
init.igraph<-function(data,dir=F,rem.multi=T)                                                ##
{                                                                                            ##
  labels<-union(unique(data[,1]),unique(data[,2]))                                           ##
  ids<-1:length(labels);names(ids)<-labels                                                   ##
  from<-as.character(data[,1]);to<-as.character(data[,2])                                    ##
  edges<-matrix(c(ids[from],ids[to]),nc=2)                                                   ##
  g<-graph.empty(directed = dir)                                                             ##
  g<-add.vertices(g,length(labels))                                                          ##
  V(g)$label=labels                                                                          ##
  g<-add.edges(g,t(edges))                                                                   ##
  if (rem.multi)                                                                             ##
  {                                                                                          ##
    E(g)$weight<-count.multiple(g)                                                           ##
    g<-simplify(g,remove.multiple = TRUE,                                                    ##
                remove.loops = TRUE,edge.attr.comb = "mean")                                 ##
  }                                                                                          ##
  g                                                                                          ##
}                                                                                            ##
###############################################################################################
###############################################################################################


######
# 02 #
##################################################
# Import the largest connected subgraph network；#
# The data form is two columns of nodes；        #
##################################################################################################################
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_2to3/RData/nonboth_subgraph_edges_neg.RData") #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_2to3/RData/nonboth_subgraph_edges_pos.RData") #
##################################################################################################################


######
# 03 #
###################################################################################################
# Create three centralities that store the nodes in the largest connected subgraph of each cancer #
###################################################################################################
# 03-01：Down trend                                                                               #
COAD_Centricity_neg <- list()                                                                     #
KIRC_Centricity_neg <- list()                                                                     #
LUAD_Centricity_neg <- list()                                                                     #
THCA_Centricity_neg <- list()                                                                     #
# 03-02：Upward trend                                                                             #
COAD_Centricity_pos <- list()                                                                     #
HNSC_Centricity_pos <- list()                                                                     #
KIRC_Centricity_pos <- list()                                                                     #
LUAD_Centricity_pos <- list()                                                                     #
THCA_Centricity_pos <- list()                                                                     #
###################################################################################################


######
# 04 #
###########################################################################################
# Use cycles to find the three centralities of nodes in the downward trend of each cancer #
###########################################################################################
for (i in 1:4) {                                                                          #
  ll <- list()                                                                            #
  dat <- nonboth_subgraph_edges_neg[[i]][,c(2,3)]                                         #
  c_name1 <- c(unique(nonboth_subgraph_edges_neg[[i]][,2]))                               #
  c_name2 <- c(unique(nonboth_subgraph_edges_neg[[i]][,3]))                               #
  a <- c_name2 %in% c_name1                                                               #
  c_name2 <- c_name2[-c(which(a == TRUE))]                                                #
  c_name <- c(c_name1,c_name2)                                                            #
  g <- init.igraph(dat,dir=F,rem.multi=F)                                                 #
  degree_C <- degree(g,mode="total",normalized = T)                                       #
  C_C <- closeness(g,mode="in",normalized = T)                                            #
  B_C <- betweenness(g,normalized = T)                                                    #
  names(degree_C) <- c_name                                                               #
  names(C_C) <- c_name                                                                    #
  names(B_C) <- c_name                                                                    #
  if (i == 1) {                                                                           #
    COAD_Centricity_neg[[1]] <- degree_C                                                  #
    COAD_Centricity_neg[[2]] <- C_C                                                       #
    COAD_Centricity_neg[[3]] <- B_C                                                       #
    names(COAD_Centricity_neg) <- c("degree_C","C_C","B_C")                               #
  }                                                                                       #
  # KIRC                                                                                  #
  else if (i == 2) {                                                                      #
    KIRC_Centricity_neg[[1]] <- degree_C                                                  #
    KIRC_Centricity_neg[[2]] <- C_C                                                       #
    KIRC_Centricity_neg[[3]] <- B_C                                                       #
    names(KIRC_Centricity_neg) <- c("degree_C","C_C","B_C")                               #
  }                                                                                       #
  # LUAD                                                                                  #
  else if (i == 3) {                                                                      #
    LUAD_Centricity_neg[[1]] <- degree_C                                                  #
    LUAD_Centricity_neg[[2]] <- C_C                                                       #
    LUAD_Centricity_neg[[3]] <- B_C                                                       #
    names(LUAD_Centricity_neg) <- c("degree_C","C_C","B_C")                               #
  }                                                                                       #
  # THCA                                                                                  #
  else if (i == 4) {                                                                      #
    THCA_Centricity_neg[[1]] <- degree_C                                                  #
    THCA_Centricity_neg[[2]] <- C_C                                                       #
    THCA_Centricity_neg[[3]] <- B_C                                                       #
    names(THCA_Centricity_neg) <- c("degree_C","C_C","B_C")                               #
  }                                                                                       #
  print(i)                                                                                #
}                                                                                         #
###########################################################################################





######
# 05 #
###########################################################################################
# Use cycles to find the three centralities of nodes in the upward trend of each cancer   #
###########################################################################################
for (i in 1:4) {                                                                          #
  ll <- list()                                                                            #
  dat <- nonboth_subgraph_edges_pos[[i]][,c(2,3)]                                         #
  c_name1 <- c(unique(nonboth_subgraph_edges_pos[[i]][,2]))                               #
  c_name2 <- c(unique(nonboth_subgraph_edges_pos[[i]][,3]))                               #
  a <- c_name2 %in% c_name1                                                               #
  c_name2 <- c_name2[-c(which(a == TRUE))]                                                #
  c_name <- c(c_name1,c_name2)                                                            #
  g <- init.igraph(dat,dir=F,rem.multi=F)                                                 #
  degree_C <- degree(g,mode="total",normalized = T)                                       #
  C_C <- closeness(g,mode="in",normalized = T)                                            #
  B_C <- betweenness(g,normalized = T)                                                    #
  names(degree_C) <- c_name                                                               #
  names(C_C) <- c_name                                                                    #
  names(B_C) <- c_name                                                                    #
  # COAD                                                                                  #
  if (i == 1) {                                                                           #
    COAD_Centricity_pos[[1]] <- degree_C                                                  #
    COAD_Centricity_pos[[2]] <- C_C                                                       #
    COAD_Centricity_pos[[3]] <- B_C                                                       #
    names(COAD_Centricity_pos) <- c("degree_C","C_C","B_C")                               #
  }                                                                                       #
  # KIRC                                                                                  #
  else if (i == 2) {                                                                      #
    KIRC_Centricity_pos[[1]] <- degree_C                                                  #
    KIRC_Centricity_pos[[2]] <- C_C                                                       #
    KIRC_Centricity_pos[[3]] <- B_C                                                       #
    names(KIRC_Centricity_pos) <- c("degree_C","C_C","B_C")                               #
  }                                                                                       #
  # LUAD                                                                                  #
  else if (i == 3) {                                                                      #
    LUAD_Centricity_pos[[1]] <- degree_C                                                  #
    LUAD_Centricity_pos[[2]] <- C_C                                                       #
    LUAD_Centricity_pos[[3]] <- B_C                                                       #
    names(LUAD_Centricity_pos) <- c("degree_C","C_C","B_C")                               #
  }                                                                                       #
  # THCA                                                                                  #
  else if (i == 4) {                                                                      #
    THCA_Centricity_pos[[1]] <- degree_C                                                  #
    THCA_Centricity_pos[[2]] <- C_C                                                       #
    THCA_Centricity_pos[[3]] <- B_C                                                       #
    names(THCA_Centricity_pos) <- c("degree_C","C_C","B_C")                               #
  }                                                                                       #
  print(i)                                                                                #
}                                                                                         #
###########################################################################################


######
# 06 #
#################################
# Store the obtained centrality #
####################################################################################################################################################
save(COAD_Centricity_neg,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/02_Calculate_Centricity/COAD_Centricity_neg.RData")#
save(KIRC_Centricity_neg,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/02_Calculate_Centricity/KIRC_Centricity_neg.RData")#
save(LUAD_Centricity_neg,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/02_Calculate_Centricity/LUAD_Centricity_neg.RData")#
save(THCA_Centricity_neg,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/02_Calculate_Centricity/THCA_Centricity_neg.RData")#
save(COAD_Centricity_pos,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/02_Calculate_Centricity/COAD_Centricity_pos.RData")#
save(KIRC_Centricity_pos,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/02_Calculate_Centricity/KIRC_Centricity_pos.RData")#
save(LUAD_Centricity_pos,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/02_Calculate_Centricity/LUAD_Centricity_pos.RData")#
save(THCA_Centricity_pos,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/02_Calculate_Centricity/THCA_Centricity_pos.RData")#
####################################################################################################################################################





