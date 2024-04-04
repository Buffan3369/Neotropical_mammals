#!/bin/bash

##################################################################################### SALMA smoothed genus level #####################################################################################
for s in SALMA_kept SALMA_smoothed
do
	for ss in genus_level species_level
	do
		## Full dataset ----------------------------------
		    # All times
		rm ../MBD/$s/$ss/1-Full/*.log ../MBD/$s/$ss/1-Full/ESS*
		    # Post-EECO
		rm ../MBD/$s/$ss/1-Full/post_EECO/*.log ../MBD/$s/$ss/1-Full/post_EECO/ESS*
		    # Oligocene
		rm ../MBD/$s/$ss/1-Full/Oligocene_only/*.log ../MBD/$s/$ss/1-Full/Oligocene_only/ESS*
		
		## Order-level dataset ---------------------------
		for odr in Notoungulata Other_SANUs Rodentia Xenarthra Metatheria
		do
			    # All times
			rm ../MBD/$s/$ss/6-Order_level/$odr/*.log ../MBD/$s/$ss/6-Order_level/$odr/ESS*
			    # Post-EECO
			rm ../MBD/$s/$ss/6-Order_level/$odr/post_EECO/*.log ../MBD/$s/$ss/6-Order_level/$odr/post_EECO/ESS*
			    # Oligocene
			rm ../MBD/$s/$ss/6-Order_level/$odr/Oligocene_only/*.log ../MBD/$s/$ss/6-Order_level/$odr/Oligocene_only/ESS*
			
		done

	done
done
