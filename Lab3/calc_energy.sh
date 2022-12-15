
GEM5='gem5-results'
RES='mcpat-results'
OUT='energies'

mkdir $OUT

FOLDS=$(ls $GEM5/)

for f in ${FOLDS[@]}
do
	SUBFOLDS=$(ls $GEM5/$f/)	

	mkdir $OUT/$f
	
	for sf in ${SUBFOLDS[@]}	
	do

		if $([[ $sf == *"spec"* ]]); then
  			python print_energy.py $RES/$f/$sf.txt $GEM5/$f/$sf/stats.txt > $OUT/$f/energy-$sf.txt

		else
			SIMS=$(ls $GEM5/$f/$sf/)
			for sim in ${SIMS[@]}
			do
				mkdir $OUT/$f/$sf
				python print_energy.py $RES/$f/$sf/$sim.txt $GEM5/$f/$sf/$sim/stats.txt > $OUT/$f/$sf/energy-$sim.txt				

				
			done			
		fi
		
	done
done
