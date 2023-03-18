#HYBIRD ASSEMBLIES: SHORT- AND LONG-READ SEQUENCES
# Selma Burciaga
# Feburary 08, 2023
# Shell script: hybridassembly_commands.sh

salloc -N 1 -n 40 --mem 75G

#SHORT-READ FIRST ASSEMBLY: UNICYCLER

# A) METHOD 1 - trimmed/paired short-reads fastq & demultiplexed long-reads
# Trim short-read fastq
cd /project/fsepru113/sburciaga/hberg/raw_dat #location of raw short-read fastqs
module load java
module load trimmomatic/0.38
java -jar /software/7/apps/trimmomatic/0.38/trimmomatic-0.38.jar PE SX244_R1.fq.gz SX244_R2.fq.gz SX244_R1_paired.fq.gz SX244_R1_unpaired.fq.gz SX244_R2_paired.fq.gz SX244_R2_unpaired.fq.gz ILLUMINACLIP:/software/7/apps/trimmomatic/0.38/adapters/NexteraPE-PE.fa:2:30:10 LEADING:3 TRAILING:3 MINLEN:50
java -jar /software/7/apps/trimmomatic/0.38/trimmomatic-0.38.jar PE SX245_R1.fq.gz SX245_R2.fq.gz SX245_R1_paired.fq.gz SX245_R1_unpaired.fq.gz SX245_R2_paired.fq.gz SX245_R2_unpaired.fq.gz ILLUMINACLIP:/software/7/apps/trimmomatic/0.38/adapters/NexteraPE-PE.fa:2:30:10 LEADING:3 TRAILING:3 MINLEN:50
mkdir /project/fsepru113/sburciaga/hberg/miseq_fastq/trimmed
mv *paired.fq.gz /project/fsepru113/sburciaga/hberg/miseq_fastq/trimmed
# UNICYCLER HYBRID ASSEMBLY - Assemble short-read fastq & demultiplexed long-reads
cd /project/fsepru113/sburciaga/hberg/miseq_fastq/trimmed
module load unicycler/0.5.0
unicycler-runner.py -1 SX244_R1_paired.fq.gz -2 SX244_R2_paired.fq.gz -l /project/fsepru113/sburciaga/hberg/minion_fastq/244.fastq -o unicycler --verbosity 2 --threads 24
unicycler-runner.py -1 SX245_R1_paired.fq.gz -2 SX245_R2_paired.fq.gz -l /project/fsepru113/sburciaga/hberg/minion_fastq/245.fastq -o unicycler --verbosity 2 --threads 24



# B) METHOD 2 - trimmed/paired short-reads fastq & long-read assemblies
# Trim short-read fastq
cd /project/fsepru113/sburciaga/hberg/raw_dat #location of raw short-read fastqs
module load java
module load trimmomatic/0.38
java -jar /software/7/apps/trimmomatic/0.38/trimmomatic-0.38.jar PE SX244_R1.fq.gz SX244_R2.fq.gz SX244_R1_paired.fq.gz SX244_R1_unpaired.fq.gz SX244_R2_paired.fq.gz SX244_R2_unpaired.fq.gz ILLUMINACLIP:/software/7/apps/trimmomatic/0.38/adapters/NexteraPE-PE.fa:2:30:10 LEADING:3 TRAILING:3 MINLEN:50
java -jar /software/7/apps/trimmomatic/0.38/trimmomatic-0.38.jar PE SX245_R1.fq.gz SX245_R2.fq.gz SX245_R1_paired.fq.gz SX245_R1_unpaired.fq.gz SX245_R2_paired.fq.gz SX245_R2_unpaired.fq.gz ILLUMINACLIP:/software/7/apps/trimmomatic/0.38/adapters/NexteraPE-PE.fa:2:30:10 LEADING:3 TRAILING:3 MINLEN:50
mkdir /project/fsepru113/sburciaga/hberg/miseq_fastq/trimmed
mv *paired.fq.gz /project/fsepru113/sburciaga/hberg/miseq_fastq/trimmed
# Assemble long-read fastq
cd /project/fsepru113/hberg/minion #location of raw long-read fastqs
module load canu/2.2
canu useGrid=false -p SX244 -d /project/fsepru113/sburciaga/hberg/minion_fastq/SX244 genomeSize=4.7m -nanopore-raw SX244.fastq
canu useGrid=false -p SX245 -d /project/fsepru113/sburciaga/hberg/minion_fastq/SX245 genomeSize=4.7m -nanopore-raw SX245.fastq
# Assemble trimmed/paired short-read fastq & long-read assemblies
cd /project/fsepru113/sburciaga/hberg/miseq_fastq/trimmed
module load unicycler/0.5.0
unicycler -1 SX244_R1_paired.fq.gz -2 SX244_R2_paired.fq.gz -l /project/fsepru113/sburciaga/hberg/miseq_fastq/trimmed/spades_contigs/SX244.contigs.fasta -o unicycler --verbosity 2 --threads 24
UNICYCLER HYBRID ASSEMBLY



