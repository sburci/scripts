#BSUB -L /bin/bash              # uses the bash login shell to initialize the job's execution environment.
#BSUB -J fastqc                 # job name
#BSUB -n 2                      # assigns 2 cores for execution
#BSUB -R "span[ptile=2]"        # assigns 2 cores per node
#BSUB -R "rusage[mem=2500]"     # reserves 2500MB memory per core
#BSUB -M 2500                   # sets to 2500MB process enforceable memory limit. (M * n)
#BSUB -W 1:00                   # sets to 1 hour the job's runtime wall-clock limit.
#BSUB -o stdout.%J              # directs the job's standard output to stdout.jobid
#BSUB -e stderr.%J              # directs the job's standard error to stderr.jobid

#create directory where FastQC output will save (output directory)
mkdir /scratch/user/selmaglz/FASTQ/Sequence2/FastQC_SEQ2

#load the latest version of FastQC software (after module spider FastQC)
module load FastQC/0.11.7-Java-1.8.0

<<README
    - FASTQC homepage: http://www.bioinformatics.babraham.ac.uk/projects/fastqc/
    - FASTQC manual: http://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/
README

################################################################################




# TODO Edit these variables as needed:
threads=2                       # make sure this is <= your BSUB -n value

#cd to where your FASTQ files are
cd /scratch/user/selmaglz/FASTQ/Sequence2 							  

#type the entire path to output directory (as above)
FastQC_SEQ2="/scratch/user/selmaglz/FASTQ/Sequence2/FastQC_SEQ2"      

#ls will list all files ending in .fastq.gz (* represents wildcard, any number of unknown characters)
for F in 'ls *.fastq.gz'
	do
		fastqc -t 2 -o $FastQC_SEQ2 $F			# -o output directory
	done

# FASTQ and F are variables. 
# When the variable is first set you only need to give the name of the variable (i.e. FASTQ) 
# 	but when you then refer to (try to use) the variable you will need to add a $ (i.e. $FASTQ). 

################################################################################
# use -o <directory> to save results to <directory> instead of directory where reads are located
#   <directory> must already exist before using -o <directory> option
# --nogroup will calculate average at each base instead of bins after the first 50 bp
# fastqc runs one thread per file; using 20 threads for 2 files does not speed up the processing

<<CITATION
    - Acknowledge TAMU HPRC: https://hprc.tamu.edu/research/citations.html

    - FastQC: http://www.bioinformatics.babraham.ac.uk/projects/fastqc/
CITATION

# Created by Selma Gonzalez, 
# Updated January 7, 2019

