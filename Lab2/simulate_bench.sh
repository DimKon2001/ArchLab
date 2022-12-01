
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

	make $var SIZE_DCACHE="$l1ds"kB SIZE_ICACHE="$l1is"kB CACHE_LINE_SIZE="$ls" ASOC_DCACHE="$l1da" ASOC_ICACHE="$l1ia" SIZE_L2="$l2s"MB ASOC_L2="$l2a" FILE_ENDING=DL1_A_"$l1da"_S_"$l1ds"_IL1_A_"$l1ia"_S_"$l1is"_L2_A_"$l2A"_S_"$l2s"_LS_"$ls"

done
done
done
done
done
done
done
done

echo "[Benchmarks]" > spec_results/data.ini

find  spec_results/ -name "spechmmer*" |cat  >> spec_results/data.ini
find  spec_results/ -name "speclibm*" |cat  >> spec_results/data.ini

echo "[Parameters]" >> spec_results/data.ini

echo "system.cpu.cpi" >> spec_results/data.ini
echo "sim_seconds" >> spec_results/data.ini
echo "host_seconds" >> spec_results/data.ini
echo "system.cpu.dcache.overall_miss_rate::total" >> spec_results/data.ini
echo "system.cpu.icache.overall_miss_rate::total" >> spec_results/data.ini
echo "system.l2.overall_miss_rate::total" >> spec_results/data.ini

echo "[Output]" >> spec_results/data.ini

#Specify output file
echo "sim_results_1.txt" >> spec_results/data.ini

chmod +x ./read_results.sh
./read_results.sh spec_results/data.ini





