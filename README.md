                                                   
cd /home/jhy/code/myCode/Python/history

# step1
	# the code is written by python, version=3.6.9
	# calculate co-expression by Spearman
	
	# input data is in ./dataset/
	# output data in ./cache/result_1to23/    will used in step2 and step3
	
	cd ./DCE_BIBM2020/step1_calculate_Spearman
	nohup py3_jhy -u -W ignore run_this.py -d='COAD' > _log_COAD.txt 2>&1 & 
	nohup py3_jhy -u -W ignore run_this.py -d='KIRC' > _log_KIRC.txt 2>&1 & 
	nohup py3_jhy -u -W ignore run_this.py -d='LUAD' > _log_LUAD.txt 2>&1 & 
	nohup py3_jhy -u -W ignore run_this.py -d='THCA' > _log_THCA.txt 2>&1 & 
    
    
    
# step2
	# the code is written by python, version=3.6.9
	# calculate the largest component and statistic some result of the network
	
	# input data is in ./cache/result_1to23/
	# output data in ./cache/result_2to3/     will used in step3
	# output data in ./cache/result_2/        is some statistic of the network
	
	cd ./DCE_BIBM2020/step2_get_max_component
	nohup py3_jhy -u -W ignore run_this.py > _log.txt 2>&1 & 



# step3
	# the code is written by R, version=4.0.2
	# input data is in ./cache/result_2to3/RData
	
	cd ./DCE_BIBM2020/step3_analysis_BCCCDC/01_Coexpression_Trend_Node_Degree/
		nohup Rscript 0101_Coexpression_Trend_Node_Degree.R >output2.R.e 2> output2.R.o
		nohup Rscript 0102_Up_Down_Degree_Figure.R >output2.R.e 2> output2.R.o
		nohup Rscript 0103_Degree_Greater5.R >output2.R.e 2> output2.R.o
		nohup Rscript 0104_Node2_3_4_GO.R >output2.R.e 2> output2.R.o
	
	cd ./DCE_BIBM2020/step3_analysis_BCCCDC/02_Calculate_Centricity/
		nohup Rscript 02_Calculate_Centricity.R >output2.R.e 2> output2.R.o
	
	cd ./DCE_BIBM2020/step3_analysis_BCCCDC/03_Top20_50_100_Centricity/
		nohup Rscript 03_Top20_50_100_Centricity.R >output2.R.e 2> output2.R.o
		nohup Rscript 03_Top20_50_100_Centricity_GO.R >output2.R.e 2> output2.R.o

	cd ./DCE_BIBM2020/step3_analysis_BCCCDC/04_Wilconxon_Differential_Coexpression/
		nohup Rscript 0401_Wilconxon_GO.R >output2.R.e 2> output2.R.o
		nohup Rscript 0402_Wilconxon_MaxSub_Top.R >output2.R.e 2> output2.R.o







