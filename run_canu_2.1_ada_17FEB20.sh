#BSUB -L /bin/bash              # uses the bash login shell to initialize the job's execution environment.
#BSUB -P 082815200223			# ada project account
#BSUB -J canu_2.1_ada           # job name
#BSUB -n 40                     # assigns 40 cores for execution
#BSUB -R "span[ptile=40]"       # assigns 40 cores per node
#BSUB -R "rusage[mem=24000]"    # reserves 24000MB memory per core
#BSUB -q xlarge					# used when 1TB or 2TB nodes are needed
#BSUB -M 24000                  # sets to 24000MB (24GB) the per process enforceable memory limit.
#BSUB -W 48:00                  # sets to 48 hours the job's runtime wall-clock limit.
#BSUB -o stdout.%J              # directs the job's standard output to stdout.jobid
#BSUB -e stderr.%J              # directs the job's standard error to stderr.jobid

<<README
    - canu Documentation (Release 2.1): https://readthedocs.org/projects/canu/downloads/pdf/latest/
README

################################################################################



#load latest version of canu
module load canu/2.1-GCC-8.3.0-Java-1.8.0

#cd to directory with nanopore raw reads
/scratch/user/selmaglz/completegenome

#run canu for assembly of nanopore raw reads
canu useGrid=false -p F70H3 -d F70H3 genomeSize=4.7m -nanopore-raw F70H3_B11_minion.fastq



################################################################################

<<CITATION
    - Acknowledge TAMU HPRC: https://hprc.tamu.edu/research/citations.html

CITATION

# Created by Selma Gonzalez
# Updated December 17, 2020
