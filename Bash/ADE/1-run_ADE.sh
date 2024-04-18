#!/bin/bash

## SALMA smoothed ##
	# early phase
echo "python ../../PyRate/PyRate.py -ADE 1 ../ADE/SALMA_smoothed/genus_level/1-Full/*_PyRate.py -j \$1 -filter 56 39 -qShift ../epochs.txt -n 50000000 -s 50000" > tmp_script_ade.sh
/usr/local/bin/parallel -j 20 bash tmp_script_ade.sh ::: {1..20}
	# late phase
echo "python ../../PyRate/PyRate.py -ADE 1 ../ADE/SALMA_smoothed/genus_level/1-Full/*_PyRate.py -j \$1 -filter 39 23 -qShift ../epochs.txt -n 50000000 -s 50000" > tmp_script_ade.sh
/usr/local/bin/parallel -j 20 bash tmp_script_ade.sh ::: {1..20}

## SALMA kept ##
	# early phase
echo "python ../../PyRate/PyRate.py -ADE 1 ../ADE/SALMA_kept/genus_level/1-Full/*_PyRate.py -j \$1 -filter 56 39 -qShift ../epochs.txt -n 50000000 -s 50000" > tmp_script_ade.sh
/usr/local/bin/parallel -j 20 bash tmp_script_ade.sh ::: {1..20}
	# late phase
echo "python ../../PyRate/PyRate.py -ADE 1 ../ADE/SALMA_kept/genus_level/1-Full/*_PyRate.py -j \$1 -filter 39 23 -qShift ../epochs.txt -n 50000000 -s 50000" > tmp_script_ade.sh
/usr/local/bin/parallel -j 20 bash tmp_script_ade.sh ::: {1..20}