# C) METHOD 3 - short-read assemblies & demultiplexed long-reads
# Trim short-read fastq
cd /project/fsepru113/sburciaga/hberg/raw_dat #location of raw short-read fastqs
module load java
module load trimmomatic/0.38
java -jar /software/7/apps/trimmomatic/0.38/trimmomatic-0.38.jar PE SX244_R1.fq.gz SX244_R2.fq.gz SX244_R1_paired.fq.gz SX244_R1_unpaired.fq.gz SX244_R2_paired.fq.gz SX244_R2_unpaired.fq.gz ILLUMINACLIP:/software/7/apps/trimmomatic/0.38/adapters/NexteraPE-PE.fa:2:30:10 LEADING:3 TRAILING:3 MINLEN:50
java -jar /software/7/apps/trimmomatic/0.38/trimmomatic-0.38.jar PE SX245_R1.fq.gz SX245_R2.fq.gz SX245_R1_paired.fq.gz SX245_R1_unpaired.fq.gz SX245_R2_paired.fq.gz SX245_R2_unpaired.fq.gz ILLUMINACLIP:/software/7/apps/trimmomatic/0.38/adapters/NexteraPE-PE.fa:2:30:10 LEADING:3 TRAILING:3 MINLEN:50
mkdir /project/fsepru113/sburciaga/hberg/miseq_fastq/trimmed
mv *paired.fq.gz /project/fsepru113/sburciaga/hberg/miseq_fastq/trimmed
# Assemble short-read fastq
cd /project/fsepru113/sburciaga/hberg/miseq_fastq/trimmed #location of trimmed short-reads
module load spades/3.7.1
spades.py --careful --memory 32 --threads 16 -1 SX244_R1_paired.fq.gz -2 SX244_R2_paired.fq.gz -o SX244_spades -k 25,55,95,125
spades.py --careful --memory 32 --threads 16 -1 SX245_R1_paired.fq.gz -2 SX245_R2_paired.fq.gz -o SX245_spades -k 25,55,95,125
mkdir /project/fsepru113/sburciaga/hberg/miseq_fastq/trimmed/spades_contigs
for dir in $(find ./ -name "*_spades" -type d); do ID=$(basename ${dir/_spades/}); cp $dir/contigs.fasta spades_contigs/${ID}.contigs.fasta; cp $dir/scaffolds.fasta spades_contigs/${ID}.scaffolds.fasta; done
# Assemble short-read assemblies & demultiplexed long-reads
cd /project/fsepru113/sburciaga/hberg/miseq_fastq/trimmed/spades_contigs #location of short-read assemblies
SPADES HYBRID ASSEMBLY



# D) METHOD 4 - short-read assemblies & long-read assemblies
# Trim short-read fastq
cd /project/fsepru113/sburciaga/hberg/raw_dat #location of raw short-read fastqs
module load java
module load trimmomatic/0.38
java -jar /software/7/apps/trimmomatic/0.38/trimmomatic-0.38.jar PE SX244_R1.fq.gz SX244_R2.fq.gz SX244_R1_paired.fq.gz SX244_R1_unpaired.fq.gz SX244_R2_paired.fq.gz SX244_R2_unpaired.fq.gz ILLUMINACLIP:/software/7/apps/trimmomatic/0.38/adapters/NexteraPE-PE.fa:2:30:10 LEADING:3 TRAILING:3 MINLEN:50
java -jar /software/7/apps/trimmomatic/0.38/trimmomatic-0.38.jar PE SX245_R1.fq.gz SX245_R2.fq.gz SX245_R1_paired.fq.gz SX245_R1_unpaired.fq.gz SX245_R2_paired.fq.gz SX245_R2_unpaired.fq.gz ILLUMINACLIP:/software/7/apps/trimmomatic/0.38/adapters/NexteraPE-PE.fa:2:30:10 LEADING:3 TRAILING:3 MINLEN:50
mkdir /project/fsepru113/sburciaga/hberg/miseq_fastq/trimmed
mv *paired.fq.gz /project/fsepru113/sburciaga/hberg/miseq_fastq/trimmed
# Assemble short-read fastq
cd /project/fsepru113/sburciaga/hberg/miseq_fastq/trimmed #location of trimmed short-reads
module load spades/3.7.1
spades.py --careful --memory 32 --threads 16 -1 SX244_R1_paired.fq.gz -2 SX244_R2_paired.fq.gz -o SX244_spades -k 25,55,95,125
spades.py --careful --memory 32 --threads 16 -1 SX245_R1_paired.fq.gz -2 SX245_R2_paired.fq.gz -o SX245_spades -k 25,55,95,125
mkdir /project/fsepru113/sburciaga/hberg/miseq_fastq/trimmed/spades_contigs
for dir in $(find ./ -name "*_spades" -type d); do ID=$(basename ${dir/_spades/}); cp $dir/contigs.fasta spades_contigs/${ID}.contigs.fasta; cp $dir/scaffolds.fasta spades_contigs/${ID}.scaffolds.fasta; done
# Assemble long-read fastq
cd /project/fsepru113/hberg/minion #location of raw long-read fastqs
module load canu/2.2
canu useGrid=false -p SX244 -d /project/fsepru113/sburciaga/hberg/minion_fastq/SX244 genomeSize=4.7m -nanopore-raw SX244.fastq
canu useGrid=false -p SX245 -d /project/fsepru113/sburciaga/hberg/minion_fastq/SX245 genomeSize=4.7m -nanopore-raw SX245.fastq
# Align short-read assembly to long-read assembly - BWA
cd /project/fsepru113/sburciaga/hberg/miseq_fastq/trimmed/spades_contigs

# Polish long-read assembly - pilon v1.23


#LONG-READ FIRST ASSEMBLY: TRYCYCLER

# E) METHOD 5 - 





#Tools
# Canu long-read assembly tool: https://canu.readthedocs.io/en/latest/
# Trimmomatic: http://www.usadellab.org/cms/?page=trimmomatic
# BWA alignment: https://bio-bwa.sourceforge.net/
# Pilon polishing tool: https://github.com/broadinstitute/pilon/wiki

#Update versions of software
# module spider software
# e.g. module spider canu