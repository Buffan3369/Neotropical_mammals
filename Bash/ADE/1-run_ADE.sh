#!/bin/bash

## SALMA smoothed ##
	# early phase
#echo "python3 ~/PyRate/PyRate.py -ADE 1 ../../results_EXTENDED/ADE/SALMA_smoothed/genus_level/1-Full_early/*_PyRate.py -j \$1 -filter 56 39 -qShift EO_stages.txt -mG -n 50000000 -s 50000" > tmp_script_ade.sh
#parallel -j 20 bash tmp_script_ade.sh ::: {1..20}
	# late phase
#echo "python3 ~/PyRate/PyRate.py -ADE 1 ../../results_EXTENDED/ADE/SALMA_smoothed/genus_level/1-Full_late/*_PyRate.py -j \$1 -filter 39 23 -qShift EO_stages.txt -mG -n 50000000 -s 50000" > tmp_script_ade.sh
#parallel -j 20 bash tmp_script_ade.sh ::: {1..20}

## SALMA kept ##
	# early phase
#echo "python3 ~/PyRate/PyRate.py -ADE 1 ../../results_EXTENDED/ADE/SALMA_kept/genus_level/1-Full_early/*_PyRate.py -j \$1 -filter 56 39 -qShift EO_stages.txt -mG -n 50000000 -s 50000" > tmp_script_ade.sh
#parallel -j 20 bash tmp_script_ade.sh ::: {1..20}
#	# late phase
#echo "python3 ~/PyRate/PyRate.py -ADE 1 ../../results_EXTENDED/ADE/SALMA_kept/genus_level/1-Full_late/*_PyRate.py -j \$1 -filter 39 23 -qShift EO_stages.txt -mG -n 50000000 -s 50000" > tmp_script_ade.sh

#parallel -j 20 bash tmp_script_ade.sh ::: {1..20}


	# SALMA smoothed late phase without -mG
echo "python3 ~/PyRate/PyRate.py -ADE 1 ../../results_EXTENDED/ADE/SALMA_smoothed/genus_level/1-Full_late/*_PyRate.py -j \$1 -filter 39 23 -qShift ../../data_2023/Extended_EO_stages.txt -n 50000000 -s 50000" > tmp_script_ade.sh
parallel -j 20 bash tmp_script_ade.sh ::: {1..20}
