#!/bin/bash

for s in SALMA_kept SALMA_smoothed
do
	for ss in genus_level species_level
	do
		mkdir ./$s/$ss/1-Full
		mkdir ./$s/$ss/2-Singleton
		mkdir ./$s/$ss/3-Spatially_scaled
		mkdir ./$s/$ss/4-Tropical_Extratropical
		mkdir ./$s/$ss/5-Ecomorphotype
	done
done
