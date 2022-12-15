ENERGY='energies'
OUT='mcpat_energies.txt'
KEYWORDS=("energy" "runtime")

echo '' > $OUT

echo 'Simulation, Energy, Runtime' >> $OUT



FOLDS=$(ls $ENERGY/)

for f in ${FOLDS[@]}
do
	SUBFOLDS=$(ls $ENERGY/$f/)	
	
	for sf in ${SUBFOLDS[@]}	
	do

		if $([[ $sf == *"spec"* ]]); then
			echo -n $sf, >> $OUT
			for key in ${KEYWORDS[@]}
			do
  				grep -oP "($key\D*)\K( (\d)+ | (\d+.\d+))" $ENERGY/$f/$sf | xargs echo -n >> $OUT
				echo -n ',' >> $OUT
			done
			echo '' >> $OUT
		else
			SIMS=$(ls $ENERGY/$f/$sf/)
			for sim in $SIMS
			do
				echo -n $sim, >> $OUT
				for key in ${KEYWORDS[@]}
				do
	  				grep -oP "($key\D*)\K( (\d)+ | (\d+.\d+))" $ENERGY/$f/$sf/$sim | xargs echo -n >> $OUT
	 				echo -n ',' >> $OUT
				done
				echo '' >> $OUT
			done		
		fi
		
	done
done
