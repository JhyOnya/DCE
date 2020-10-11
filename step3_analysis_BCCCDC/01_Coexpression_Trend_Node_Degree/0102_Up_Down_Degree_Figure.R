# Set running path
setwd("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/step3_analysis_BCCCDC/01_Coexpression_Trend_Node_Degree/")
########################################################################################################
# 一、Here we draw box plots and VENN plots for the degrees of nodes in the rising and falling network #
########################################################################################################
# Here we plot the calculated degrees of the nodes in the rising and falling network                   #
# 1、Draw a box plot of the degree of nodes in the network for each type of cancer rising and falling；#
# 2、Plot the rise and fall of VENN for each cancer；                                                  #
########################################################################################################


######
# 01 #
######################
# Import degree data #
###############################################################################################################################
load("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/01_Coexpression_Trend_Node_Degree/restrain_Degree.RData")#
load("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/01_Coexpression_Trend_Node_Degree/advance_Degree.RData") #
###############################################################################################################################


######
# 01 #
###################
# Draw a box plot #
#############################################################################################################################################################################
# Set the storage path of the box map                                                                                                                                       #
png(file="/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/01_Coexpression_Trend_Node_Degree/0102_Up_Down_Degree_Figure/boxplot/advance_restrain_Degree.png") #
attach(mtcars)                                                                                                                                                              #
opar<-par(no.readonly=T)                                                                                                                                                    #
par(mfrow=c(1,2))                                                                                                                                                           #
a <- list()                                                                                                                                                                 #
for (i in 1:4) {                                                                                                                                                            #
  a[[i]] <- advance_Degree[[i]][,2]                                                                                                                                         #
}                                                                                                                                                                           #
names(a) <- names(advance_Degree)                                                                                                                                           #
boxplot(a,main = "advance_degree",col = 2:7)                                                                                                                                #
b <- list()                                                                                                                                                                 #
for (i in 1:4) {                                                                                                                                                            #
  b[[i]] <- restrain_Degree[[i]][,2]                                                                                                                                        #
}                                                                                                                                                                           #
names(b) <- names(restrain_Degree)                                                                                                                                          #
boxplot(a,main = "restrain_degree",col = 2:7)                                                                                                                               #
par(opar)                                                                                                                                                                   #
detach(mtcars)                                                                                                                                                              #
dev.off()                                                                                                                                                                   #
#############################################################################################################################################################################


######
# 01 #
#####################
# Draw VENN diagram #
###########################################################################################################################################
# Set VENN map storage path                                                                                                               #
setwd("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/01_Coexpression_Trend_Node_Degree/0102_Up_Down_Degree_Figure/VENN/") #
library("VennDiagram")                                                                                                                    #
file_name <- c("COAD.png","KIRC.png","LUAD.png","THCA.png")                                                                               #
main_name <- c("COAD","KIRC","LUAD","THCA")                                                                                               #
for (i in 1:4) {                                                                                                                          #
  venn.plot <- venn.diagram(list("advance"=advance_Degree[[i]][,2], 
                                 "restrain"=restrain_Degree[[i]][,2]),
                            file_name[i],height = 3000, width = 3000,resolution =500,
                            fill = rainbow(2),main = main_name[i])                                    
}                                                                                                                                         #
###########################################################################################################################################
