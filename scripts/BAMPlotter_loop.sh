#!/bin/bash -e
#SBATCH --account=uoo02328
#SBATCH --job-name=bamplotter
#SBATCH --time=00:05:00
#SBATCH --mem=8G
#SBATCH --mail-type=ALL
#SBATCH --output bamplotter.%j.out # CHANGE map1 part each run
#SBATCH --error bamplotter.%j.err # CHANGE map1 part each runmodule purge 

ml purge

module load Miniconda3

source $(conda info --base)/etc/profile.d/conda.sh
export PYTHONNOUSERSITE=1

#conda create -p /nesi/nobackup/uoo02328/meriam/conda_environments/bamplotter\
#	 python=3.9 numpy pysam pysamstats pandas matplotlib tqdm -c bioconda -c conda-forge -y

conda activate /nesi/nobackup/uoo02328/meriam/conda_environments/bamplotter

#ml load SAMtools/1.12-GCC-9.2.0

for reference in M.bougainville M.burtoni M.cervinipes R.exulans R.praetor S.ponceleti 
	do
		for sample in MS11705 MS11706 
		do
		echo ${sample}
		python BAMPlotter_modified.py \
		-b ${reference}/deduplication/${sample}/${sample}_rmdup.bam \
		-d ${reference}/mapdamage/results_${sample}_rmdup/misincorporation.txt \
		-o BAMPlotter/${sample}_BAMPlotter_${reference}.pdf
	done 
done

for sample in MS11705 MS11706 
        do
        echo ${sample}
#       samtools index ${sample}_maponly.bam  
        python BAMPlotter_modified.py \
        -b deduplication/${sample}/${sample}_rmdup.bam \
        -o BAMPlotter/${sample}_BAMPlotter_rats_combined.pdf
        done 

conda deactivate

#       -d ${sample}_rats_pydamage_results.csv \
#samtools index intermediate_files/${sample}_dedup/${sample}_possort_rmdup.bam  
#-b intermediate_files/${sample}_dedup/${sample}_possort_rmdup.bam
#	-d intermediate_files/MapDamage_results/results_${sample}_possort_rmdup/misincorporation.txt \
#	-b ${sample}_maponly.bam -o ${sample}_BAMPlotter.pdf
