echo "[Benchmarks]" > spec_results/data.ini

find  spec_results/ -name "specmcf*" |cat  >> spec_results/data.ini
find  spec_results/ -name "speclibm*" |cat  >> spec_results/data.ini
find  spec_results/ -name "specbzip*" |cat  >> spec_results/data.ini
find  spec_results/ -name "specsjeng*" |cat  >> spec_results/data.ini
find  spec_results/ -name "spechmmer*" |cat  >> spec_results/data.ini

echo "[Parameters]" >> spec_results/data.iniß

echo "system.cpu.cpi" >> spec_results/data.ini
echo "sim_seconds" >> spec_results/data.ini
echo "host_seconds" >> spec_results/data.ini
echo "system.cpu.dcache.overall_miss_rate::total" >> spec_results/data.ini
echo "system.cpu.icache.overall_miss_rate::total" >> spec_results/data.ini
echo "system.l2.overall_miss_rate::total" >> spec_results/data.ini

echo "[Output]" >> spec_results/data.ini

#Specify output file
out="sim_results_1"
echo "$out".txt >> spec_results/data.ini

chmod +x ./read_results.sh
./read_results.sh spec_results/data.ini

mv ./spec_results/"$out".txt ./spec_results/"$out".csv 

