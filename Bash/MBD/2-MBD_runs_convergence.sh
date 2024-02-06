#!/bin/bash

for trt in 1-Full 1-Full/Eocene_only 1-Full/Oligocene_only \
#4-Tropical_Extratropical/Tropical 4-Tropical_Extratropical/Tropical/Eocene_only 4-Tropical_Extratropical/Tropical/Oligocene_only \
#4-Tropical_Extratropical/Extratropical 4-Tropical_Extratropical/Extratropical/Eocene_only 4-Tropical_Extratropical/Extratropical/Oligocene_only \
#5-Ecomorphotype/carnivore 5-Ecomorphotype/herbivore 5-Ecomorphotype/omnivore 5-Ecomorphotype/insectivore
do
	python ~/Documents/GitHub/CorsaiR/Python/assess_run_convergence.py -dir "$PWD"/../../results/MBD/$trt/ -ana "MBD"
	Rscript ~/Documents/GitHub/CorsaiR/R/plot_ess.r "$PWD"/../../results/MBD/$trt/ESS_summary.txt "$PWD"/../../results/MBD/$trt/ESS_plot.png
done

