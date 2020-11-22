# Cite

If you make use of this code in your own work, please cite our paper:

```
@inproceedings{DCE,
  title={Identification of Cancer Development Related Pathways Based on Co-Expression Analyses},
  author={Hongyang Jiang, Zhihang Wang, Chaoyi Yin, Peishuo Sun, Ying Xu, and Huiyan Sun},
  booktitle={2020 IEEE International Conference on Bioinformatics and Biomedicine},
  year={2020}
}
```



# step1
	# the code is written by python, version=3.6.9
	# calculate co-expression by Spearman
	
	# input data is in ./DCE_BIBM2020/dataset/
	# output data in ./DCE_BIBM2020/cache/result_1to23/    will used in step2 and step3
	
	cd ./DCE_BIBM2020/step1_calculate_Spearman
		nohup python3 -u -W ignore run_this.py -d='COAD' > _log_COAD.txt 2>&1 & 
		nohup python3 -u -W ignore run_this.py -d='KIRC' > _log_KIRC.txt 2>&1 & 
		nohup python3 -u -W ignore run_this.py -d='LUAD' > _log_LUAD.txt 2>&1 & 
		nohup python3 -u -W ignore run_this.py -d='THCA' > _log_THCA.txt 2>&1 & 
    
        
# step2
	# the code is written by python, version=3.6.9
	# calculate the largest component and statistic some result of the network
	
	# input data is in ./DCE_BIBM2020/cache/result_1to23/
	# output data in ./DCE_BIBM2020/cache/result_2to3/     will used in step3
	# output data in ./DCE_BIBM2020/cache/result_2/        is some statistic of the network
	
	cd ./DCE_BIBM2020/step2_get_max_component
		nohup python3 -u -W ignore run_this.py > _log.txt 2>&1 & 


# step3
	# the code is written by R, version=4.0.2
	
	# input data is in ./DCE_BIBM2020/cache/result_2to3/
	# output data in ./DCE_BIBM2020/cache/result_3/
	
	cd ./DCE_BIBM2020/step3_analysis_BCCCDC/main
		nohup Rscript run_this.R > _log.txt 2>&1 & 
