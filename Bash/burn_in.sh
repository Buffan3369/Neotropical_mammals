#!/bin/bash

declare -A burnin1=([SALMA_kept/genus_level/1-Full]=500 [SALMA_kept/genus_level/2-Singleton]=50 [SALMA_kept/genus_level/3-Spatially_scaled]=10 \
		[SALMA_kept/genus_level/4-Tropical_Extratropical/Tropical]=10 [SALMA_kept/genus_level/4-Tropical_Extratropical/Extratropical]=50 \
		[SALMA_kept/genus_level/5-Ecomorphotype/carnivore]=10 [SALMA_kept/genus_level/5-Ecomorphotype/herbivore]=10 [SALMA_kept/genus_level/5-Ecomorphotype/omnivore]=10 \
		[SALMA_kept/genus_level/5-Ecomorphotype/insectivore]=10 \
		##
		[SALMA_kept/species_level/1-Full]=250 [SALMA_kept/species_level/2-Singleton]=250 [SALMA_kept/species_level/3-Spatially_scaled]=50 \
		[SALMA_kept/species_level/4-Tropical_Extratropical/Tropical]=10 [SALMA_kept/species_level/4-Tropical_Extratropical/Extratropical]=50 \
		[SALMA_kept/species_level/5-Ecomorphotype/carnivore]=10 [SALMA_kept/species_level/5-Ecomorphotype/herbivore]=50 [SALMA_kept/species_level/5-Ecomorphotype/omnivore]=10 \
		[SALMA_kept/species_level/5-Ecomorphotype/insectivore]=10 \
		##
		[SALMA_smoothed/genus_level/1-Full]=10 [SALMA_smoothed/genus_level/2-Singleton]=10 [SALMA_smoothed/genus_level/3-Spatially_scaled]=10 \
		[SALMA_smoothed/genus_level/4-Tropical_Extratropical/Tropical]=10 [SALMA_smoothed/genus_level/4-Tropical_Extratropical/Extratropical]=10 \
		[SALMA_smoothed/genus_level/5-Ecomorphotype/carnivore]=10 [SALMA_smoothed/genus_level/5-Ecomorphotype/herbivore]=10 [SALMA_smoothed/genus_level/5-Ecomorphotype/omnivore]=10 \
		[SALMA_smoothed/genus_level/5-Ecomorphotype/insectivore]=10 \
		##
		[SALMA_smoothed/species_level/1-Full]=250 [SALMA_smoothed/species_level/2-Singleton]=50 [SALMA_smoothed/species_level/3-Spatially_scaled]=10 \
		[SALMA_smoothed/species_level/4-Tropical_Extratropical/Tropical]=10 [SALMA_smoothed/species_level/4-Tropical_Extratropical/Extratropical]=50 \
		[SALMA_smoothed/species_level/5-Ecomorphotype/carnivore]=10 [SALMA_smoothed/species_level/5-Ecomorphotype/herbivore]=10 [SALMA_smoothed/species_level/5-Ecomorphotype/omnivore]=10 \
		[SALMA_smoothed/species_level/5-Ecomorphotype/insectivore]=10)
