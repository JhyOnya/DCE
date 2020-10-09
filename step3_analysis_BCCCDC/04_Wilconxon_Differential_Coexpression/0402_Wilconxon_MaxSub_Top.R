# Set running path
setwd("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/step3_analysis_BCCCDC/04_Wilconxon_Differential_Coexpression/")
#####################################################################################################################################################
#####################################################################################################################################################
############# 四、Here we de-intersect the genes in the differentially expressed genes in the largest connection subgraph ###########################
#####################################################################################################################################################
#####################################################################################################################################################


######
# 01 #
########################################################################################
# Import the data of differentially expressed genes and the largest connected subgraph #
#############################################################################################################################################
# Introduce differentially expressed genes                                                                                                  #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_2to3/RData/COAD_wilconxon.RData")                                        #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_2to3/RData/KIRC_wilconxon.RData")                                        #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_2to3/RData/LUAD_wilconxon.RData")                                        #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_2to3/RData/THCA_wilconxon.RData")                                        #
# Max_subgraphs                                                                                                                             #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_2to3/RData/nonboth_subgraph_nodes_neg.RData")                            #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_2to3/RData/nonboth_subgraph_nodes_pos.RData")                            #
#############################################################################################################################################


######
# 02 #
######################################################################################################
# Here we find the intersection of differentially expressed genes and the largest connected subgraph #
###########################################################################################################################################################################################
# Create a list of intersection data                                                                                                                                                      #
COAD_wilconxon_MaxSub_intersect <- list()                                                                                                                                                 #
KIRC_wilconxon_MaxSub_intersect <- list()                                                                                                                                                 #
LUAD_wilconxon_MaxSub_intersect <- list()                                                                                                                                                 #
THCA_wilconxon_MaxSub_intersect <- list()                                                                                                                                                 #
# Intersect                                                                                                                                                                               #
########## COAD ##########                                                                                                                                                                #
COAD_wilconxon_MaxSub_intersect[[1]] <- intersect(unlist(COAD_wilconxon[[1]]),unlist(nonboth_subgraph_nodes_pos[[1]])) # pos                                                              #
COAD_wilconxon_MaxSub_intersect[[2]] <- intersect(unlist(COAD_wilconxon[[2]]),unlist(nonboth_subgraph_nodes_neg[[1]])) # neg                                                              #
########## KIRC ##########                                                                                                                                                                #
KIRC_wilconxon_MaxSub_intersect[[1]] <- intersect(unlist(KIRC_wilconxon[[1]]),unlist(nonboth_subgraph_nodes_pos[[2]])) # pos                                                              #
KIRC_wilconxon_MaxSub_intersect[[2]] <- intersect(unlist(KIRC_wilconxon[[2]]),unlist(nonboth_subgraph_nodes_neg[[3]])) # neg                                                              #
########## LUAD ##########                                                                                                                                                                #
LUAD_wilconxon_MaxSub_intersect[[1]] <- intersect(unlist(LUAD_wilconxon[[1]]),unlist(nonboth_subgraph_nodes_pos[[3]])) # pos                                                              #
LUAD_wilconxon_MaxSub_intersect[[2]] <- intersect(unlist(LUAD_wilconxon[[2]]),unlist(nonboth_subgraph_nodes_neg[[3]])) # neg                                                              #
########## THCA ##########                                                                                                                                                                #
THCA_wilconxon_MaxSub_intersect[[1]] <- intersect(unlist(THCA_wilconxon[[1]]),unlist(nonboth_subgraph_nodes_pos[[4]])) # pos                                                              #
THCA_wilconxon_MaxSub_intersect[[2]] <- intersect(unlist(THCA_wilconxon[[2]]),unlist(nonboth_subgraph_nodes_neg[[4]])) # neg                                                              #
#
names(COAD_wilconxon_MaxSub_intersect) <- c("pos","neg")                                                                                                                                  #                                                                                                                                 #
names(KIRC_wilconxon_MaxSub_intersect) <- c("pos","neg")                                                                                                                                  #
names(LUAD_wilconxon_MaxSub_intersect) <- c("pos","neg")                                                                                                                                  #
names(THCA_wilconxon_MaxSub_intersect) <- c("pos","neg")                                                                                                                                  #
#
save(COAD_wilconxon_MaxSub_intersect,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/04_Wilconxon_Differential_Coexpression/COAD_wilconxon_MaxSub_intersect.RData")#
save(KIRC_wilconxon_MaxSub_intersect,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/04_Wilconxon_Differential_Coexpression/KIRC_wilconxon_MaxSub_intersect.RData")#
save(LUAD_wilconxon_MaxSub_intersect,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/04_Wilconxon_Differential_Coexpression/LUAD_wilconxon_MaxSub_intersect.RData")#
save(THCA_wilconxon_MaxSub_intersect,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/04_Wilconxon_Differential_Coexpression/THCA_wilconxon_MaxSub_intersect.RData")#
###########################################################################################################################################################################################


######
# 03 #
#####################################################################################################
# Here we draw the VENN graph of differentially expressed genes and the largest connected subgraph  #
##################################################################################################################################
# Set VENN map storage path                                                                                                      #
setwd("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/04_Wilconxon_Differential_Coexpression/")                  #
#
library("VennDiagram")                                                                                                           #
#
########## COAD ##########                                                                                                       #
# pos                                                                                                                            #
venn.plot <- venn.diagram(list("wilconxon"=unlist(COAD_wilconxon[[1]]), 
                               "MaxSub"=na.omit(unlist(nonboth_subgraph_nodes_pos[[1]]))),
                          "COAD_wilconxon_MaxSub_advance.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "COAD_wilconxon_MaxSub_advance")  #
# neg                                                                                                                            #
venn.plot <- venn.diagram(list("wilconxon"=unlist(COAD_wilconxon[[2]]), 
                               "MaxSub"=na.omit(unlist(nonboth_subgraph_nodes_neg[[1]]))),
                          "COAD_wilconxon_MaxSub_restrain.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "COAD_wilconxon_MaxSub_restrain") #
########## KIRC ##########
# pos                                                                                                                            #
venn.plot <- venn.diagram(list("wilconxon"=unlist(KIRC_wilconxon[[1]]), 
                               "MaxSub"=na.omit(unlist(nonboth_subgraph_nodes_pos[[2]]))),
                          "KIRC_wilconxon_MaxSub_advance.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "KIRC_wilconxon_MaxSub_advance")  #
# neg                                                                                                                            #
venn.plot <- venn.diagram(list("wilconxon"=unlist(KIRC_wilconxon[[2]]), 
                               "MaxSub"=na.omit(unlist(nonboth_subgraph_nodes_neg[[2]]))),
                          "KIRC_wilconxon_MaxSub_restrain.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "KIRC_wilconxon_MaxSub_restrain") #
########## LUAD ##########
# pos                                                                                                                            #
venn.plot <- venn.diagram(list("wilconxon"=unlist(LUAD_wilconxon[[1]]), 
                               "MaxSub"=na.omit(unlist(nonboth_subgraph_nodes_pos[[3]]))),
                          "LUAD_wilconxon_MaxSub_advance.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "LUAD_wilconxon_MaxSub_advance")  #
# neg                                                                                                                            #
venn.plot <- venn.diagram(list("wilconxon"=unlist(LUAD_wilconxon[[2]]), 
                               "MaxSub"=na.omit(unlist(nonboth_subgraph_nodes_neg[[3]]))),
                          "LUAD_wilconxon_MaxSub_restrain.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "LUAD_wilconxon_MaxSub_restrain") #
########## THCA ##########
# pos                                                                                                                            #
venn.plot <- venn.diagram(list("wilconxon"=unlist(THCA_wilconxon[[1]]), 
                               "MaxSub"=na.omit(unlist(nonboth_subgraph_nodes_pos[[4]]))),
                          "THCA_wilconxon_MaxSub_advance.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "THCA_wilconxon_MaxSub_advance")  #
# neg                                                                                                                            #
venn.plot <- venn.diagram(list("wilconxon"=unlist(THCA_wilconxon[[2]]), 
                               "MaxSub"=na.omit(unlist(nonboth_subgraph_nodes_neg[[4]]))),
                          "THCA_wilconxon_MaxSub_restrain.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "THCA_wilconxon_MaxSub_restrain") #
##################################################################################################################################


#############
# 04 Top100 #
########################################################################################################################################################
# Here we find the intersection of the differential gene and the top 20, 50, and 100 intersection genes in the upper and lower networks of each cancer #
###########################################################################################################################################################################################
####################                                                                                                                                                                      #
# Find the intersection                                                                                                                                                                   #
####################                                                                                                                                                                      #
# Top100                                                                                                                                                                                  #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/COAD_Centricity_Top100.RData")                                  #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/KIRC_Centricity_Top100.RData")                                  #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/LUAD_Centricity_Top100.RData")                                  #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/THCA_Centricity_Top100.RData")                                  #
##################################################                                                                                                                                        #
COAD_wilconxon_Top100_intersect <- list()                                                                                                                                                 #
KIRC_wilconxon_Top100_intersect <- list()                                                                                                                                                 #
LUAD_wilconxon_Top100_intersect <- list()                                                                                                                                                 #
THCA_wilconxon_Top100_intersect <- list()                                                                                                                                                 #
########## COAD ##########                                                                                                                                                                #
COAD_wilconxon_Top100_intersect[[1]] <- intersect(unlist(COAD_wilconxon[[1]]),unlist(COAD_Centricity_Top100[[2]])) # pos                                                              #
COAD_wilconxon_Top100_intersect[[2]] <- intersect(unlist(COAD_wilconxon[[2]]),unlist(COAD_Centricity_Top100[[1]])) # neg                                                              #
########## KIRC ##########                                                                                                                                                                #
KIRC_wilconxon_Top100_intersect[[1]] <- intersect(unlist(KIRC_wilconxon[[1]]),unlist(KIRC_Centricity_Top100[[2]])) # pos                                                              #
KIRC_wilconxon_Top100_intersect[[2]] <- intersect(unlist(KIRC_wilconxon[[2]]),unlist(KIRC_Centricity_Top100[[1]])) # neg                                                              #
########## LUAD ##########                                                                                                                                                                #
LUAD_wilconxon_Top100_intersect[[1]] <- intersect(unlist(LUAD_wilconxon[[1]]),unlist(LUAD_Centricity_Top100[[2]])) # pos                                                              #
LUAD_wilconxon_Top100_intersect[[2]] <- intersect(unlist(LUAD_wilconxon[[2]]),unlist(LUAD_Centricity_Top100[[1]])) # neg                                                              #
########## THCA ##########                                                                                                                                                                #
THCA_wilconxon_Top100_intersect[[1]] <- intersect(unlist(THCA_wilconxon[[1]]),unlist(THCA_Centricity_Top100[[2]])) # pos                                                              #
THCA_wilconxon_Top100_intersect[[2]] <- intersect(unlist(THCA_wilconxon[[2]]),unlist(THCA_Centricity_Top100[[1]])) # neg                                                              #
#                                                                                                                                                                                         #
names(COAD_wilconxon_Top100_intersect) <- c("pos","neg")                                                                                                                                  #
names(KIRC_wilconxon_Top100_intersect) <- c("pos","neg")                                                                                                                                  #
names(LUAD_wilconxon_Top100_intersect) <- c("pos","neg")                                                                                                                                  #
names(THCA_wilconxon_Top100_intersect) <- c("pos","neg")                                                                                                                                  #
#                                                                                                                                                                                         #
save(COAD_wilconxon_Top100_intersect,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/04_Wilconxon_Differential_Coexpression/COAD_wilconxon_Top100_intersect.RData")#
save(KIRC_wilconxon_Top100_intersect,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/04_Wilconxon_Differential_Coexpression/KIRC_wilconxon_Top100_intersect.RData")#
save(LUAD_wilconxon_Top100_intersect,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/04_Wilconxon_Differential_Coexpression/LUAD_wilconxon_Top100_intersect.RData")#
save(THCA_wilconxon_Top100_intersect,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/04_Wilconxon_Differential_Coexpression/THCA_wilconxon_Top100_intersect.RData")#
####################                                                                                                                                                                       #
# 
####################                                                                                                                                                                       #
setwd("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/04_Wilconxon_Differential_Coexpression/VENN/")                                                                  #
library("VennDiagram")                                                                                                                                                                     #
########## COAD ##########
venn.plot <- venn.diagram(list("wilconxon"=unlist(COAD_wilconxon[[1]]), 
                               "Top100"=na.omit(unlist(COAD_Centricity_Top100[[2]]))),
                          "COAD_wilconxon_Top100_advance.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "COAD_wilconxon_Top100_advance")                                                            #
#
venn.plot <- venn.diagram(list("wilconxon"=unlist(COAD_wilconxon[[2]]), 
                               "MaxSub"=na.omit(unlist(COAD_Centricity_Top100[[1]]))),
                          "COAD_wilconxon_Top100_restrain.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "COAD_wilconxon_Top100_restrain")                                                           #
#
########## KIRC ##########
venn.plot <- venn.diagram(list("wilconxon"=unlist(KIRC_wilconxon[[1]]), 
                               "Top100"=na.omit(unlist(KIRC_Centricity_Top100[[2]]))),
                          "KIRC_wilconxon_Top100_advance.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "KIRC_wilconxon_Top100_advance")                                                            #
#
venn.plot <- venn.diagram(list("wilconxon"=unlist(KIRC_wilconxon[[2]]), 
                               "MaxSub"=na.omit(unlist(KIRC_Centricity_Top100[[1]]))),
                          "KIRC_wilconxon_Top100_restrain.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "KIRC_wilconxon_Top100_restrain")                                                           #
########## LUAD ##########
venn.plot <- venn.diagram(list("wilconxon"=unlist(LUAD_wilconxon[[1]]), 
                               "Top100"=na.omit(unlist(LUAD_Centricity_Top100[[2]]))),
                          "LUAD_wilconxon_Top100_advance.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "LUAD_wilconxon_Top100_advance")                                                            #
#
venn.plot <- venn.diagram(list("wilconxon"=unlist(LUAD_wilconxon[[2]]), 
                               "MaxSub"=na.omit(unlist(LUAD_Centricity_Top100[[1]]))),
                          "LUAD_wilconxon_Top100_restrain.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "LUAD_wilconxon_Top100_restrain")                                                           #
########## THCA ##########
venn.plot <- venn.diagram(list("wilconxon"=unlist(THCA_wilconxon[[1]]), 
                               "Top100"=na.omit(unlist(THCA_Centricity_Top100[[2]]))),
                          "THCA_wilconxon_Top100_advance.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "THCA_wilconxon_Top100_advance")                                                            #
#
venn.plot <- venn.diagram(list("wilconxon"=unlist(THCA_wilconxon[[2]]), 
                               "MaxSub"=na.omit(unlist(THCA_Centricity_Top100[[1]]))),
                          "THCA_wilconxon_Top100_restrain.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "THCA_wilconxon_Top100_restrain")                                                          #
###########################################################################################################################################################################################



#############
# 05 Top50 #
#######################################################################################################################################################
# Here we find the intersection of the differential gene and the top 20, 50, and 100 intersection genes in the upper and lower networks of each cancer#
#########################################################################################################################################################################################
####################                                                                                                                                                                    #
# 05-01、Find the intersection                                                                                                                                                          #
####################                                                                                                                                                                    #
# Top50                                                                                                                                                                                 #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/COAD_Centricity_Top50.RData")                                 #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/KIRC_Centricity_Top50.RData")                                 #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/LUAD_Centricity_Top50.RData")                                 #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/THCA_Centricity_Top50.RData")                                 #
##################################################                                                                                                                                      #
COAD_wilconxon_Top50_intersect <- list()                                                                                                                                                #                                                                                                                                               #
KIRC_wilconxon_Top50_intersect <- list()                                                                                                                                                #
LUAD_wilconxon_Top50_intersect <- list()                                                                                                                                                #
THCA_wilconxon_Top50_intersect <- list()                                                                                                                                                #
########## COAD ##########                                                                                                                                                              #
COAD_wilconxon_Top50_intersect[[1]] <- intersect(unlist(COAD_wilconxon[[1]]),unlist(COAD_Centricity_Top50[[2]])) # pos                                                              #
COAD_wilconxon_Top50_intersect[[2]] <- intersect(unlist(COAD_wilconxon[[2]]),unlist(COAD_Centricity_Top50[[1]])) # neg                                                              #
########## KIRC ##########                                                                                                                                                              #
KIRC_wilconxon_Top50_intersect[[1]] <- intersect(unlist(KIRC_wilconxon[[1]]),unlist(KIRC_Centricity_Top50[[2]])) # pos                                                              #
KIRC_wilconxon_Top50_intersect[[2]] <- intersect(unlist(KIRC_wilconxon[[2]]),unlist(KIRC_Centricity_Top50[[1]])) # neg                                                              #
########## LUAD ##########                                                                                                                                                              #
LUAD_wilconxon_Top50_intersect[[1]] <- intersect(unlist(LUAD_wilconxon[[1]]),unlist(LUAD_Centricity_Top50[[2]])) # pos                                                              #
LUAD_wilconxon_Top50_intersect[[2]] <- intersect(unlist(LUAD_wilconxon[[2]]),unlist(LUAD_Centricity_Top50[[1]])) # neg                                                              #
########## THCA ##########                                                                                                                                                              #
THCA_wilconxon_Top50_intersect[[1]] <- intersect(unlist(THCA_wilconxon[[1]]),unlist(THCA_Centricity_Top50[[2]])) # pos                                                              #
THCA_wilconxon_Top50_intersect[[2]] <- intersect(unlist(THCA_wilconxon[[2]]),unlist(THCA_Centricity_Top50[[1]])) # neg                                                              #
#                                                                                                                                                                                       #
names(COAD_wilconxon_Top50_intersect) <- c("pos","neg")                                                                                                                                 #                                                                                                                                #
names(KIRC_wilconxon_Top50_intersect) <- c("pos","neg")                                                                                                                                 #
names(LUAD_wilconxon_Top50_intersect) <- c("pos","neg")                                                                                                                                 #
names(THCA_wilconxon_Top50_intersect) <- c("pos","neg")                                                                                                                                 #
#                                                                                                                                                                                       #
save(COAD_wilconxon_Top50_intersect,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/04_Wilconxon_Differential_Coexpression/COAD_wilconxon_Top50_intersect.RData")#
save(KIRC_wilconxon_Top50_intersect,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/04_Wilconxon_Differential_Coexpression/KIRC_wilconxon_Top50_intersect.RData")#
save(LUAD_wilconxon_Top50_intersect,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/04_Wilconxon_Differential_Coexpression/LUAD_wilconxon_Top50_intersect.RData")#
save(THCA_wilconxon_Top50_intersect,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/04_Wilconxon_Differential_Coexpression/THCA_wilconxon_Top50_intersect.RData")#
####################                                                                                                                                                                    #
#
####################                                                                                                                                                                    #
setwd("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/04_Wilconxon_Differential_Coexpression/VENN/")                                                               #
library("VennDiagram")                                                                                                                                                                  #
########## COAD ##########
venn.plot <- venn.diagram(list("wilconxon"=unlist(COAD_wilconxon[[1]]), 
                               "Top50"=na.omit(unlist(COAD_Centricity_Top50[[2]]))),
                          "COAD_wilconxon_Top50_advance.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "COAD_wilconxon_Top50_advance")                                                          #
#
venn.plot <- venn.diagram(list("wilconxon"=unlist(COAD_wilconxon[[2]]), 
                               "MaxSub"=na.omit(unlist(COAD_Centricity_Top50[[1]]))),
                          "COAD_wilconxon_Top50_restrain.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "COAD_wilconxon_Top50_restrain")                                                         #
#
########## KIRC ##########
venn.plot <- venn.diagram(list("wilconxon"=unlist(KIRC_wilconxon[[1]]), 
                               "Top50"=na.omit(unlist(KIRC_Centricity_Top50[[2]]))),
                          "KIRC_wilconxon_Top50_advance.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "KIRC_wilconxon_Top50_advance")                                                          #
#
venn.plot <- venn.diagram(list("wilconxon"=unlist(KIRC_wilconxon[[2]]), 
                               "MaxSub"=na.omit(unlist(KIRC_Centricity_Top50[[1]]))),
                          "KIRC_wilconxon_Top50_restrain.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "KIRC_wilconxon_Top50_restrain")                                                         #
########## LUAD ##########
venn.plot <- venn.diagram(list("wilconxon"=unlist(LUAD_wilconxon[[1]]), 
                               "Top50"=na.omit(unlist(LUAD_Centricity_Top50[[2]]))),
                          "LUAD_wilconxon_Top50_advance.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "LUAD_wilconxon_Top50_advance")                                                          #
#
venn.plot <- venn.diagram(list("wilconxon"=unlist(LUAD_wilconxon[[2]]), 
                               "MaxSub"=na.omit(unlist(LUAD_Centricity_Top50[[1]]))),
                          "LUAD_wilconxon_Top50_restrain.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "LUAD_wilconxon_Top50_restrain")                                                         #
########## THCA ##########
venn.plot <- venn.diagram(list("wilconxon"=unlist(THCA_wilconxon[[1]]), 
                               "Top50"=na.omit(unlist(THCA_Centricity_Top50[[2]]))),
                          "THCA_wilconxon_Top50_advance.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "THCA_wilconxon_Top50_advance")                                                          #
#
venn.plot <- venn.diagram(list("wilconxon"=unlist(THCA_wilconxon[[2]]), 
                               "MaxSub"=na.omit(unlist(THCA_Centricity_Top50[[1]]))),
                          "THCA_wilconxon_Top50_restrain.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "THCA_wilconxon_Top50_restrain")                                                         #
#########################################################################################################################################################################################


#############
# 04 Top20 #
########################################################################################################################################################
# Here we find the intersection of the differential gene and the top 20, 50, and 100 intersection genes in the upper and lower networks of each cancer #
#########################################################################################################################################################################################
####################                                                                                                                                                                    #
# 04-01、Find the intersection                                                                                                                                                          #
####################                                                                                                                                                                    #
# Top20                                                                                                                                                                                 #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/COAD_Centricity_Top20.RData")                                 #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/KIRC_Centricity_Top20.RData")                                 #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/LUAD_Centricity_Top20.RData")                                 #
load("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/03_Top20_50_100_Centricity/01_Top20_50_100_intersect/THCA_Centricity_Top20.RData")                                 #
##################################################                                                                                                                                      #
COAD_wilconxon_Top20_intersect <- list()                                                                                                                                                #
KIRC_wilconxon_Top20_intersect <- list()                                                                                                                                                #
LUAD_wilconxon_Top20_intersect <- list()                                                                                                                                                #
THCA_wilconxon_Top20_intersect <- list()                                                                                                                                                #
########## COAD ##########                                                                                                                                                              #
COAD_wilconxon_Top20_intersect[[1]] <- intersect(unlist(COAD_wilconxon[[1]]),unlist(COAD_Centricity_Top20[[2]])) # pos                                                              #
COAD_wilconxon_Top20_intersect[[2]] <- intersect(unlist(COAD_wilconxon[[2]]),unlist(COAD_Centricity_Top20[[1]])) # neg                                                              #
########## KIRC ##########                                                                                                                                                              #
KIRC_wilconxon_Top20_intersect[[1]] <- intersect(unlist(KIRC_wilconxon[[1]]),unlist(KIRC_Centricity_Top20[[2]])) # pos                                                              #
KIRC_wilconxon_Top20_intersect[[2]] <- intersect(unlist(KIRC_wilconxon[[2]]),unlist(KIRC_Centricity_Top20[[1]])) # neg                                                              #
########## LUAD ##########                                                                                                                                                              #
LUAD_wilconxon_Top20_intersect[[1]] <- intersect(unlist(LUAD_wilconxon[[1]]),unlist(LUAD_Centricity_Top20[[2]])) # pos                                                              #
LUAD_wilconxon_Top20_intersect[[2]] <- intersect(unlist(LUAD_wilconxon[[2]]),unlist(LUAD_Centricity_Top20[[1]])) # neg                                                              #
########## THCA ##########                                                                                                                                                              #
THCA_wilconxon_Top20_intersect[[1]] <- intersect(unlist(THCA_wilconxon[[1]]),unlist(THCA_Centricity_Top20[[2]])) # pos                                                              #
THCA_wilconxon_Top20_intersect[[2]] <- intersect(unlist(THCA_wilconxon[[2]]),unlist(THCA_Centricity_Top20[[1]])) # neg                                                              #
#                                                                                                                                                                                       #
names(COAD_wilconxon_Top20_intersect) <- c("pos","neg")                                                                                                                                 #
names(KIRC_wilconxon_Top20_intersect) <- c("pos","neg")                                                                                                                                 #
names(LUAD_wilconxon_Top20_intersect) <- c("pos","neg")                                                                                                                                 #
names(THCA_wilconxon_Top20_intersect) <- c("pos","neg")                                                                                                                                 #
#                                                                                                                                                                                       #
save(COAD_wilconxon_Top20_intersect,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/04_Wilconxon_Differential_Coexpression/COAD_wilconxon_Top20_intersect.RData")#
save(KIRC_wilconxon_Top20_intersect,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/04_Wilconxon_Differential_Coexpression/KIRC_wilconxon_Top20_intersect.RData")#
save(LUAD_wilconxon_Top20_intersect,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/04_Wilconxon_Differential_Coexpression/LUAD_wilconxon_Top20_intersect.RData")#
save(THCA_wilconxon_Top20_intersect,file = "/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/04_Wilconxon_Differential_Coexpression/THCA_wilconxon_Top20_intersect.RData")#
####################                                                                                                                                                                    #
#
####################                                                                                                                                                                    #
setwd("/home/jhy/code/myCode/Python/other/DCE_BIBM2020/cache/result_3/04_Wilconxon_Differential_Coexpression/VENN/")                                                               #
library("VennDiagram")                                                                                                                                                                  #
########## COAD ##########
venn.plot <- venn.diagram(list("wilconxon"=unlist(COAD_wilconxon[[1]]), 
                               "Top20"=na.omit(unlist(COAD_Centricity_Top20[[2]]))),
                          "COAD_wilconxon_Top20_advance.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "COAD_wilconxon_Top20_advance")                                                          #
#
venn.plot <- venn.diagram(list("wilconxon"=unlist(COAD_wilconxon[[2]]), 
                               "MaxSub"=na.omit(unlist(COAD_Centricity_Top20[[1]]))),
                          "COAD_wilconxon_Top20_restrain.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "COAD_wilconxon_Top20_restrain")                                                         #
#
########## KIRC ##########
venn.plot <- venn.diagram(list("wilconxon"=unlist(KIRC_wilconxon[[1]]), 
                               "Top20"=na.omit(unlist(KIRC_Centricity_Top20[[2]]))),
                          "KIRC_wilconxon_Top20_advance.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "KIRC_wilconxon_Top20_advance")                                                          #
#
venn.plot <- venn.diagram(list("wilconxon"=unlist(KIRC_wilconxon[[2]]), 
                               "MaxSub"=na.omit(unlist(KIRC_Centricity_Top20[[1]]))),
                          "KIRC_wilconxon_Top20_restrain.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "KIRC_wilconxon_Top20_restrain")                                                         #
########## LUAD ##########
venn.plot <- venn.diagram(list("wilconxon"=unlist(LUAD_wilconxon[[1]]), 
                               "Top20"=na.omit(unlist(LUAD_Centricity_Top20[[2]]))),
                          "LUAD_wilconxon_Top20_advance.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "LUAD_wilconxon_Top20_advance")                                                          #
#
venn.plot <- venn.diagram(list("wilconxon"=unlist(LUAD_wilconxon[[2]]), 
                               "MaxSub"=na.omit(unlist(LUAD_Centricity_Top20[[1]]))),
                          "LUAD_wilconxon_Top20_restrain.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "LUAD_wilconxon_Top20_restrain")                                                         #
########## THCA ##########
venn.plot <- venn.diagram(list("wilconxon"=unlist(THCA_wilconxon[[1]]), 
                               "Top20"=na.omit(unlist(THCA_Centricity_Top20[[2]]))),
                          "THCA_wilconxon_Top20_advance.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "THCA_wilconxon_Top20_advance")                                                          #
#
venn.plot <- venn.diagram(list("wilconxon"=unlist(THCA_wilconxon[[2]]), 
                               "MaxSub"=na.omit(unlist(THCA_Centricity_Top20[[1]]))),
                          "THCA_wilconxon_Top20_restrain.png",
                          height = 3000, width = 3000,resolution =500,fill = rainbow(2),main = "THCA_wilconxon_Top20_restrain")                                                         #
#########################################################################################################################################################################################



