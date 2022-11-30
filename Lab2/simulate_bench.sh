#speclibm
make speclibm ASOC_DCACHE=4 FILE_ENDING=DL1_A_4
make speclibm ASOC_DCACHE=1 FILE_ENDING=DL1_A_1
make speclibm ASOC_ICACHE=4 FILE_ENDING=IL1_A_4
make speclibm ASOC_ICACHE=1 FILE_ENDING=IL1_A_1
make speclibm ASOC_L2=4 FILE_ENDING=L2_A_4
make speclibm ASOC_L2=16 FILE_ENDING=L2_A_16

make speclibm SIZE_DCACHE=128kB FILE_ENDING=DL1_S_128
make speclibm SIZE_DCACHE=32kB FILE_ENDING=DL1_S_32
make speclibm SIZE_ICACHE=128kB FILE_ENDING=IL1_S_128
make speclibm SIZE_ICACHE=32kB FILE_ENDING=IL1_S_32
make speclibm SIZE_L2=4MB FILE_ENDING=L2_S_4
make speclibm SIZE_L2=1MB FILE_ENDING=L2_S_1

make speclibm CACHE_LINE_SIZE=32 FILE_ENDING=LS_32
make speclibm CACHE_LINE_SIZE=128 FILE_ENDING=LS_128

#spechmmer
make spechmmer ASOC_DCACHE=4 FILE_ENDING=DL1_A_4
make spechmmer ASOC_DCACHE=1 FILE_ENDING=DL1_A_1
make spechmmer ASOC_ICACHE=4 FILE_ENDING=IL1_A_4
make spechmmer ASOC_ICACHE=1 FILE_ENDING=IL1_A_1
make spechmmer ASOC_L2=4 FILE_ENDING=L2_A_4
make spechmmer ASOC_L2=16 FILE_ENDING=L2_A_16

make spechmmer SIZE_DCACHE=128kB FILE_ENDING=DL1_S_128
make spechmmer SIZE_DCACHE=32kB FILE_ENDING=DL1_S_32
make spechmmer SIZE_ICACHE=128kB FILE_ENDING=IL1_S_128
make spechmmer SIZE_ICACHE=32kB FILE_ENDING=IL1_S_32
make spechmmer SIZE_L2=4MB FILE_ENDING=L2_S_4
make spechmmer SIZE_L2=1MB FILE_ENDING=L2_S_1

make spechmmer CACHE_LINE_SIZE=32 FILE_ENDING=LS_32
make spechmmer CACHE_LINE_SIZE=128 FILE_ENDING=LS_128

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





