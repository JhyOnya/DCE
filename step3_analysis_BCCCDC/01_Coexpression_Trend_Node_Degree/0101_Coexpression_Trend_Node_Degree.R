#################################################################################################################################
###################### 一、Calculate the total link degree of each node in the rising and falling network #######################
#################################################################################################################################
# Here we calculate the total number of links for each node in the rising and falling network                                   #
# 1、First, we import the rising and falling networks；                                                                         #
# 2、Then we calculate the total number of links of each node in the network according to the table function in the R language; #
# 3、Stored in the list after obtaining;                                                                                        #
#  （1）advance_Degree：Store each type of cancer corresponding to each defined degree in the ascending network；               #
#  （2）restrain_Degree：Store each type of cancer corresponding to each defined degree in the decline network；                #
#################################################################################################################################

# Set running path
setwd("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/step3_analysis_BCCCDC/01_Coexpression_Trend_Node_Degree/")

######
# 01 #
#########################################
# Import the rising and falling network #
########################################################################################################
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_2to3/RData/edges_trend4_pos.RData") #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_2to3/RData/edges_trend4_neg.RData") #
########################################################################################################

######
# 02 #
#######################################################################
# Calculate the degree of each node in the rising and falling network #
###################################################################################################################################################################################
# 02-01                                                                                                                                                                           #
# Create a list that stores the degree of each cancer node in the ascending and descending network                                                                                #
advance_Degree <- list()                                                                                                                                                          #
restrain_Degree <- list()                                                                                                                                                         #
# 02-02                                                                                                                                                                           #
# Use the built-in function table of R language to calculate the degree of each node in the network                                                                               #
for (i in 1:4) {                                                                                                                                                                  #
  restrain_Degree[[i]] <- data.frame(sort(table(c(edges_trend4_neg[[i]][,3],edges_trend4_neg[[i]][,4])),decreasing = TRUE),stringsAsFactors = FALSE)                              #
  advance_Degree[[i]] <- data.frame(sort(table(c(edges_trend4_pos[[i]][,3],edges_trend4_pos[[i]][,4])),decreasing = TRUE),stringsAsFactors = FALSE)                               #
}                                                                                                                                                                                 #
# 02-03                                                                                                                                                                           #
# Set a name for the list of node degrees                                                                                                                                         #
names(advance_Degree) <- c("COAD","KIRC","LUAD","THCA")                                                                                                                           #
names(restrain_Degree) <- c("COAD","KIRC","LUAD","THCA")                                                                                                                          #
# 02-04                                                                                                                                                                           #
# Store a list of node degrees for storage                                                                                                                                        #
save(restrain_Degree,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/01_Coexpression_Trend_Node_Degree/restrain_Degree.RData")                             #
save(advance_Degree,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/01_Coexpression_Trend_Node_Degree/advance_Degree.RData")                               #
###################################################################################################################################################################################