#BSUB -L /bin/bash              # uses the bash login shell to initialize the job's execution environment.
#BSUB -J trimmomatic            # job name
#BSUB -n 20                     # assigns 20 cores for execution
#BSUB -R "span[ptile=20]"       # assigns 20 cores per node
#BSUB -R "rusage[mem=12300]"    # reserves 2700MB memory per core
#BSUB -R "select[mem256gb]"		#using 256GB nodes
#BSUB -M 12300                  # sets to 2700MB per process enforceable memory limit. (M * n)
#BSUB -W 48:00                  # sets to 1 hour the job's runtime wall-clock limit.
#BSUB -o stdout.%J              # directs the job's standard output to stdout.jobid
#BSUB -e stderr.%J              # directs the job's standard error to stderr.jobid




<<README
    - Trimmomatic manual:
        http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/TrimmomaticManual_V0.32.pdf
README

################################################################################




#create directory for trimmed fastq output (output directory - e.g. trimmedreads_SEQ1) within directory containing raw FASTQ files (e.g. Sequence1) 
mkdir /scratch/user/selmaglz/FASTQ/Sequence1/trimmedreads_SEQ1

#cd to where your raw FASTQ files are
cd /scratch/user/selmaglz/FASTQ/Sequence1 

# for loop creates text file with trimmomatic commands for each of your samples (one up your current working directory, e.g. Sequence6) --> change all the parameters needed (-basein direct path to FASTQ files, -baseout direct path to trimmed fastq folder, name of commands text file, and trimmomatic-0.38.jar to new version if available)
for filename in *_L001_R1_001.fastq.gz; do echo "java -jar \$EBROOTTRIMMOMATIC/trimmomatic-0.38.jar PE -threads 2 -phred33 -basein /scratch/user/selmaglz/FASTQ/Sequence1/$filename -baseout /scratch/user/selmaglz/FASTQ/Sequence1/trimmedreads_SEQ1/${filename%*_L001_R1*}.fastq.gz ILLUMINACLIP:\$EBROOTTRIMMOMATIC/adapters/NexteraPE-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36" >> ../trimmo_commands_SEQ1.txt; done

#cd to where your command text file was created (one up current directory) 
cd /scratch/user/selmaglz/FASTQ

#load the latest version of Trimmomatic software (first, module spider trimmomatic)
module load Trimmomatic/0.38-Java-1.8.0
module load parallel/20151222-intel-2015B

#change name of commands text file
parallel --tmpdir $TMPDIR --compress --jobs 20 < trimmo_commands_SEQ1.txt		

# available adapter files:
#   Nextera:      NexteraPE-PE.fa
#   GAII:         TruSeq2-PE.fa, TruSeq2-SE.fa
#   HiSeq,MiSeq:  TruSeq3-PE-2.fa, TruSeq3-PE.fa, TruSeq3-SE.fa




################################################################################

<<CITATION
    - Acknowledge TAMU HPRC: https://hprc.tamu.edu/research/citations.html

    - Trimmomatic:
        Anthony M. Bolger1,2, Marc Lohse1 and Bjoern Usadel. Trimmomatic: A flexible trimmer for Illumina Sequence Data.
        Bioinformatics. 2014 Aug 1;30(15):2114-20. doi: 10.1093/bioinformatics/btu170.
CITATION

#Updated: Michael Dickens January 11, 2018
#Updated: Selma Gonzalez, January 11, 2019

