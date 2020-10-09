# set runing path
setwd("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/step3_analysis_BCCCDC/01_Coexpression_Trend_Node_Degree")
################################################################################################################################
## 一、Here we find the nodes that meet our conditions according to the degree of each node in the rising and falling network ##
################################################################################################################################
# Here we will take out the following sets of nodes according to the degree of nodes in the rising and falling network：       #
# 1、Node1：The intersection of nodes in a rising and falling network                                                          #
# 2、Node2：The intersection of nodes in the rising and falling network with degrees greater than 5                            #
# 3、Node3：Remove the node in Node1 from the rising node；                                                                    #
# 4、Node4：Remove the node in Node1 from the descending node；                                                                #
################################################################################################################################


######
# 01 #
##############################################################################
# Import data on the degree of nodes in the ascending and descending network #
###############################################################################################################################
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/01_Coexpression_Trend_Node_Degree/restrain_Degree.RData")#
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/01_Coexpression_Trend_Node_Degree/advance_Degree.RData") #
###############################################################################################################################


######
# 02 #
##################
# Get Node1 node #
############################################################################
Node1 <- list()                                                            #
for (i in 1:4) {                                                           #
  Node1[[i]] <- intersect(advance_Degree[[i]][,1],restrain_Degree[[i]][,1])#
}                                                                          #
############################################################################


######
# 03 #
##################
# Get Node2 node #
###################################################################################
Node2 <- list()                                                                   #
for (i in 1:4) {                                                                  #
  a1 <- as.character(advance_Degree[[i]][which(advance_Degree[[i]][,2] > 5),1])   #
  a2 <- as.character(restrain_Degree[[i]][which(restrain_Degree[[i]][,2] > 5),1]) #
  Node2[[i]] <- intersect(a1,a2)                                                  #
}                                                                                 #
###################################################################################


######
# 04 #
##################
# Get Node3 node #
######################################################################################################
Node3 <- list()                                                                                      #
for (i in 1:4) {                                                                                     #
  Node3[[i]] <- as.character(advance_Degree[[i]][-which(advance_Degree[[i]][,1] %in% Node1[[i]]),1]) #
}                                                                                                    #
######################################################################################################


######
# 05 #
##################
# Get Node4 node #
#######################################################################################################
Node4 <- list()                                                                                       #
for (i in 1:4) {                                                                                      #
  Node4[[i]] <- as.character(restrain_Degree[[i]][-which(restrain_Degree[[i]][,1] %in% Node1[[i]]),1])#
}                                                                                                     #
#######################################################################################################


######
# 06 #
############################
# Name and store the list  #
########################################################################################################################################################
names(Node1) <- c("COAD","KIRC","LUAD","THCA")                                                                                                         #
names(Node2) <- c("COAD","KIRC","LUAD","THCA")                                                                                                         #
names(Node3) <- c("COAD","KIRC","LUAD","THCA")                                                                                                         #
names(Node4) <- c("COAD","KIRC","LUAD","THCA")                                                                                                         #
save(Node1,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/01_Coexpression_Trend_Node_Degree/0103_Degree_Greater5/Node1.RData") #
save(Node2,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/01_Coexpression_Trend_Node_Degree/0103_Degree_Greater5/Node2.RData") #
save(Node3,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/01_Coexpression_Trend_Node_Degree/0103_Degree_Greater5/Node3.RData") #
save(Node4,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/01_Coexpression_Trend_Node_Degree/0103_Degree_Greater5/Node4.RData") #
########################################################################################################################################################