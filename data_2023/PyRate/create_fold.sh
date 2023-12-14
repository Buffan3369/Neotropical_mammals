#!/bin/bash

for s in SALMA_kept SALMA_smoothed
do
	for ss in genus_level species_level
	do
		mkdir ./$s/$ss/5-Order_level
	done
done
