#!/bin/bash

## Birth Death model with time-continuous correlate applied to temperature
	# Post EECO
echo "python3 ~/PyRate/PyRateContinuous.py -d ../../BDT/Corr_temp/post_EECO/Full_post_EECO_SALMA_smoothed_se_est.txt -c ../../BDT/predictors/3-Temperature_post_EECO_500ky_step.txt -j \$1 -n 10000000 -s 10000" > tmp_script_temp.sh
/usr/local/bin/parallel -j 10 bash tmp_script_temp.sh ::: {1..10}

	# Oligocene only
echo "python3 ~/PyRate/PyRateContinuous.py -d ../../BDT/Corr_temp/Oligocene_only/Full_Oligocene_only_SALMA_smoothed_se_est.txt -c ../../BDT/predictors/3-Temperature_Oligocene_only_500ky_step.txt -j \$1 -n 10000000 -s 10000" > tmp_script_temp.sh
/usr/local/bin/parallel -j 10 bash tmp_script_temp.sh ::: {1..10}

