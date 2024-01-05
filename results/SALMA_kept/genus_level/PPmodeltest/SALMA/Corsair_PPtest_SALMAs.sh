#!/bin/bash

cntr=0
declare -i cntr
while [ ! -f result_boxplot.pdf ]; do
		cntr+=1
		echo "$cntr round of optimization"
		echo "python3.8 ~/PyRate/PyRate.py $1 -j \$1 -qShift ../../../../Q_rate_shifts/EO_SALMAs.txt -mG -PPmodeltest > File\$1.log" > tmp_script.sh
		parallel -j 10 bash tmp_script.sh ::: {1..10}
		bash ~/PP_automatest/parse_PPmodeltest_output.sh ${cntr}
		Rscript ~/PP_automatest/model_drafting.r tab.tsv ../../../../Q_rate_shifts/EO_SALMAs.txt
		rm tab.tsv
		rm tmp_script.sh
		sleep 1
done

