#BSUB -L /bin/bash              # uses the bash login shell to initialize the job's execution environment.
#BSUB -J spades_pe_2mp          # job name
#BSUB -n 40                     # assigns 40 cores for execution
#BSUB -R "span[ptile=40]"       # assigns 40 cores per node
#BSUB -R "rusage[mem=24000]"    # reserves 24000MB memory per core
#BSUB -q xlarge					# used when 1TB or 2TB nodes are needed
#BSUB -M 24000                  # sets to 24000MB (24GB) the per process enforceable memory limit.
#BSUB -W 48:00                  # sets to 48 hours the job's runtime wall-clock limit.
#BSUB -o stdout.%J              # directs the job's standard output to stdout.jobid
#BSUB -e stderr.%J              # directs the job's standard error to stderr.jobid

<<README
    - SPAdes manual: http://spades.bioinf.spbau.ru/release3.5.0/manual.html
README

################################################################################




#load westmere (large-memory node) modules (with increased priority)
module load Westmere

#load the latest version of SPAdes software (after module spider SPAdes)																					
module load SPAdes/3.13.0-Linux

#load parallel (runs programs in parallel)
module load parallel/20151222-intel-2015B

#create directory for SPAdes output
mkdir /scratch/user/selmaglz/FASTA/SPAdes_SEQ8

#cd to where your trimmed FASTQ are
cd /scratch/user/selmaglz/FASTQ/Sequence8/trimmedreads_SEQ8													

#create text file with SPAdes commands
for sample in *1P.fastq.gz; do echo "spades.py --careful --memory 5 --threads 2 -1 /scratch/user/selmaglz/FASTQ/Sequence8/trimmedreads_SEQ8/${sample%_*}_1P.fastq.gz -2 /scratch/user/selmaglz/FASTQ/Sequence8/trimmedreads_SEQ8/${sample%_*}_2P.fastq.gz -o spades_$sample"; done > ../spades_commands_SEQ8.txt

#cd to where the text file was created (one up current directory, e.g. trimmedreads_SEQ8)
cd /scratch/user/selmaglz/FASTQ/Sequence8/

#convert special characters into Linux readable format										
sed -i 's/\o015/\n/g' spades_commands_SEQ8.txt

#move SPAdes command text file to SPAdes output directory you created previoiusly
mv /scratch/user/selmaglz/FASTQ/Sequence8/spades_commands_SEQ8.txt /scratch/user/selmaglz/FASTA/SPAdes_SEQ8

#cd to SPAdes output directory
cd /scratch/user/selmaglz/FASTA/SPAdes_SEQ8

#run SPAdes
parallel < spades_commands_SEQ8.txt

#cd to SPAdes output directory
cd /scratch/user/selmaglz/FASTA/SPAdes_SEQ8

#create new directory within SPAdes output directory to move only contigs.fasta files
mkdir /scratch/user/selmaglz/FASTA/SPAdes_SEQ8/contigs_fasta_SEQ8

#rename output files and directories to include sample ID or any identification
for dir in $(find ./ -name "spades_*" -type d); do sample=$(basename ${dir/spades_/}); cp $dir/contigs.fasta contigs_fasta_SEQ9/${sample}.contigs.fasta; cp $dir/scaffolds.fasta contigs_fasta_SEQ9/${sample}.scaffolds.fasta; done




################################################################################
# command to run with defaults and the --careful option
# Example:
# spades.py --threads $threads --tmp-dir $TMPDIR --careful --memory $max_memory -o $output_dir \
#     --pe1-1 $pe1_1 --pe1-2 $pe1_2 --mp1-1 $mp1_1 --mp1-2 $mp1_2 --mp2-1 $mp2_1 --mp2-2 $mp2_2


<<CITATION
    - Acknowledge TAMU HPRC: https://hprc.tamu.edu/research/citations.html

    - SPAdes:
        Bankevich A., et al. SPAdes: A New Genome Assembly Algorithm and Its Applications to Single-Cell Sequencing.
        J Comput Biol. 2012 May; 19(5): 455–477. doi:  10.1089/cmb.2012.0021
CITATION

# Created by Selma Gonzalez
# Updated February 1, 2019
