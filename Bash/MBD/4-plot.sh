#!/bin/bash

for file in ../../results/MBD/1-Full/*_MBD.log
do
	python3 ~/PyRate/PyRateMBD.py -d ../../results/MBD/1-Full/Combined_TsTe_from_replicates.txt -var ../../data_2023/processed_environment_predictors -m 0 -plot $file
done
