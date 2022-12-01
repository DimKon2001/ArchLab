
arr=("speclibm" "spechmmer")

L2A=(32 16 8)
L1DA=(8 4)
L1IA=(8 4)

L2S=(4) 
L1DS=(128)
L1IS=(128)

LS=(64 128 256)

for var in ${arr[@]}; do
for l1da in ${L1DA[@]}; do
for l1ia in ${L1IA[@]}; do
for l2a in ${L2A[@]}; do
for l1ds in ${L1DS[@]}; do
for l1is in ${L1IS[@]}; do
for l2s in ${L2S[@]}; do
for ls in ${LS[@]}; do

	make $var SIZE_DCACHE="$l1ds"kB SIZE_ICACHE="$l1is"kB CACHE_LINE_SIZE="$ls" ASOC_DCACHE="$l1da" ASOC_ICACHE="$l1ia" SIZE_L2="$l2s"MB ASOC_L2="$l2a" FILE_ENDING=DL1_A_"$l1da"_S_"$l1ds"_IL1_A_"$l1ia"_S_"$l1is"_L2_A_"$l2a"_S_"$l2s"_LS_"$ls"

done
done
done
done
done
done
done
done

chmod +x ./create_results.sh
./create_results.sh




