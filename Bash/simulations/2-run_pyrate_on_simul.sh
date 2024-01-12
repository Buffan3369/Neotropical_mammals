#!/bin/bash

for i in {42..55}
do
	echo "python3 ~/PyRate/PyRate.py -A 4 ../../results/SALMA_smoothed/genus_level/simulations/replicate_$i/sampled_simulated_occurrences_${i}_PyRate.py -qShift ../../data_2023/EO_stages.txt -pL 1.1 0 -pM 1.1 0 -pP 2 0 -mG -j \$1 -n 10000000 -s 10000" > tmp_script.sh
	parallel -j 10 bash tmp_script.sh ::: {1..10}
done
