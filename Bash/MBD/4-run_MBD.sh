#!/bin/bash

##################################################################################### SALMA smoothed genus level #####################################################################################
for ss in genus_level species_level
do
	## Full dataset ----------------------------------
	# All times
	echo "python3 ~/PyRate/PyRateMBD.py -d ../../results_EXTENDED/MBD/SALMA_kept/$ss/1-Full/*.txt -var ../../data_2023/MBD/processed_predictors_EXTENDED -m 0 -j \$1 -minT 23.03 -maxT 56 -n 10000000 -s 10000" > tmp_script1.sh
	/usr/local/bin/parallel -j 10 bash tmp_script1.sh ::: {0..10}
	    # Post-EECO
	echo "python3 ~/PyRate/PyRateMBD.py -d ../../results_EXTENDED/MBD/SALMA_kept/$ss/1-Full/post_EECO/*.txt -var ../../data_2023/MBD/processed_predictors_EXTENDED -m 0 -j \$1 -minT 33.9 -maxT 51 -n 10000000 -s 10000" > tmp_script1.sh
	/usr/local/bin/parallel -j 10 bash tmp_script1.sh ::: {0..10}
	    # Oligocene
	echo "python3 ~/PyRate/PyRateMBD.py -d ../../results_EXTENDED/MBD/SALMA_kept/$ss/1-Full/Oligocene_only/*.txt -var ../../data_2023/MBD/processed_predictors_EXTENDED -m 0 -j \$1 -minT 23.03 -maxT 33.9 -n 10000000 -s 10000" > tmp_script1.sh
	/usr/local/bin/parallel -j 10 bash tmp_script1.sh ::: {0..10}

	## Order-level dataset ---------------------------
	for odr in Notoungulata Other_SANUs Rodentia Xenarthra Metatheria
	do
		# All times
	    echo "python3 ~/PyRate/PyRateMBD.py -d ../../results_EXTENDED/MBD/SALMA_kept/$ss/6-Order_level/$odr/*.txt -var ../../data_2023/MBD/processed_predictors_EXTENDED -m 0 -j \$1 -minT 23.03 -maxT 56 -n 10000000 -s 10000" > tmp_script1.sh
	    /usr/local/bin/parallel -j 10 bash tmp_script1.sh ::: {0..10}
	    # Post-EECO
	    echo "python3 ~/PyRate/PyRateMBD.py -d ../../results_EXTENDED/MBD/SALMA_kept/$ss/6-Order_level/$odr/post_EECO/*.txt -var ../../data_2023/MBD/processed_predictors_EXTENDED -m 0 -j \$1 -minT 33.9 -maxT 51 -n 10000000 -s 10000" > tmp_script1.sh
	    /usr/local/bin/parallel -j 10 bash tmp_script1.sh ::: {0..10}
	    # Oligocene
	    echo "python3 ~/PyRate/PyRateMBD.py -d ../../results_EXTENDED/MBD/SALMA_kept/$ss/6-Order_level/$odr/Oligocene_only/*.txt -var ../../data_2023/MBD/processed_predictors_EXTENDED -m 0 -j \$1 -minT 23.03 -maxT 33.9 -n 10000000 -s 10000" > tmp_script1.sh
	    /usr/local/bin/parallel -j 10 bash tmp_script1.sh ::: {0..10}
	done

done
