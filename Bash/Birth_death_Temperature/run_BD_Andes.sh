#!/bin/bash

## Birth Death model with time-continuous correlate applied to andean uplift 
        # Post EECO
echo "python3 ~/PyRate/PyRateContinuous.py -d ../../BDT/Corr_andes/post_EECO/*se_est.txt -c ../../BDT/predictors/2-Andes_mean_elevations_post_EECO_500ky_step.txt -j \$1 -n 10000000 -s 10000" > tmp_script_andes.sh
/usr/local/bin/parallel -j 10 bash tmp_script_andes.sh ::: {1..10}

        # Oligocene only
echo "python3 ~/PyRate/PyRateContinuous.py -d ../../BDT/Corr_andes/Oligocene_only/*se_est.txt -c ../../BDT/predictors/2-Andes_mean_elevations_Oligocene_only_500ky_step.txt -j \$1 -n 10000000 -s 10000" > tmp_script_andes.sh
/usr/local/bin/parallel -j 10 bash tmp_script_andes.sh ::: {1..10}

