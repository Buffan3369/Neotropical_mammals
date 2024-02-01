#!/bin/bash

for trt in 1-Full 4-Tropical_Extratropical/Tropical 4-Tropical_Extratropical/Extratropical 5-Ecomorphotype/carnivore 5-Ecomorphotype/herbivore 5-Ecomorphotype/omnivore 5-Ecomorphotype/insectivore
do
	#mkdir -p ../results/MBD/$trt
	#cp ../results/SALMA_smoothed/genus_level/$trt/LTT/per_replicate/Combined_TsTe_from_replicates.txt ../results/MBD/$trt/
	echo "python3 ~/PyRate/PyRateMBD.py -d ../results/MBD/1-Full/Combined_TsTe_from_replicates.txt -var ../data_2023/MBD/processed_environment_predictors -m 0 -j \$1 -minT 23.03 -maxT 56 -n 10000000 -s 10000" > tmp_script.sh
	parallel -j 10 bash tmp_script.sh ::: {1..10}
done
