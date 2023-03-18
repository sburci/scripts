#!/bin/bash
#SBATCH --job-name="spades_pe"                #name of this job
#SBATCH -p medium                             #name of the partition (queue) you are submitting to
#SBATCH -N 1                                  #number of nodes in this job
#SBATCH -n 40                                 #number of cores/tasks in this job, you get all 20 physical cores with 2 threads per core with hyper-threading
#SBATCH -t 02:00:00                           #time allocated for this job hours:mins:seconds
#SBATCH --mail-user=selma.burciaga@usda.gov   #enter your email address to receive emails
#SBATCH --mail-type=BEGIN,END,FAIL            #will receive an email when job starts, ends or fails
#SBATCH -o "stdout.%j.%N"                     #standard output, %j adds job number to output file name and %N adds the node name
#SBATCH -e "stderr.%j.%N"                     #optional, prints our standard error
date                                          #optional, prints out timestamp at the start of the job in stdout file

cd /project/fsepru113/sburciaga/hberg/miseq_fastq/trimmed #location of trimmed short-reads
module load spades/3.7.1
for f in *R1*.fq.gz; do echo "spades.py --careful --memory 32 --threads 16 -1 ${f/_R*/_R1_paired.fq.gz} -2 ${f/_R*/_R2_paired.fq.gz} -o ${f/_R*/_spades} -k 25,55,95,125"; done
mkdir /project/fsepru113/sburciaga/hberg/miseq_fastq/trimmed/spades_contigs
for dir in $(find ./ -name "*_spades" -type d); do ID=$(basename ${dir/_spades/}); cp $dir/contigs.fasta spades_contigs/${ID}.contigs.fasta; cp $dir/scaffolds.fasta spades_contigs/${ID}.scaffolds.fasta; done

#E.g. commands for each paired-end read in raw_data directory
#spades.py --careful --memory 32 --threads 16 -1 SX244_R1_paired.fq.gz -2 SX244_R2_paired.fq.gz -o SX244_spades -k 25,55,95,125
#spades.py --careful --memory 32 --threads 16 -1 SX245_R1_paired.fq.gz -2 SX245_R2_paired.fq.gz -o SX245_spades -k 25,55,95,125

date                                         #optional, prints out timestamp when the job ends
#Selma Burciaga
#Feburary 08, 2023
#Shell script: run_spades_3.7.1_pe_ceres_08FEB23.sh
#End of file