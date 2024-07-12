#!/bin/bash

#for s in SALMA_kept SALMA_smoothed
#do
#	mkdir -p data_2023/PyRate/EXTENDED/$s
#	for ss in genus_level species_level
#	do
#		mkdir -p data_2023/PyRate/EXTENDED/$s/$ss
#		mkdir -p data_2023/PyRate/EXTENDED/$s/$ss/1-Full
#		mkdir -p data_2023/PyRate/EXTENDED/$s/$ss/2-Spatially_scaled
#		mkdir -p data_2023/PyRate/EXTENDED/$s/$ss/3-Tropical_Extratropical
#		mkdir -p data_2023/PyRate/EXTENDED/$s/$ss/4-Ecomorphotype
#		mkdir -p data_2023/PyRate/EXTENDED/$s/$ss/5-Order_level
#		for odr in Notoungulata Other_SANUs Xenarthra Metatheria Rodentia
#		do
#			mkdir -p ./data_2023/PyRate/EXTENDED/$s/$ss/5-Order_level/${odr}
#		done
#	done
#done


#mkdir -p ../../results_EXTENDED
for s in SALMA_kept SALMA_smoothed
do
#	mkdir -p ../../results_EXTENDED/$s
	for ss in genus_level species_level
	do
#		mkdir -p ../../results_EXTENDED/$s/$ss
#		mkdir -p ../../results_EXTENDED/$s/$ss/1-Full
#		cp EXTENDED/$s/$ss/1-Full/*_PyRate.py ../../results_EXTENDED/$s/$ss/1-Full/
#		mkdir -p ../../results_EXTENDED/$s/$ss/2-Singleton
#		cp EXTENDED/$s/$ss/1-Full/*_PyRate.py ../../results_EXTENDED/$s/$ss/2-Singleton/
#		mkdir -p ../../results_EXTENDED/$s/$ss/3-Spatially_scaled
#		cp EXTENDED/$s/$ss/2-Spatially_scaled/*_PyRate.py ../../results_EXTENDED/$s/$ss/3-Spatially_scaled/
#		mkdir -p ../../results_EXTENDED/$s/$ss/4-Tropical_Extratropical
#		cp EXTENDED/$s/$ss/3-Tropical_Extratropical/*_PyRate.py ../../results_EXTENDED/$s/$ss/4-Tropical_Extratropical/
#		mkdir -p ../../results_EXTENDED/$s/$ss/5-Ecomorphotype
#		cp EXTENDED/$s/$ss/4-Ecomorphotype/*_PyRate.py ../../results_EXTENDED/$s/$ss/5-Ecomorphotype/
#		mkdir -p ../../results_EXTENDED/$s/$ss/6-Order_level
		for odr in Notoungulata Other_SANUs Xenarthra Metatheria Rodentia
		do
#			mkdir -p ../../results_EXTENDED/$s/$ss/6-Order_level/${odr}
			cp EXTENDED/$s/$ss/5-Order_level/${odr}_*_PyRate.py ../../results_EXTENDED/$s/$ss/6-Order_level/${odr}
		done
	done
done

