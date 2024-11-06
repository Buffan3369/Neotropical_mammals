#!/bin/bash

#for trt in 6-Order_level/Notoungulata/post_EECO 6-Order_level/Notoungulata/Oligocene_only 6-Order_level/Xenarthra/post_EECO 6-Order_level/Xenarthra/Oligocene_only
##1-Full/early_phase 1-Full/late_phase 1-Full/post_EECO \
##5-Ecomorphotype/carnivore 5-Ecomorphotype/omnivore 5-Ecomorphotype/insectivore \
##1-Full 1-Full/Eocene_only 1-Full/Oligocene_only \
##4-Tropical_Extratropical/Tropical 4-Tropical_Extratropical/Tropical/Eocene_only 4-Tropical_Extratropical/Tropical/Oligocene_only \
##4-Tropical_Extratropical/Extratropical 4-Tropical_Extratropical/Extratropical/Eocene_only 4-Tropical_Extratropical/Extratropical/Oligocene_only \
##4-Tropical_Extratropical/Extratropical/post_EECO 4-Tropical_Extratropical/Tropical/post_EECO \
##5-Ecomorphotype/herbivore  5-Ecomorphotype/herbivore/post_EECO  5-Ecomorphotype/herbivore/Oligocene \
##6-Order_level/Metatheria 6-Order_level/Rodentia 6-Order_level/Other_SANUs \
#do
#	python ~/Documents/GitHub/CorsaiR/Python/assess_run_convergence.py -dir "$PWD"/../../results/MBD/$trt/ -ana "MBD"
#	Rscript ~/Documents/GitHub/CorsaiR/R/plot_ess.r "$PWD"/../../results/MBD/$trt/ESS_summary.txt "$PWD"/../../results/MBD/$trt/ESS_plot.png
#done

dir=../../results_EXTENDED/MBD
#for s in SALMA_smoothed/genus_level
##SALMA_kept/genus_level 
#do
#	# Full
#	python ~/Documents/GitHub/CorsaiR/Python/assess_run_convergence.py -dir "$PWD"/$dir/$s/1-Full -ana "MBD"
#	Rscript ~/Documents/GitHub/CorsaiR/R/plot_ess.r "$PWD"/$dir/$s/1-Full/ESS_summary.txt "$PWD"/$dir/$s/1-Full/ESS_plot.png
#	python ~/Documents/GitHub/CorsaiR/Python/assess_run_convergence.py -dir "$PWD"/$dir/$s/1-Full/post_EECO -ana "MBD"
#	Rscript ~/Documents/GitHub/CorsaiR/R/plot_ess.r "$PWD"/$dir/$s/1-Full/post_EECO/ESS_summary.txt "$PWD"/$dir/$s/1-Full/post_EECO/ESS_plot.png
#	python ~/Documents/GitHub/CorsaiR/Python/assess_run_convergence.py -dir "$PWD"/$dir/$s/1-Full/Oligocene_only -ana "MBD"
#	Rscript ~/Documents/GitHub/CorsaiR/R/plot_ess.r "$PWD"/$dir/$s/1-Full/Oligocene_only/ESS_summary.txt "$PWD"/$dir/$s/1-Full/Oligocene_only/ESS_plot.png
#	# Order level
#	for odr in Notoungulata 
#	#Other_SANUs Rodentia Metatheria Xenarthra
#	do
#		python ~/Documents/GitHub/CorsaiR/Python/assess_run_convergence.py -dir "$PWD"/$dir/$s/6-Order_level/$odr -ana "MBD"
#		Rscript ~/Documents/GitHub/CorsaiR/R/plot_ess.r "$PWD"/$dir/$s/6-Order_level/$odr/ESS_summary.txt "$PWD"/$dir/$s/6-Order_level/$odr/ESS_plot.png
#		python ~/Documents/GitHub/CorsaiR/Python/assess_run_convergence.py -dir "$PWD"/$dir/$s/6-Order_level/$odr/post_EECO -ana "MBD"
#		Rscript ~/Documents/GitHub/CorsaiR/R/plot_ess.r "$PWD"/$dir/$s/6-Order_level/$odr/post_EECO/ESS_summary.txt "$PWD"/$dir/$s/6-Order_level/$odr/post_EECO/ESS_plot.png
#		python ~/Documents/GitHub/CorsaiR/Python/assess_run_convergence.py -dir "$PWD"/$dir/$s/6-Order_level/$odr/Oligocene_only -ana "MBD"
#		Rscript ~/Documents/GitHub/CorsaiR/R/plot_ess.r "$PWD"/$dir/$s/6-Order_level/$odr/Oligocene_only/ESS_summary.txt "$PWD"/$dir/$s/6-Order_level/$odr/Oligocene_only/ESS_plot.png
#	done
#done

for lat in LOWLAT HIGHLAT
do
	# Full
	python ~/Documents/GitHub/CorsaiR/Python/assess_run_convergence.py -dir $dir/SALMA_smoothed/genus_level/andes_diff/$lat -ana "MBD"
	Rscript ~/Documents/GitHub/CorsaiR/R/plot_ess.r $dir/SALMA_smoothed/genus_level/andes_diff/$lat/ESS_summary.txt $dir/SALMA_smoothed/genus_level/andes_diff/$lat/ESS_plot.png
	# Post EECO
	python ~/Documents/GitHub/CorsaiR/Python/assess_run_convergence.py -dir $dir/SALMA_smoothed/genus_level/andes_diff/$lat/post_EECO -ana "MBD"
	Rscript ~/Documents/GitHub/CorsaiR/R/plot_ess.r $dir/SALMA_smoothed/genus_level/andes_diff/$lat/post_EECO/ESS_summary.txt $dir/SALMA_smoothed/genus_level/andes_diff/$lat/post_EECO/ESS_plot.png
	# Oligocene only
	python ~/Documents/GitHub/CorsaiR/Python/assess_run_convergence.py -dir $dir/SALMA_smoothed/genus_level/andes_diff/$lat/Oligocene_only -ana "MBD"
	Rscript ~/Documents/GitHub/CorsaiR/R/plot_ess.r $dir/SALMA_smoothed/genus_level/andes_diff/$lat/Oligocene_only/ESS_summary.txt $dir/SALMA_smoothed/genus_level/andes_diff/$lat/Oligocene_only/ESS_plot.png

done
