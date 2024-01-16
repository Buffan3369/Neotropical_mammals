#!/bin/bash

for s in SALMA_kept SALMA_smoothed
do
	for ss in genus_level species_level
	do
		rm -r ./../results/$s/$ss/6-Order-level
		mkdir -p ../../results/$s/$ss/6-Order_level
		for odr in Notoungulata Other_SANUs Xenarthra Metatheria Rodentia
		do
			mkdir -p ../../results/$s/$ss/6-Order_level/${odr}
			cp ./$s/$ss/5-Order_level/${odr}_*_PyRate.py ../../results/$s/$ss/6-Order_level/${odr}
		done
	done
done

