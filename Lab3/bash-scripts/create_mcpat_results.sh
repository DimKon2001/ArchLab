
TEMPLATE='inorder_arm.xml'
MCPAT='../mcpat'
GEM5='gem5-results'
XML='xml'
RES='mcpat-results'

mkdir $RES
mkdir $XML

FOLDS=$(ls $GEM5/)

for f in ${FOLDS[@]}
do
	SUBFOLDS=$(ls $GEM5/$f/)	

	mkdir $RES/$f
	mkdir $XML/$f
	
	for sf in ${SUBFOLDS[@]}	
	do

		if $([[ $sf == *"spec"* ]]); then
  			#python GEM5ToMcPAT.py -o $XML/$f/$sf.xml $GEM5/$f/$sf/stats.txt $GEM5/$f/$sf/config.json $TEMPLATE 
		
			#$MCPAT/mcpat -infile $XML/$f/$sf.xml -print_level 5 > $RES/$f/$sf.txt	
		else
			SIMS=$(ls $GEM5/$f/$sf/)
			for sim in ${SIMS[@]}
			do
				mkdir $RES/$f/$sf
				mkdir $XML/$f/$sf				

				#python GEM5ToMcPAT.py -o $XML/$f/$sf/$sim.xml $GEM5/$f/$sf/$sim/stats.txt $GEM5/$f/$sf/$sim/config.json $TEMPLATE 
		
				#$MCPAT/mcpat -infile $XML/$f/$sf/$sim.xml -print_level 5 > $RES/$f/$sf/$sim.txt	
			done			
		fi
		
	done
done
