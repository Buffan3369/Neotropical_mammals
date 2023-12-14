#!/bin/bash

for s in SALMA_kept SALMA_smoothed
do
	for ss in genus_level species_level
	do
		rm -r ./$s/$ss/2-Singleton
		mv ./$s/$ss/3-Spatially_scaled ./$s/$ss/2-Spatially_scaled
		mv ./$s/$ss/4-Tropical_Extratropical ./$s/$ss/3-Tropical_Extratropical
		mv ./$s/$ss/5-Ecomorphotype ./$s/$ss/4-Ecomorphotype
	done
done
