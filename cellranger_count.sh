#!/bin/bash

#Job Name (change to reflect the case you're running)
#SBATCH --job-name=3_count

#Output file (this will store the log file for the job)
#SBATCH --output=3_count.%j

# Send an email to this address when you job starts and finishes (change to your email)
#SBATCH --mail-user=rshad@stanford.edu
#SBATCH --mail-type=end

# Time limits 
#SBATCH -t 48:00:00

# Partition info
#SBATCH --partition=owners,willhies
#SBATCH --qos=normal
#SBATCH --nodes=1
#SBATCH --mem=180G
#SBATCH --ntasks-per-node=24

# Set ulimits higher

ulimit -u 10000

#Creates working directory within high speed L_SCRATCH + runs everything in it

mkdir $L_SCRATCH/workdir
cd $L_SCRATCH/workdir


echo "Running in L_SCRATCH"

# Name of the executable (cellranger count; channge parameters as per run case)

cellranger count --id=129WT_Female \
                 --transcriptome=$GROUP_SCRATCH/rna_seq/aj_testfile/refdata-cellranger-mm10-3.0.0 \
                 --fastqs=$GROUP_SCRATCH/rna_seq/Marfan_Mouse/mkfastq_dir/outs/fastq_path \
                 --sample=129WT_Female \
                 --expect-cells=10000 \
                 
#L_SCRATCH wil purge everything from memory as soon as job ends, this step copies everything back to GROUP_SCRATCH

echo "Copying back to GROUP_SCRATCH"

cp -r $L_SCRATCH/workdir/129WT_Female $GROUP_SCRATCH/Marfan_Mouse_output/129WT_Female

echo "Job copied, waiting 10s to terminate..."

sleep 10