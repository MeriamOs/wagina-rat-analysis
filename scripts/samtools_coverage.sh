module load SAMtools/1.22-GCC-12.3.0

### COMPETITIVE MAPPING STATS

for sample in MS11705 MS11706 
	do
		echo ${sample}
		samtools coverage deduplication/${sample}/${sample}_rmdup.bam > ${sample}_mapping_stats_rats_combined.txt
done

### INDIVIDUAL MAPPING STATS

for sample in MS11705 MS11706 
	do
	echo ${sample}
	samtools coverage M.bougainville/deduplication/${sample}/${sample}_rmdup.bam > ${sample}_individual_mapping.txt
done

for reference in M.burtoni M.cervinipes R.exulans R.praetor S.ponceleti 
	do
		for sample in MS11705 MS11706 
		do
		echo ${sample}
		samtools coverage ${reference}/deduplication/${sample}/${sample}_rmdup.bam | tail -n 1 >> ${sample}_individual_mapping.txt
	done 
done
