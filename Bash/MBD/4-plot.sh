#!/bin/bash

for dir in 1-Full/early_phase 1-Full/late_phase 1-Full/post_EECO \
5-Ecomorphotype/carnivore 5-Ecomorphotype/herbivore 5-Ecomorphotype/omnivore 5-Ecomorphotype/insectivore \
1-Full/Eocene_only 1-Full/Oligocene_only \
4-Tropical_Extratropical/Tropical 4-Tropical_Extratropical/Tropical/Eocene_only 4-Tropical_Extratropical/Tropical/Oligocene_only \
4-Tropical_Extratropical/Extratropical 4-Tropical_Extratropical/Extratropical/Eocene_only 4-Tropical_Extratropical/Extratropical/Oligocene_only
do
	python3 ~/PyRate/PyRateMBD.py -d ../../results/MBD/$dir/Combined_TsTe_from_replicates.txt -var ../../data_2023/MBD/processed_environment_predictors -m 0 -plot ../../results/MBD/$dir/combined_*.log

done
