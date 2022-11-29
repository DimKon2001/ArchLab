#Makefile for running spec_2006 benchmarks on gem5

GEM5 = ./build/ARM/gem5.opt

CONFIG = configs/example/se.py

RESULTS = spec_results

PARAM = --cpu-type=MinorCPU --caches --l2cache 

INST = -I 100000000

BENCHMARKS = specbzip specmcf spechmmer specsjeng speclibm

DATA_ZIP =  "spec_cpu2006/401.bzip2/data/input.program 10"
DATA_MCF = "spec_cpu2006/429.mcf/data/inp.in" 
DATA_HMMER = "--fixed 0 --mean 325 --num 45000 --sd 200 --seed0spec_cpu2006/456.hmmer/data/bombesin.hmm"
DATA_SJENG = "spec_cpu2006/458.sjeng/data/test.txt"
DATA_LBM = "20 spec_cpu2006/470.lbm/data/lbm.in 0 1 spec_cpu2006/470.lbm/data/100_100_130_cf_a.of" 

#===================HERE WE CHANGE THE VALUES=====================#
#Change this value to test different clock frequencies, RAM, ...
#Also set the new FILE_ENDING

CLOCK = 2GHz
#RAM = DDR3_1600_x64


FILE_ENDING=$(CLOCK)
#FILE_ENDING=$(CLOCK)_$(RAM)
#=================================================================#

OUT_DIR = spec_results/specbzip_$(FILE_ENDING) spec_results/specmcf_$(FILE_ENDING) spec_results/spechmmer_$(FILE_ENDING) spec_results/specsjeng_$(FILE_ENDING) spec_results/speclibm_$(FILE_ENDING) 

all: $(BENCHMARKS)

specbzip: spec_results/specbzip_$(FILE_ENDING)

specmcf: spec_results/specmcf_$(FILE_ENDING)

spechmmer: spec_results/spechmmer_$(FILE_ENDING)

specsjeng: spec_results/specsjeng_$(FILE_ENDING)

speclibm: spec_results/speclibm_$(FILE_ENDING)

spec_results/specbzip_$(FILE_ENDING):
	$(GEM5) -d $@ $(CONFIG) $(PARAM) --cpu-clock=$(CLOCK) -c spec_cpu2006/401.bzip2/src/specbzip -o $(DATA_ZIP) $(INST)

spec_results/specmcf_$(FILE_ENDING):
	$(GEM5) -d $@ $(CONFIG) $(PARAM) --cpu-clock=$(CLOCK) -c spec_cpu2006/429.mcf/src/specmcf -o $(DATA_MCF) $(INST)

spec_results/spechmmer_$(FILE_ENDING):
	$(GEM5) -d $@ $(CONFIG) $(PARAM) --cpu-clock=$(CLOCK) -c spec_cpu2006/456.hmmer/src/spechmmer -o $(DATA_HMMER) $(INST)

spec_results/specsjeng_$(FILE_ENDING):
	$(GEM5) -d $@ $(CONFIG) $(PARAM) --cpu-clock=$(CLOCK) -c spec_cpu2006/458.sjeng/src/specsjeng -o $(DATA_SJENG) $(INST)

spec_results/speclibm_$(FILE_ENDING):
	$(GEM5) -d $@ $(CONFIG) $(PARAM) --cpu-clock=$(CLOCK) -c spec_cpu2006/470.lbm/src/speclibm -o $(DATA_LBM) $(INST)

.PHONY: specbzip specmcf spechmmer specsjeng speclibm purge clean_specbzip_last clean_specmcf_last clean_specsjeng_last clean_speclibm_last clean_specbzip clean_specmcf clean_specsjeng clean_speclibm

#functions to delete files
#Usage: e.g. "make clean_specbzip" will clean all results of the benchmark specbzip

purge: $(OUT_DIR)
	rm -rf $@	

clean_specbzip_last:
	rm -rf spec_results/specbzip_$(FILE_ENDING)

clean_specmcf_last:
	rm -rf spec_results/specmcf_$(FILE_ENDING)

clean_spechmmer_last:
	rm -rf spec_results/spechmmer_$(FILE_ENDING)

clean_specsjeng_last:
	rm -rf spec_results/specsjeng_$(FILE_ENDING)

clean_speclibm_last:
	rm -rf spec_results/speclibm_$(FILE_ENDING)


clean_specbzip:
	rm -rf spec_results/specbzip_*

clean_specmcf:
	rm -rf spec_results/specmcf_*

clean_spechmmer:
	rm -rf spec_results/spechmmer_*

clean_specsjeng:
	rm -rf spec_results/specsjeng_*

clean_speclibm:
	rm -rf spec_results/speclibm_*
		

