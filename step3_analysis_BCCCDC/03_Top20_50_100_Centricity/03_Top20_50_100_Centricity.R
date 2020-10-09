# Set running path
setwd("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/step3_analysis_BCCCDC/03_Top20_50_100_Centricity")
################################################################################################################################################
################################################################################################################################################
######## 三、Here we perform the following operations on the three neutrals of the nodes in the largest connected subgraph of each cancer ######
################################################################################################################################################
################################################################################################################################################
# 1、Take out the intersection of the top 20, 50, and 100 nodes for each type of rising and falling centrality, and draw a VENN graph；        #
################################################################################################################################################


install.packages("VennDiagram")
library("VennDiagram")
#################################################################################################################################
####################### 1、Take out the top 20, 50, and 100 nodes of the three centralities of each cancer#######################
#################################################################################################################################


######
# 01 #
#####################
# 1-01：COAD Top100 #
#######################################################################################################################################################################################
# Import the three centrality data corresponding to the rise and fall of COAD                                                                                                         #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/02_Calculate_Centricity/COAD_Centricity_neg.RData")                                                              #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/02_Calculate_Centricity/COAD_Centricity_pos.RData")                                                              #                                                                                                                                                             #
# Create a list of the intersection of the top 100 nodes of the three centralities                                                                                                    #
COAD_Centricity_Top100 <- list()                                                                                                                                                      #
# Take out the top 100 nodes of the three centralities in the descending network respectively                                                                                         #
a1 <- names(sort(COAD_Centricity_neg[[1]],decreasing = TRUE)[c(1:100)])                                                                                                               #
a2 <- names(sort(COAD_Centricity_neg[[2]],decreasing = TRUE)[c(1:100)])                                                                                                               #
a3 <- names(sort(COAD_Centricity_neg[[3]],decreasing = TRUE)[c(1:100)])                                                                                                               #
# Find the intersection of the first 100 nodes of the three centralities in the descending network；                                                                                  #
COAD_Centricity_Top100[[1]] <- intersect(intersect(a1,a2),a3)                                                                                                                         #
# Set the path to store VENN diagram；                                                                                                                                                #
setwd("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/02_VENN/COAD/")                                                                      #
# Plot the VENN graph of the intersection of the top 100 nodes of the three centralities in the descending network;                                                                   #
venn.plot <- venn.diagram(list("DC"=a1, 
                               "CC"=a2,
                               "BC"=a3),
                          "COAD_Restrain_Top100.png",
                          height = 3000, width = 3000,resolution =500,
                          fill = rainbow(3),main = "COAD_Restrain_Top100")                                                                                                            #
# Take out the top 100 nodes of the three centralities in the rising network respectively；                                                                                           #
a1 <- names(sort(COAD_Centricity_pos[[1]],decreasing = TRUE)[c(1:100)])                                                                                                               #
a2 <- names(sort(COAD_Centricity_pos[[2]],decreasing = TRUE)[c(1:100)])                                                                                                               #
a3 <- names(sort(COAD_Centricity_pos[[3]],decreasing = TRUE)[c(1:100)])                                                                                                               #
COAD_Centricity_Top100[[2]] <- intersect(intersect(a1,a2),a3)                                                                                                                         #
# Draw the VENN graph of the intersection of the top 100 nodes of the three centralities in the ascending network                                                                     #
venn.plot <- venn.diagram(list("DC"=a1, 
                               "CC"=a2,
                               "BC"=a3),
                          "COAD_Advance_Top100.png",
                          height = 3000, width = 3000,resolution =500,
                          fill = rainbow(3),main = "COAD_Advance_Top100")                                                                                                             #
