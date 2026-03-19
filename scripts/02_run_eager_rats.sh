#!/bin/bash -e
#SBATCH --account=uoo02328
#SBATCH --job-name=eager_rats
#SBATCH --time=2:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=3G
#SBATCH --mail-type=ALL
#SBATCH --output eager_rats.%j.out # CHANGE map1 part each run
#SBATCH --error eager_rats.%j.err # CHANGE map1 part each runmodule purge 

module purge

module load Nextflow/22.04.3

#module load Singularity/3.11.3
module load Apptainer/1.3.1

export SINGULARITY_TMPDIR=/nesi/nobackup/uoo02328/meriam/container-cache/cache
export SINGULARITY_CACHEDIR=$SINGULARITY_TMPDIR
export NXF_SINGULARITY_CACHEDIR=$SINGULARITY_TMPDIR
setfacl -b "$SINGULARITY_TMPDIR"

#nextflow run nf-core/eager -profile test,singularity

#module load Miniconda3
#source $(conda info --base)/etc/profile.d/conda.sh
#export PYTHONNOUSERSITE=1
#conda activate eager

cd /nesi/nobackup/uoo02328/meriam/rats

nextflow run nf-core/eager \
-r 2.5.0 \
-c 02_eager.config \
-profile singularity \
--outdir '/nesi/nobackup/uoo02328/meriam/rats/' \
--input '/nesi/nobackup/uoo02328/meriam/rats/data/MS*_R{1,2}_001.fastq.gz' \
--fasta '/nesi/nobackup/uoo02328/meriam/rats/references/rats_combined.fasta' \
--clip_readlength 25 \
--clip_min_read_quality 20 \
--bwaalnn 0.03 \
--dedupper 'dedup' \
--damage_calculation_tool 'mapdamage' \
--run_bam_filtering  --bam_mapping_quality_threshold 20 \
-resume 

#clean up intermediate files
#nextflow clean -f -k

