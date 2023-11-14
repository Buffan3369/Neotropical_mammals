#!/bin/bash

## Species analysis ----------------------------------------------------------------------------------------------------------
dir=/media/lucas/SAMSUNG/Internship_ISEM/Neotropical_Mammals/PyRate_outputs/RJMCMC_ICC_subepoch_21-06/EOT/SPECIES_LEVEL/entire
for odr in full SANU Metatheria Rodentia SANU Xenarthra
do
	for Q in stages 5M
	do
		Rscript ~/PyRate/plot_rates.r ${dir}/combined_logs/${odr}/q_${Q}/RTT_plots.r ${dir}/LTT/${odr}/q_${Q}/per_replicate/ ${dir}/Q_SHIFTS/${odr}/q_${Q}/Parsed_Q_rates.csv ../../figures/EOT/species_level/${odr}_RTT_LTT_q_${Q}.png
	done
done

## Genus analysis -----------------------------------------------------------------------------------------------------------
### REGULAR ###
dir=/media/lucas/SAMSUNG/Internship_ISEM/Neotropical_Mammals/PyRate_outputs/RJMCMC_ICC_subepoch_21-06/EOT/GENUS_LEVEL/EOCENE_OLIGOCENE_regular
echo "${dir}"
for Q in epochs stages 5M
do
	Rscript ~/PyRate/plot_rates.r ${dir}/combined_logs/q_${Q}/RTT_plots.r ${dir}/LTT/q_${Q}/per_replicate/ ${dir}/Q_SHIFTS/q_${Q}/Parsed_Q_rates.csv ../../figures/EOT/genus_level/regular/RTT_LTT_q_${Q}.png
done
### SINGLETON ###
dir=/media/lucas/SAMSUNG/Internship_ISEM/Neotropical_Mammals/PyRate_outputs/RJMCMC_ICC_subepoch_21-06/EOT/GENUS_LEVEL/EOCENE_OLIGOCENE_singleton
echo "${dir}"
for Q in stages 5M
do
	Rscript ~/PyRate/plot_rates.r ${dir}/combined_logs/q_${Q}/RTT_plots.r ${dir}/LTT/q_${Q}/per_replicate/ ${dir}/Q_SHIFTS/q_${Q}/Parsed_Q_rates.csv ../../figures/EOT/genus_level/singleton/RTT_LTT_q_${Q}.png
done
### SPATIALLY SCALED ###
dir=/media/lucas/SAMSUNG/Internship_ISEM/Neotropical_Mammals/PyRate_outputs/RJMCMC_ICC_subepoch_21-06/EOT/GENUS_LEVEL/EOCENE_OLIGOCENE_spatially_scaled
echo "${dir}"
for Q in stages 5M
do
	Rscript ~/PyRate/plot_rates.r ${dir}/combined_logs/q_${Q}/RTT_plots.r ${dir}/LTT/q_${Q}/per_replicate/ ${dir}/Q_SHIFTS/q_${Q}/Parsed_Q_rates.csv ../../figures/EOT/genus_level/spatially_scaled/RTT_LTT_q_${Q}.png
done
### ORDER ###
dir=/media/lucas/SAMSUNG/Internship_ISEM/Neotropical_Mammals/PyRate_outputs/RJMCMC_ICC_subepoch_21-06/EOT/GENUS_LEVEL/EOCENE_OLIGOCENE_order
echo "${dir}"
for odr in SANU Xenarthra Rodentia Metatheria
do
    for Q in stages 5M
    do
	    Rscript ~/PyRate/plot_rates.r ${dir}/combined_logs/${odr}/q_${Q}/RTT_plots.r ${dir}/LTT/${odr}/q_${Q}/per_replicate/ ${dir}/Q_SHIFTS/${odr}/q_${Q}/Parsed_Q_rates.csv ../../figures/EOT/genus_level/order/RTT_LTT_${odr}_q_${Q}.png
    done
done
### LATITUDINAL BINNING (thr=30°lat) ###
dir=/media/lucas/SAMSUNG/Internship_ISEM/Neotropical_Mammals/PyRate_outputs/RJMCMC_ICC_subepoch_21-06/EOT/GENUS_LEVEL/EOCENE_OLIGOCENE_LAT_PARTITIONING
echo "${dir}"
for zn in Tropical Extra.tropical
do
    for Q in stages 5M
    do
	    Rscript ~/PyRate/plot_rates.r ${dir}/combined_logs/${zn}/q_${Q}/RTT_plots.r ${dir}/LTT/${zn}/q_${Q}/per_replicate/ ${dir}/Q_SHIFTS/${zn}/q_${Q}/Parsed_Q_rates.csv ../../figures/EOT/genus_level/lat_binning/RTT_LTT_${zn}_q_${Q}.png
    done
done

## Simulation analysis -----------------------------------------------------------------------------------------------------
dir=/media/lucas/SAMSUNG/Internship_ISEM/Neotropical_Mammals/PyRate_outputs/simulations
for i in {0..9}
do
    echo "${dir}/LTT/replicate_$i/per_replicate"
    Rscript ~/PyRate/plot_rates.r ${dir}/combined_logs/replicate_$i/RTT_plots.r ${dir}/LTT/replicate_$i/per_replicate/ ${dir}/Q_SHIFTS/replicate_$i/Parsed_Q_rates.csv ../../figures/simulations/RTT_LTT_Q_repl_$i.png
done
