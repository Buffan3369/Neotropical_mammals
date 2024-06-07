cntr=0
declare -i cntr
while [ ! -f result_boxplot.pdf ]; do
		cntr+=1
		echo "$cntr round of optimization"
		echo "python3 ~/PyRate/PyRate.py  $1 -j \$1 -qShift $2 -mG -PPmodeltest > File\$1.log" > tmp_script.sh
		parallel -j 10 bash tmp_script.sh ::: {1..10}
		./parse_PPmodeltest_output.sh 
		Rscript model_drafting.r tab.tsv $2
		rm tab.tsv
		rm tmp_script.sh
		sleep 1
done
