#!/bin/bash

cntr=0
declare -i cntr
while [ ! -f result_boxplot.pdf ]; do
		cntr+=1
		echo "$cntr round of optimization"
		echo "python ~/PyRate/PyRate.py $1 -j \$1 -qShift ../../../../data_2023/SALMAs_bins.txt -mG -PPmodeltest > File\$1.log" > tmp_script.sh
		parallel -j 10 bash tmp_script.sh ::: {1..10}
		bash ~/Documents/GitHub/Corsair/PP_automatest/parse_PPmodeltest_output.sh ${cntr}
		Rscript ~/Documents/GitHub/Corsair/PP_automatest/model_drafting.r tab.tsv ../../../../data_2023/SALMAs_bins.txt
		rm tab.tsv
		rm tmp_script.sh
		sleep 1
done

