#BSUB -L /bin/bash              # uses the bash login shell to initialize the job's execution environment.
#BSUB -J quast                  # job name
#BSUB -n 8                      # assigns 8 cores for execution
#BSUB -R "span[ptile=8]"        # assigns 8 cores per node
#BSUB -R "rusage[mem=500]"      # reserves 500MB memory per core
#BSUB -M 500                    # sets to 500MB per process enforceable memory limit. (M * n)
#BSUB -W 1:00                   # sets to 1 hour the job's runtime wall-clock limit.
#BSUB -o stdout.%J              # directs the job's standard output to stdout.jobid
#BSUB -e stderr.%J              # directs the job's standard error to stderr.jobid

#load the latest version of QUAST software (after module spider QUAST)
module load QUAST/3.2-intel-2015B

<<README
    - QUAST manual: http://quast.bioinf.spbau.ru/manual.html
README

################################################################################




#run QUAST for all contigs.fasta files within chosen directory, create output directory (-o)
quast.py /scratch/user/selmaglz/FASTA/SPAdes_SEQ8/contigs_fasta_SEQ8/*_contigs.fasta -o /scratch/user/selmaglz/FASTA/SPAdes_SEQ8/QUAST_SEQ8 -t 8 -m 500 

#cd to the created output directory
cd /scratch/user/selmaglz/FASTA/SPAdes_SEQ8/QUAST_SEQ8

#rename the output files within output directory with wanted prefix for later identification
for f in *; do [[ -f "$f" ]] && mv "$f" "SEQ8_$f"; done

#cd to basic_stats directory
cd /scratch/user/selmaglz/FASTA/SPAdes_SEQ8/QUAST_SEQ8/basic_stats

#rename the output files within basic_stats directory with wanted prefix for later identification
for f in *; do [[ -f "$f" ]] && mv "$f" "SEQ8_$f"; done




################################################################################

<<CITATION
    - Acknowledge TAMU HPRC: https://hprc.tamu.edu/research/citations.html

    - QUAST:
        Alexey Gurevich, Vladislav Saveliev, Nikolay Vyahhi and Glenn Tesler,
        QUAST: quality assessment tool for genome assemblies,
        Bioinformatics (2013) 29 (8): 1072-1075. doi: 10.1093/bioinformatics/btt086
CITATION

#Created by Selma Gonzalez
#Updated January 30, 2019



