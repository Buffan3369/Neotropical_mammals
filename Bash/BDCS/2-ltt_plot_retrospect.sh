#!/bin/bash

for s in SALMA_smoothed SALMA_kept
do
	for ss in genus_level species_level
	do
		for odr in Notoungulata Other_SANUs Rodentia Xenarthra Metatheria
		do
			mkdir -p ../../results_EXTENDED/$s/$ss/6-Order_level/$odr/LTT/
			cp ../../results_EXTENDED/$s/$ss/6-Order_level/$odr/BDCS/*.txt ../../results_EXTENDED/$s/$ss/6-Order_level/$odr/LTT/
			python ~/PyRate/PyRate.py -d ../../results_EXTENDED/$s/$ss/6-Order_level/$odr/LTT/*.txt -ltt 1
		done
	done
done
