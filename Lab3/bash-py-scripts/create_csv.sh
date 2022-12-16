ENERGY='energies'
KEYWORDS=("energy" "runtime")
COST='cost'

mkdir $COST

FOLDS=$(ls $ENERGY/)

for f in ${FOLDS[@]}
do
	OUT=$COST/$f-cost.txt
	echo -n '' > $OUT
	echo "Benchmark, $f ,Energy, Runtime" >> $OUT
	SUBFOLDS=$(ls $ENERGY/$f/)	
	
	for sf in ${SUBFOLDS[@]}	
	do

	SIMS=$(ls $ENERGY/$f/$sf/)
	for sim in $SIMS
	do
		echo $sim | grep -Po '(spec)\K\D*(?=_)' |xargs echo -n >> $OUT
		echo $sf | grep -Po '(=)\K\d+' | xargs echo -n , >> $OUT
		for key in ${KEYWORDS[@]}
		do
			grep -oP "($key\D*)\K( (\d)+ | (\d+.\d+))" $ENERGY/$f/$sf/$sim | xargs echo -n , >> $OUT
		done
		echo '' >> $OUT
	done				
	done

mv $OUT $COST/$f-cost.csv
done