# Name and store the list that stores the intersection；                                                                                                                              #
names(COAD_Centricity_Top100) <- c("neg","pos")                                                                                                                                       #
save(COAD_Centricity_Top100,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/COAD_Centricity_Top100.RData")#
#######################################################################################################################################################################################
######
# 01 #
#####################
# 1-02：COAD Top50 #
#######################################################################################################################################################################################
# Create a list of the intersection of the first 50 nodes of the three centralities                                                                                                   #
COAD_Centricity_Top50 <- list()                                                                                                                                                       #
# Take out the top 50 nodes of the three centralities in the descending network respectively                                                                                          #
a1 <- names(sort(COAD_Centricity_neg[[1]],decreasing = TRUE)[c(1:50)])                                                                                                                #
a2 <- names(sort(COAD_Centricity_neg[[2]],decreasing = TRUE)[c(1:50)])                                                                                                                #
a3 <- names(sort(COAD_Centricity_neg[[3]],decreasing = TRUE)[c(1:50)])                                                                                                                #
# Find the intersection of the first 50 nodes of the three centralities in the descending network                                                                                     #
COAD_Centricity_Top50[[1]] <- intersect(intersect(a1,a2),a3)                                                                                                                          #
# Set the path to store VENN diagram；                                                                                                                                                #
setwd("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/02_VENN/COAD/")                                                                      #
# 绘制下降网络中三种中心性的前50节点的交集的VENN图;                                                                                                                                   #
venn.plot <- venn.diagram(list("DC"=a1, 
                               "CC"=a2,
                               "BC"=a3),
                          "COAD_Restrain_Top50.png",
                          height = 3000, width = 3000,resolution =500,
                          fill = rainbow(3),main = "COAD_Restrain_Top50")                                                                                                             #
# Take out the top 50 nodes of the three centralities in the rising network respectively；                                                                                            #
a1 <- names(sort(COAD_Centricity_pos[[1]],decreasing = TRUE)[c(1:50)])                                                                                                                #
a2 <- names(sort(COAD_Centricity_pos[[2]],decreasing = TRUE)[c(1:50)])                                                                                                                #
a3 <- names(sort(COAD_Centricity_pos[[3]],decreasing = TRUE)[c(1:50)])                                                                                                                #
COAD_Centricity_Top50[[2]] <- intersect(intersect(a1,a2),a3)                                                                                                                          #
# Draw the VENN graph of the intersection of the first 50 nodes of the three centralities in the ascending network；                                                                  #
venn.plot <- venn.diagram(list("DC"=a1, 
                               "CC"=a2,
                               "BC"=a3),
                          "COAD_Advance_Top50.png",
                          height = 3000, width = 3000,resolution =500,
                          fill = rainbow(3),main = "COAD_Advance_Top50")                                                                                                              #
# Name and store the list that stores the intersection                                                                                                                                #
names(COAD_Centricity_Top50) <- c("neg","pos")                                                                                                                                        #
save(COAD_Centricity_Top50,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/COAD_Centricity_Top50.RData")  #
#######################################################################################################################################################################################
######
# 01 #
#####################
# 1-03：COAD Top20 #
#######################################################################################################################################################################################
# Create a list that stores the intersection of the first 20 nodes of the three centralities                                                                                          #
COAD_Centricity_Top20 <- list()                                                                                                                                                       #
# Take out the top 20 nodes of the three centralities in the descending network respectively                                                                                          #
a1 <- names(sort(COAD_Centricity_neg[[1]],decreasing = TRUE)[c(1:20)])                                                                                                                #
a2 <- names(sort(COAD_Centricity_neg[[2]],decreasing = TRUE)[c(1:20)])                                                                                                                #
a3 <- names(sort(COAD_Centricity_neg[[3]],decreasing = TRUE)[c(1:20)])                                                                                                                #
# Find the intersection of the first 20 nodes of the three centralities in the descending network                                                                                     #
COAD_Centricity_Top20[[1]] <- intersect(intersect(a1,a2),a3)                                                                                                                          #
# Set the path to store VENN diagram                                                                                                                                                  #
setwd("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/02_VENN/COAD/")                                                                      #
# Draw the VENN graph of the intersection of the first 20 nodes of the three centralities in the descending networ                                                                    #
venn.plot <- venn.diagram(list("DC"=a1, 
                               "CC"=a2,
                               "BC"=a3),
                          "COAD_Restrain_Top20.png",
                          height = 3000, width = 3000,resolution =200,
                          fill = rainbow(3),main = "COAD_Restrain_Top20")                                                                                                            #
# Take out the top 20 nodes of the three centralities in the rising network respectively；                                                                                           #
a1 <- names(sort(COAD_Centricity_pos[[1]],decreasing = TRUE)[c(1:20)])                                                                                                               #
a2 <- names(sort(COAD_Centricity_pos[[2]],decreasing = TRUE)[c(1:20)])                                                                                                               #
a3 <- names(sort(COAD_Centricity_pos[[3]],decreasing = TRUE)[c(1:20)])                                                                                                               #
COAD_Centricity_Top20[[2]] <- intersect(intersect(a1,a2),a3)                                                                                                                         #
# Draw the VENN graph of the intersection of the top 20 nodes of the three centralities in the ascending network；                                                                   #
venn.plot <- venn.diagram(list("DC"=a1, 
                               "CC"=a2,
                               "BC"=a3),
                          "COAD_Advance_Top20.png",
                          height = 3000, width = 3000,resolution =200,
                          fill = rainbow(3),main = "COAD_Advance_Top20")                                                                                                              #
# Name and store the list that stores the intersection；                                                                                                                              #
names(COAD_Centricity_Top20) <- c("neg","pos")                                                                                                                                        #
save(COAD_Centricity_Top20,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/COAD_Centricity_Top20.RData")  #
#######################################################################################################################################################################################




######
# 02 #
#####################
# 02-01：KIRC Top100 #
#######################################################################################################################################################################################
# 导入KIRC对应的上升和下降的三种中心性的数据                                                                                                                                          #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/02_Calculate_Centricity/KIRC_Centricity_neg.RData")                                                              #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/02_Calculate_Centricity/KIRC_Centricity_pos.RData")                                                              #
# 02-01：KIRC Top100                                                                                                                                                                  #
# 02-01-01：创建存放三种中心性前100节点交集的列表；                                                                                                                                   #
KIRC_Centricity_Top100 <- list()                                                                                                                                                      #
# 分别取出下降网络中三种中心性的前100节点；                                                                                                                                           #                       
a1 <- names(sort(KIRC_Centricity_neg[[1]],decreasing = TRUE)[c(1:100)])                                                                                                               #
a2 <- names(sort(KIRC_Centricity_neg[[2]],decreasing = TRUE)[c(1:100)])                                                                                                               #
a3 <- names(sort(KIRC_Centricity_neg[[3]],decreasing = TRUE)[c(1:100)])                                                                                                               #
# 求下降网络中三种中心性的前100节点的交集；                                                                                                                                           #
KIRC_Centricity_Top100[[1]] <- intersect(intersect(a1,a2),a3)                                                                                                                         #
# 设置存放 VENN 图的路径；                                                                                                                                                            #
setwd("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/02_VENN/KIRC/")                                                                      #
# Plot the VENN graph of the intersection of the top 100 nodes of the three centralities in the descending network                                                                    #
venn.plot <- venn.diagram(list("DC"=a1, 
                               "CC"=a2,
                               "BC"=a3),
                          "KIRC_Restrain_Top100.png",
                          height = 3000, width = 3000,resolution =500,
                          fill = rainbow(3),main = "KIRC_Restrain_Top100")                                                                                                            #
# Take out the top 100 nodes of the three centralities in the rising network respectively；                                                                                           #
a1 <- names(sort(KIRC_Centricity_pos[[1]],decreasing = TRUE)[c(1:100)])                                                                                                               #
a2 <- names(sort(KIRC_Centricity_pos[[2]],decreasing = TRUE)[c(1:100)])                                                                                                               #
a3 <- names(sort(KIRC_Centricity_pos[[3]],decreasing = TRUE)[c(1:100)])                                                                                                               #
KIRC_Centricity_Top100[[2]] <- intersect(intersect(a1,a2),a3)                                                                                                                         #
# Draw the VENN graph of the intersection of the top 100 nodes of the three centralities in the ascending network                                                                     #
venn.plot <- venn.diagram(list("DC"=a1, 
                               "CC"=a2,
                               "BC"=a3),
                          "KIRC_Advance_Top100.png",
                          height = 3000, width = 3000,resolution =500,
                          fill = rainbow(3),main = "KIRC_Advance_Top100")                                                                                                             #
# Name and store the list that stores the intersection                                                                                                                                #
names(KIRC_Centricity_Top100) <- c("neg","pos")                                                                                                                                       #
save(KIRC_Centricity_Top100,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/KIRC_Centricity_Top100.RData")#
#######################################################################################################################################################################################
######
# 02 #
#####################
# 02-02：KIRC Top50 #
#######################################################################################################################################################################################
# Create a list of the intersection of the first 50 nodes of the three centralities；                                                                                                 #
KIRC_Centricity_Top50 <- list()                                                                                                                                                       #
# Take out the top 50 nodes of the three centralities in the descending network respectively；                                                                                        #
a1 <- names(sort(KIRC_Centricity_neg[[1]],decreasing = TRUE)[c(1:50)])                                                                                                                #
a2 <- names(sort(KIRC_Centricity_neg[[2]],decreasing = TRUE)[c(1:50)])                                                                                                                #
a3 <- names(sort(KIRC_Centricity_neg[[3]],decreasing = TRUE)[c(1:50)])                                                                                                                #
# Find the intersection of the first 50 nodes of the three centralities in the descending network；                                                                                   #
KIRC_Centricity_Top50[[1]] <- intersect(intersect(a1,a2),a3)                                                                                                                          #
# Set the path to store VENN diagram；                                                                                                                                                #
setwd("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/02_VENN/KIRC/")                                                                      #
# Plot the VENN graph of the intersection of the first 50 nodes of the three centralities in the descending network;                                                                  #
venn.plot <- venn.diagram(list("DC"=a1, 
                               "CC"=a2,
                               "BC"=a3),
                          "KIRC_Restrain_Top50.png",
                          height = 3000, width = 3000,resolution =500,
                          fill = rainbow(3),main = "KIRC_Restrain_Top50")                                                                                                             #
# Take out the top 50 nodes of the three centralities in the rising network respectively；                                                                                            #
a1 <- names(sort(KIRC_Centricity_pos[[1]],decreasing = TRUE)[c(1:50)])                                                                                                                #
a2 <- names(sort(KIRC_Centricity_pos[[2]],decreasing = TRUE)[c(1:50)])                                                                                                                #
a3 <- names(sort(KIRC_Centricity_pos[[3]],decreasing = TRUE)[c(1:50)])                                                                                                                #
KIRC_Centricity_Top50[[2]] <- intersect(intersect(a1,a2),a3)                                                                                                                          #
# Draw the VENN graph of the intersection of the first 50 nodes of the three centralities in the ascending network；                                                                  #
venn.plot <- venn.diagram(list("DC"=a1, 
                               "CC"=a2,
                               "BC"=a3),
                          "KIRC_Advance_Top50.png",
                          height = 3000, width = 3000,resolution =500,
                          fill = rainbow(3),main = "KIRC_Advance_Top50")                                                                                                              #
# Name and store the list that stores the intersection；                                                                                                                              #
names(KIRC_Centricity_Top50) <- c("neg","pos")                                                                                                                                        #
save(KIRC_Centricity_Top50,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/KIRC_Centricity_Top50.RData")  #
#######################################################################################################################################################################################
######
# 02 #
#####################
# 02-03：KIRC Top20 #
#######################################################################################################################################################################################
# Create a list that stores the intersection of the first 20 nodes of the three centralities；                                                                                        #
KIRC_Centricity_Top20 <- list()                                                                                                                                                       #
# Take out the top 20 nodes of the three centralities in the descending network respectively；                                                                                        #
a1 <- names(sort(KIRC_Centricity_neg[[1]],decreasing = TRUE)[c(1:20)])                                                                                                                #
a2 <- names(sort(KIRC_Centricity_neg[[2]],decreasing = TRUE)[c(1:20)])                                                                                                                #
a3 <- names(sort(KIRC_Centricity_neg[[3]],decreasing = TRUE)[c(1:20)])                                                                                                                #
# Find the intersection of the first 20 nodes of the three centralities in the descending network；                                                                                   #
KIRC_Centricity_Top20[[1]] <- intersect(intersect(a1,a2),a3)                                                                                                                          #
# Set the path to store VENN diagram；                                                                                                                                                #
setwd("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/02_VENN/KIRC/")                                                                      #
# Draw the VENN graph of the intersection of the first 20 nodes of the three centralities in the descending network;                                                                  #
venn.plot <- venn.diagram(list("DC"=a1, 
                               "CC"=a2,
                               "BC"=a3),
                          "KIRC_Restrain_Top20.png",
                          height = 3000, width = 3000,resolution =200,
                          fill = rainbow(3),main = "KIRC_Restrain_Top20")                                                                                                             #
# Take out the top 20 nodes of the three centralities in the rising network respectively；                                                                                            #
a1 <- names(sort(KIRC_Centricity_pos[[1]],decreasing = TRUE)[c(1:20)])                                                                                                                #
a2 <- names(sort(KIRC_Centricity_pos[[2]],decreasing = TRUE)[c(1:20)])                                                                                                                #
a3 <- names(sort(KIRC_Centricity_pos[[3]],decreasing = TRUE)[c(1:20)])                                                                                                                #
KIRC_Centricity_Top20[[2]] <- intersect(intersect(a1,a2),a3)                                                                                                                          #
# Draw the VENN graph of the intersection of the top 20 nodes of the three centralities in the ascending network                                                                                     #
venn.plot <- venn.diagram(list("DC"=a1, 
                               "CC"=a2,
                               "BC"=a3),
                          "KIRC_Advance_Top20.png",
                          height = 3000, width = 3000,resolution =200,
                          fill = rainbow(3),main = "KIRC_Advance_Top20")                                                                                                              #
# Name and store the list that stores the intersection；                                                                                                                              #
names(KIRC_Centricity_Top20) <- c("neg","pos")                                                                                                                                        #
save(KIRC_Centricity_Top20,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/KIRC_Centricity_Top20.RData")  #
#######################################################################################################################################################################################






######
# 03 #
#####################
# 03-01：LUAD Top100 #
#######################################################################################################################################################################################
# Import three kinds of centrality data corresponding to the rise and fall of LUAD                                                                                                    #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/02_Calculate_Centricity/LUAD_Centricity_neg.RData")                                                              #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/02_Calculate_Centricity/LUAD_Centricity_pos.RData")                                                              #                                                                                                                                                              #
# Create a list of the intersection of the top 100 nodes of the three centralities；                                                                                                  #
LUAD_Centricity_Top100 <- list()                                                                                                                                                      #
# Take out the top 100 nodes of the three centralities in the descending network respectively                                                                                         #
a1 <- names(sort(LUAD_Centricity_neg[[1]],decreasing = TRUE)[c(1:100)])                                                                                                               #
a2 <- names(sort(LUAD_Centricity_neg[[2]],decreasing = TRUE)[c(1:100)])                                                                                                               #
a3 <- names(sort(LUAD_Centricity_neg[[3]],decreasing = TRUE)[c(1:100)])                                                                                                               #
# Find the intersection of the first 100 nodes of the three centralities in the descending network；                                                                                  #
LUAD_Centricity_Top100[[1]] <- intersect(intersect(a1,a2),a3)                                                                                                                         #
# Set the path to store VENN diagram                                                                                                                                                  #
setwd("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/02_VENN/LUAD/")                                                                      #
# Plot the VENN graph of the intersection of the top 100 nodes of the three centralities in the descending network                                                                    #
venn.plot <- venn.diagram(list("DC"=a1, 
                               "CC"=a2,
                               "BC"=a3),
                          "LUAD_Restrain_Top100.png",
                          height = 3000, width = 3000,resolution =500,
                          fill = rainbow(3),main = "LUAD_Restrain_Top100")                                                                                                            #
# Take out the top 100 nodes of the three centralities in the rising network respectively；                                                                                           #
a1 <- na.omit(names(sort(LUAD_Centricity_pos[[1]],decreasing = TRUE)[c(1:100)]))                                                                                                      #
a2 <- na.omit(names(sort(LUAD_Centricity_pos[[2]],decreasing = TRUE)[c(1:100)]))                                                                                                      #
a3 <- na.omit(names(sort(LUAD_Centricity_pos[[3]],decreasing = TRUE)[c(1:100)]))                                                                                                      #
LUAD_Centricity_Top100[[2]] <- intersect(intersect(a1,a2),a3)                                                                                                                         #
# Draw the VENN graph of the intersection of the top 100 nodes of the three centralities in the ascending network；                                                                   #
venn.plot <- venn.diagram(list("DC"=a1, 
                               "CC"=a2,
                               "BC"=a3),
                          "LUAD_Advance_Top100.png",
                          height = 3000, width = 3000,resolution =500,
                          fill = rainbow(3),main = "LUAD_Advance_Top100")                                                                                                             #
# Name and store the list that stores the intersection                                                                                                                                #
names(LUAD_Centricity_Top100) <- c("neg","pos")                                                                                                                                       #
save(LUAD_Centricity_Top100,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/LUAD_Centricity_Top100.RData")#
#######################################################################################################################################################################################
######
# 03 #
#####################
# 03-02：LUAD Top50 #
#######################################################################################################################################################################################
# Create a list of the intersection of the first 50 nodes of the three centralities；                                                                                                 #
LUAD_Centricity_Top50 <- list()                                                                                                                                                       #
# Take out the top 50 nodes of the three centralities in the descending network respectively                                                                                          #
a1 <- names(sort(LUAD_Centricity_neg[[1]],decreasing = TRUE)[c(1:50)])                                                                                                                #
a2 <- names(sort(LUAD_Centricity_neg[[2]],decreasing = TRUE)[c(1:50)])                                                                                                                #
a3 <- names(sort(LUAD_Centricity_neg[[3]],decreasing = TRUE)[c(1:50)])                                                                                                                #
# Find the intersection of the first 50 nodes of the three centralities in the descending network                                                                                     #
LUAD_Centricity_Top50[[1]] <- intersect(intersect(a1,a2),a3)                                                                                                                          #
# Set the path to store VENN diagram；                                                                                                                                                #
setwd("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/02_VENN/LUAD/")                                                                      #
# Plot the VENN graph of the intersection of the first 50 nodes of the three centralities in the descending network                                                                   #
venn.plot <- venn.diagram(list("DC"=a1, 
                               "CC"=a2,
                               "BC"=a3),
                          "LUAD_Restrain_Top50.png",
                          height = 3000, width = 3000,resolution =500,
                          fill = rainbow(3),main = "LUAD_Restrain_Top50")                                                                                                             #
# Take out the top 50 nodes of the three centralities in the rising network respectively                                                                                              #
a1 <- na.omit(names(sort(LUAD_Centricity_pos[[1]],decreasing = TRUE)[c(1:50)]))                                                                                                       #
a2 <- na.omit(names(sort(LUAD_Centricity_pos[[2]],decreasing = TRUE)[c(1:50)]))                                                                                                       #
a3 <- na.omit(names(sort(LUAD_Centricity_pos[[3]],decreasing = TRUE)[c(1:50)]))                                                                                                       #
LUAD_Centricity_Top50[[2]] <- intersect(intersect(a1,a2),a3)                                                                                                                          #
# Draw the VENN graph of the intersection of the first 50 nodes of the three centralities in the ascending network                                                                    #
venn.plot <- venn.diagram(list("DC"=a1, 
                               "CC"=a2,
                               "BC"=a3),
                          "LUAD_Advance_Top50.png",
                          height = 3000, width = 3000,resolution =500,
                          fill = rainbow(3),main = "LUAD_Advance_Top50")                                                                                                               #
# Name and store the list that stores the intersection                                                                                                                                 #
names(LUAD_Centricity_Top50) <- c("neg","pos")                                                                                                                                         #
save(LUAD_Centricity_Top50,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/LUAD_Centricity_Top50.RData")   #
########################################################################################################################################################################################
######
# 03 #
#####################
# 03-03：LUAD Top20 #
########################################################################################################################################################################################
# Create a list that stores the intersection of the first 20 nodes of the three centralities；                                                                                         #
LUAD_Centricity_Top20 <- list()                                                                                                                                                        #
# Take out the top 20 nodes of the three centralities in the descending network respectively                                                                                           #
a1 <- names(sort(LUAD_Centricity_neg[[1]],decreasing = TRUE)[c(1:20)])                                                                                                                 #
a2 <- names(sort(LUAD_Centricity_neg[[2]],decreasing = TRUE)[c(1:20)])                                                                                                                 #
a3 <- names(sort(LUAD_Centricity_neg[[3]],decreasing = TRUE)[c(1:20)])                                                                                                                 #
# Find the intersection of the first 20 nodes of the three centralities in the descending network                                                                                      #
LUAD_Centricity_Top20[[1]] <- intersect(intersect(a1,a2),a3)                                                                                                                           #
# Set the path to store VENN diagram；                                                                                                                                                 #
setwd("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/02_VENN/LUAD/")                                                                       #
# Draw the VENN graph of the intersection of the first 20 nodes of the three centralities in the descending network                                                                    #
venn.plot <- venn.diagram(list("DC"=a1, 
                               "CC"=a2,
                               "BC"=a3),
                          "LUAD_Restrain_Top20.png",
                          height = 3000, width = 3000,resolution =200,
                          fill = rainbow(3),main = "LUAD_Restrain_Top20")                                                                                                              #
# Take out the top 20 nodes of the three centralities in the rising network respectively                                                                                               #
a1 <- names(sort(LUAD_Centricity_pos[[1]],decreasing = TRUE)[c(1:20)])                                                                                                                 #
a2 <- names(sort(LUAD_Centricity_pos[[2]],decreasing = TRUE)[c(1:20)])                                                                                                                 #
a3 <- names(sort(LUAD_Centricity_pos[[3]],decreasing = TRUE)[c(1:20)])                                                                                                                 #
LUAD_Centricity_Top20[[2]] <- intersect(intersect(a1,a2),a3)                                                                                                                           #
# Draw the VENN graph of the intersection of the top 20 nodes of the three centralities in the ascending network                                                                       #
venn.plot <- venn.diagram(list("DC"=a1, 
                               "CC"=a2,
                               "BC"=a3),
                          "LUAD_Advance_Top20.png",
                          height = 3000, width = 3000,resolution =200,
                          fill = rainbow(3),main = "LUAD_Advance_Top20")                                                                                                               #
# Name and store the list that stores the intersection                                                                                                                                 #
names(LUAD_Centricity_Top20) <- c("neg","pos")                                                                                                                                         #
save(LUAD_Centricity_Top20,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/LUAD_Centricity_Top20.RData")   #
#######################################################################################################################################################################################


######
# 04 #
#####################
# 04-01：THCA Top100 #
#######################################################################################################################################################################################
# Import three kinds of central data corresponding to THCA's rise and fall                                                                                                             #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/02_Calculate_Centricity/THCA_Centricity_neg.RData")                                                               #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/02_Calculate_Centricity/THCA_Centricity_pos.RData")                                                               #
# Create a list of the intersection of the top 100 nodes of the three centralities                                                                                                     #
THCA_Centricity_Top100 <- list()                                                                                                                                                       #
# Take out the top 100 nodes of the three centralities in the descending network respectively                                                                                          #
a1 <- names(sort(THCA_Centricity_neg[[1]],decreasing = TRUE)[c(1:100)])                                                                                                                #
a2 <- names(sort(THCA_Centricity_neg[[2]],decreasing = TRUE)[c(1:100)])                                                                                                                #
a3 <- names(sort(THCA_Centricity_neg[[3]],decreasing = TRUE)[c(1:100)])                                                                                                                #
# Find the intersection of the top 100 nodes of the three centralities in the descending network;                                                                                      #
THCA_Centricity_Top100[[1]] <- intersect(intersect(a1,a2),a3)                                                                                                                          #
# Set the path to store VENN diagram                                                                                                                                                   #
setwd("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/02_VENN/THCA/")                                                                       #
# Plot the VENN graph of the intersection of the top 100 nodes of the three centralities in the descending network                                                                     #
venn.plot <- venn.diagram(list("DC"=a1, 
                               "CC"=a2,
                               "BC"=a3),
                          "THCA_Restrain_Top100.png",
                          height = 3000, width = 3000,resolution =500,
                          fill = rainbow(3),main = "THCA_Restrain_Top100")                                                                                                             #
# Take out the top 100 nodes of the three centralities in the rising network respectively                                                                                              #
a1 <- na.omit(names(sort(THCA_Centricity_pos[[1]],decreasing = TRUE)[c(1:100)]))                                                                                                       #
a2 <- na.omit(names(sort(THCA_Centricity_pos[[2]],decreasing = TRUE)[c(1:100)]))                                                                                                       #
a3 <- na.omit(names(sort(THCA_Centricity_pos[[3]],decreasing = TRUE)[c(1:100)]))                                                                                                       #
THCA_Centricity_Top100[[2]] <- intersect(intersect(a1,a2),a3)                                                                                                                          #
# Draw the VENN graph of the intersection of the top 100 nodes of the three centralities in the ascending network                                                                      #
venn.plot <- venn.diagram(list("DC"=a1, 
                               "CC"=a2,
                               "BC"=a3),
                          "THCA_Advance_Top100.png",
                          height = 3000, width = 3000,resolution =500,
                          fill = rainbow(3),main = "THCA_Advance_Top100")                                                                                                              #
# Name and store the list that stores the intersection                                                                                                                                 #
names(THCA_Centricity_Top100) <- c("neg","pos")                                                                                                                                        #
save(THCA_Centricity_Top100,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/THCA_Centricity_Top100.RData") #
########################################################################################################################################################################################
######
# 04 #
#####################
# 04-02：THCA Top50 #
########################################################################################################################################################################################
# Create a list of the intersection of the first 50 nodes of the three centralities                                                                                                    #
THCA_Centricity_Top50 <- list()                                                                                                                                                        #
# Take out the top 50 nodes of the three centralities in the descending network respectively;                                                                                          #
a1 <- names(sort(THCA_Centricity_neg[[1]],decreasing = TRUE)[c(1:50)])                                                                                                                 #
a2 <- names(sort(THCA_Centricity_neg[[2]],decreasing = TRUE)[c(1:50)])                                                                                                                 #
a3 <- names(sort(THCA_Centricity_neg[[3]],decreasing = TRUE)[c(1:50)])                                                                                                                 #
#  Find the intersection of the first 50 nodes of the three centralities in the descending network                                                                                     #
THCA_Centricity_Top50[[1]] <- intersect(intersect(a1,a2),a3)                                                                                                                           #
# Set the path to store VENN diagram                                                                                                                                                   #
setwd("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/02_VENN/THCA/")                                                                       #
# Plot the VENN graph of the intersection of the first 50 nodes of the three centralities in the descending network                                                                    #
venn.plot <- venn.diagram(list("DC"=a1, 
                               "CC"=a2,
                               "BC"=a3),
                          "THCA_Restrain_Top50.png",
                          height = 3000, width = 3000,resolution =500,
                          fill = rainbow(3),main = "THCA_Restrain_Top50")                                                                                                              #
# Take out the top 50 nodes of the three centralities in the rising network respectively                                                                                               #
a1 <- na.omit(names(sort(THCA_Centricity_pos[[1]],decreasing = TRUE)[c(1:50)]))                                                                                                        #
a2 <- na.omit(names(sort(THCA_Centricity_pos[[2]],decreasing = TRUE)[c(1:50)]))                                                                                                        #
a3 <- na.omit(names(sort(THCA_Centricity_pos[[3]],decreasing = TRUE)[c(1:50)]))                                                                                                        #
THCA_Centricity_Top50[[2]] <- intersect(intersect(a1,a2),a3)                                                                                                                           #
# Draw the VENN graph of the intersection of the first 50 nodes of the three centralities in the ascending network                                                                     #
venn.plot <- venn.diagram(list("DC"=a1, 
                               "CC"=a2,
                               "BC"=a3),
                          "THCA_Advance_Top50.png",
                          height = 3000, width = 3000,resolution =500,
                          fill = rainbow(3),main = "THCA_Advance_Top50")                                                                                                               #
# Name and store the list that stores the intersection                                                                                                                                 #
names(THCA_Centricity_Top50) <- c("neg","pos")                                                                                                                                         #
save(THCA_Centricity_Top50,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/THCA_Centricity_Top50.RData")   #
#######################################################################################################################################################################################
######
# 04 #
#####################
# 04-03：THCA Top20 #
########################################################################################################################################################################################
# Create a list that stores the intersection of the first 20 nodes of the three centralities                                                                                           #
THCA_Centricity_Top20 <- list()                                                                                                                                                        #
# Take out the top 20 nodes of the three centralities in the descending network respectively；                                                                                         #
a1 <- names(sort(THCA_Centricity_neg[[1]],decreasing = TRUE)[c(1:20)])                                                                                                                 #
a2 <- names(sort(THCA_Centricity_neg[[2]],decreasing = TRUE)[c(1:20)])                                                                                                                 #
a3 <- names(sort(THCA_Centricity_neg[[3]],decreasing = TRUE)[c(1:20)])                                                                                                                 #
# Find the intersection of the first 20 nodes of the three centralities in the descending network                                                                                      #
THCA_Centricity_Top20[[1]] <- intersect(intersect(a1,a2),a3)                                                                                                                           #
# Set the path to store VENN diagram                                                                                                                                                   #
setwd("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/02_VENN/THCA/")                                                                       #
# Draw the VENN graph of the intersection of the first 20 nodes of the three centralities in the descending network                                                                    #
venn.plot <- venn.diagram(list("DC"=a1, 
                               "CC"=a2,
                               "BC"=a3),
                          "THCA_Restrain_Top20.png",
                          height = 3000, width = 3000,resolution =200,
                          fill = rainbow(3),main = "THCA_Restrain_Top20")                                                                                                              #
# Take out the top 20 nodes of the three centralities in the rising network respectively                                                                                               #
a1 <- names(sort(THCA_Centricity_pos[[1]],decreasing = TRUE)[c(1:20)])                                                                                                                 #
a2 <- names(sort(THCA_Centricity_pos[[2]],decreasing = TRUE)[c(1:20)])                                                                                                                 #
a3 <- names(sort(THCA_Centricity_pos[[3]],decreasing = TRUE)[c(1:20)])                                                                                                                 #
THCA_Centricity_Top20[[2]] <- intersect(intersect(a1,a2),a3)                                                                                                                           #
# Draw the VENN graph of the intersection of the top 20 nodes of the three centralities in the ascending network                                                                       #
venn.plot <- venn.diagram(list("DC"=a1, 
                               "CC"=a2,
                               "BC"=a3),
                          "THCA_Advance_Top20.png",
                          height = 3000, width = 3000,resolution =200,
                          fill = rainbow(3),main = "THCA_Advance_Top20")                                                                                                               #
# Name and store the list that stores the intersection                                                                                                                                 #
names(THCA_Centricity_Top20) <- c("neg","pos")                                                                                                                                         #
save(THCA_Centricity_Top20,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/THCA_Centricity_Top20.RData")   #
#######################################################################################################################################################################################











