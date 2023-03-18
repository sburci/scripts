#!/bin/bash
#SBATCH --job-name="unicycler"                #name of this job
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
module load unicycler/0.5.0
unicycler -1 SX244_R1_paired.fq.gz -2 SX244_R2_paired.fq.gz -l /project/fsepru113/sburciaga/hberg/244.fastq -o unicycler --verbosity 2 --threads 24


for f in *R1*.fq.gz; do echo "spades.py --careful --memory 32 --threads 16 -1 ${f/_R*/_R1_paired.fq.gz} -2 ${f/_R*/_R2_paired.fq.gz} -o ${f/_R*/_spades} -k 25,55,95,125"; done
unicycler -1 SX244_R1_paired.fq.gz -2 SX244_R2_paired.fq.gz -l /project/fsepru113/sburciaga/hberg/244.fastq -o unicycler --verbosity 2 --threads 24

#E.g. commands for isolate/strain


date                                         #optional, prints out timestamp when the job ends
#Selma Burciaga
#Feburary 08, 2023
#Shell script: run_unicycler_0.5.0_ceres_08FEB23.sh
#End of file