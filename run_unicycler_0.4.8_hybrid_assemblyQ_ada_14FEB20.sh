#BSUB -L /bin/bash              # uses the bash login shell to initialize the job's execution environment.
#BSUB -J unicycler              # job name
#BSUB -n 40                     # assigns 40 cores for execution
#BSUB -R "span[ptile=40]"       # assigns 40 cores per node
#BSUB -R "rusage[mem=24000]"    # reserves 24000MB memory per core
#BSUB -q xlarge					# used when 1TB or 2TB nodes are needed
#BSUB -M 24000                  # sets to 24000MB (24GB) the per process enforceable memory limit.
#BSUB -W 48:00                  # sets to 48 hours the job's runtime wall-clock limit.
#BSUB -o stdout.%J              # directs the job's standard output to stdout.jobid
#BSUB -e stderr.%J              # directs the job's standard error to stderr.jobid

<<README
    - Unicycler: https://github.com/rrwick/Unicycler
README

################################################################################




#load westmere (large-memory node) modules (with increased priority)
module load Westmere

#load the latest version of Unicycler software (after module spider unicylcer)																					
module load Unicycler/0.4.8-foss-2019a-Python-3.7.2

#to execute Pilon run: java -Xmx8G -jar $EBROOTPILON/pilon.jar
java -Xmx8G -jar $EBROOTPILON/pilon.jar

#cd to directory with fastq files
cd /scratch/user/selmaglz/completegenome/B70HEB11/

#run unicycler on illumina fastq files and minion fastq file
unicycler -1 B70HEB11_S14_L001_R1_001.fastq.gz -2 B70HEB11_S14_L001_R2_001.fastq.gz -l B70HEB11_B01_minion.fastq -o unicyclerhybridQ --verbosity 2 --threads 24



################################################################################


<<CITATION
    - Acknowledge TAMU HPRC: https://hprc.tamu.edu/research/citations.html

    - https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005595
CITATION

# Created by Selma Gonzalez
# Updated February 14, 2021