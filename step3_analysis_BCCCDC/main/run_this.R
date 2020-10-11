##############################################################################################
######################################### set file############################################ 
##############################################################################################
# dir.create("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_2to3/RData")
print("set file")

######
# 00 #
##############################################################################
setwd("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/")            #
dir.create("result_3")                                                       #
setwd("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/cache/result_3/")   #
##############################################################################

######
# 01 #
######################################################################################
dir.create("01_Coexpression_Trend_Node_Degree")                                      #
dir.create("./01_Coexpression_Trend_Node_Degree/0102_Up_Down_Degree_Figure")         #
dir.create("./01_Coexpression_Trend_Node_Degree/0102_Up_Down_Degree_Figure/boxplot") #
dir.create("./01_Coexpression_Trend_Node_Degree/0102_Up_Down_Degree_Figure/VENN")    #
#
dir.create("./01_Coexpression_Trend_Node_Degree/0103_Degree_Greater5")               #
dir.create("./01_Coexpression_Trend_Node_Degree/0103_Node2_3_4_GO")                  #
######################################################################################


######
# 02 #
#######################################
dir.create("02_Calculate_Centricity") #
#######################################

######
# 03 #
#########################################################################
dir.create("03_Top20_50_100_Centricity")                                #
dir.create("./03_Top20_50_100_Centricity/01_Top20_50_100_intersect")    #
dir.create("./03_Top20_50_100_Centricity/02_VENN")                      #
dir.create("./03_Top20_50_100_Centricity/02_VENN/COAD")                 #
dir.create("./03_Top20_50_100_Centricity/02_VENN/KIRC")                 #
dir.create("./03_Top20_50_100_Centricity/02_VENN/LUAD")                 #
dir.create("./03_Top20_50_100_Centricity/02_VENN/THCA")                 #
#
dir.create("./03_Top20_50_100_Centricity/03_Enrichment")                #
dir.create("./03_Top20_50_100_Centricity/03_Enrichment/Top20")          #
dir.create("./03_Top20_50_100_Centricity/03_Enrichment/Top50")          #
dir.create("./03_Top20_50_100_Centricity/03_Enrichment/Top100")         #
#########################################################################

######
# 04 #
#####################################################################
dir.create("04_Wilconxon_Differential_Coexpression")                #
dir.create("./04_Wilconxon_Differential_Coexpression/Enrichment")   #
dir.create("./04_Wilconxon_Differential_Coexpression/VENN")         #
#####################################################################

##############################################################################################
######################################### run this ########################################### 
##############################################################################################
######
# 01 #
####################################################################################################################
print("01_Coexpression_Trend_Node_Degree")                                                                         #
setwd("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/step3_analysis_BCCCDC/01_Coexpression_Trend_Node_Degree/")#
source("0101_Coexpression_Trend_Node_Degree.R")                                                                    #
setwd("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/step3_analysis_BCCCDC/01_Coexpression_Trend_Node_Degree/")#
source("0102_Up_Down_Degree_Figure.R")                                                                             #
setwd("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/step3_analysis_BCCCDC/01_Coexpression_Trend_Node_Degree/")#
source("0103_Degree_Greater5.R")                                                                                   #
setwd("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/step3_analysis_BCCCDC/01_Coexpression_Trend_Node_Degree/")#
source("0104_Node2_3_4_GO.R")                                                                                      #
####################################################################################################################


######
# 02 #
##########################################################################################################
print("02_Calculate_Centricity")                                                                         #
setwd("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/step3_analysis_BCCCDC/02_Calculate_Centricity/")#
source("02_Calculate_Centricity.R")                                                                      #
##########################################################################################################


######
# 03 #
#############################################################################################################
print("03_Top20_50_100_Centricity")                                                                         #
setwd("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/step3_analysis_BCCCDC/03_Top20_50_100_Centricity/")#
source("03_Top20_50_100_Centricity.R")                                                                      #
setwd("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/step3_analysis_BCCCDC/03_Top20_50_100_Centricity/")#
source("03_Top20_50_100_Centricity_GO.R")                                                                   #
#############################################################################################################

######
# 03 #
#########################################################################################################################
print("04_Wilconxon_Differential_Coexpression")                                                                         #
setwd("/home/jhy/code/myCode/Python/history/DCE_BIBM2020/step3_analysis_BCCCDC/04_Wilconxon_Differential_Coexpression/")#
source("0401_Wilconxon_GO.R")                                                                                           #
source("0402_Wilconxon_MaxSub_Top.R")                                                                                   #
#########################################################################################################################

print("run over")




