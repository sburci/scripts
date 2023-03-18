#BSUB -L /bin/bash              # uses the bash login shell to initialize the job's execution environment.
#BSUB -J multiqc                # job name
#BSUB -n 2                      # assigns 2 cores for execution
#BSUB -R "span[ptile=2]"        # assigns 2 cores per node
#BSUB -R "rusage[mem=2500]"     # reserves 2500MB memory per core
#BSUB -M 2500                   # sets to 2500MB process enforceable memory limit. (M * n)
#BSUB -W 1:00                   # sets to 1 hour the job's runtime wall-clock limit.
#BSUB -o stdout.%J              # directs the job's standard output to stdout.jobid
#BSUB -e stderr.%J              # directs the job's standard error to stderr.jobid

#load the latest version of MultiQC software (after module spider MultiQC)
module load MultiQC/1.5-intel-2017A-Python-2.7.12					  

################################################################################




# TODO Edit these variables as needed:
threads=2          				# make sure this is <= your BSUB -n value

#cd to FastQC output directory (where your FastQC files are)
cd /scratch/user/selmaglz/FASTQ/Sequence2/FastQC_SEQ2				 

#run the MultiQC software - will create multiqc_data folder with 5 different output files inside
multiqc .														      

#rename the .html output file and mutliqc_data output directory for later identification
for f in multiqc*; do mv "$f" $(echo "$f" | sed 's/^multiqc/multiqc_SEQ2/g'); done		

#rename output files also to be specific, enter new multiqc_data name directory
cd multiqc_SEQ2_data												 
for f in multiqc*; do mv "$f" $(echo "$f" | sed 's/^multiqc/multiqc_SEQ2/g'); done




################################################################################

# Created by Selma Gonzalez, 
# Updated January 7, 2019


