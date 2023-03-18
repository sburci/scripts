#!/bin/bash
#SBATCH --job-name="trim_pe"                  #name of this job
#SBATCH -p medium                             #name of the partition (queue) you are submitting to
#SBATCH -N 1                                  #number of nodes in this job
#SBATCH -n 40                                 #number of cores/tasks in this job, you get all 20 physical cores with 2 threads per core with hyper-threading
#SBATCH -t 02:00:00                           #time allocated for this job hours:mins:seconds
#SBATCH --mail-user=selma.burciaga@usda.gov   #enter your email address to receive emails
#SBATCH --mail-type=BEGIN,END,FAIL            #will receive an email when job starts, ends or fails
#SBATCH -o "stdout.%j.%N"                     #standard output, %j adds job number to output file name and %N adds the node name
#SBATCH -e "stderr.%j.%N"                     #optional, prints our standard error
date                                          #optional, prints out timestamp at the start of the job in stdout file

cd /project/fsepru113/hberg/raw_dat #location of raw short-read fastqs
module load java
module load trimmomatic/0.38  #loading latest trimmomatic module
for f in *R1*.fq.gz; do "java -jar /software/7/apps/trimmomatic/0.38/trimmomatic-0.38.jar PE $f ${f/R1/R2} ${f/_R*/_R1_paired.fq.gz} ${f/_R*/_R1_unpaired.fq.gz} ${f/_R*/_R2_paired.fq.gz} ${f/_R*/_R2_unpaired.fq.gz} ILLUMINACLIP:/software/7/apps/trimmomatic/0.38/adapters/NexteraPE-PE.fa:2:30:10 LEADING:3 TRAILING:3 MINLEN:50"; done
mkdir /project/fsepru113/hberg/raw_dat/trimmed #create output directory
mv *paired.fq.gz /project/fsepru113/sburciaga/hberg/miseq_fastq/trimmed #use *_paired.fq.gz as downstream input

#E.g. commands for each paired-end read in raw_data directory
#java -jar /software/7/apps/trimmomatic/0.38/trimmomatic-0.38.jar PE SX244_R1.fq.gz SX244_R2.fq.gz SX244_R1_paired.fq.gz SX244_R1_unpaired.fq.gz SX244_R2_paired.fq.gz SX244_R2_unpaired.fq.gz ILLUMINACLIP:/software/7/apps/trimmomatic/0.38/adapters/NexteraPE-PE.fa:2:30:10 LEADING:3 TRAILING:3 MINLEN:50
#java -jar /software/7/apps/trimmomatic/0.38/trimmomatic-0.38.jar PE SX245_R1.fq.gz SX245_R2.fq.gz SX245_R1_paired.fq.gz SX245_R1_unpaired.fq.gz SX245_R2_paired.fq.gz SX245_R2_unpaired.fq.gz ILLUMINACLIP:/software/7/apps/trimmomatic/0.38/adapters/NexteraPE-PE.fa:2:30:10 LEADING:3 TRAILING:3 MINLEN:50

date                                         #optional, prints out timestamp when the job ends
#Selma Burciaga
#Feburary 08, 2023
#Shell script: run_trimmomatic_0.38_pe_ceres_08FEB23.sh
#End of file