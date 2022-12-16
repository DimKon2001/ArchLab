SEARCH='mcpat-results'
OUTFOLD='peak-power'

mkdir $OUTFOLD

FOLDS=$(ls $SEARCH/)
for f in ${FOLDS[@]}
do
	OUT=$OUTFOLD/$f-peak-power.txt
	echo -n '' > $OUT
	echo "$f, $OUTFOLD" >> $OUT
	SUBFOLDS=$(ls $SEARCH/$f/)	
	for sf in ${SUBFOLDS[@]}	
	do

	sim=$( find $SEARCH/$f/$sf -name "*specbzip*")
	
	
		echo $sf | grep -Po '(=)\K\d+' | xargs echo -n >> $OUT

		grep -oP "(Peak Power = )\K((\d+.\d+)|(\d+))" $sim | xargs echo , >> $OUT				
	done

mv $OUT $OUTFOLD/$f-peak-power.csv
done

