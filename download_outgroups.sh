#!bin/bash

#############################
###Outgroup Hydromicrobium###
#############################
cd /Net/Groups/pbtdata/01_RAG/03_methods/bioinformatics/databases/ncbi-ref-genomes/hydromicrobium_02.2025
mkdir -p outgroup
cd outgroup

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/304/935/GCA_002304935.1_ASM230493v1/GCA_002304935.1_ASM230493v1_genomic.fna.gz
gunzip GCA_002304935.1_ASM230493v1_genomic.fna.gz

#########################
###Outgroup Acidovorax###
#########################
cd /Net/Groups/pbtdata/01_RAG/03_methods/bioinformatics/databases/ncbi-ref-genomes/acidovorax_02.2025
mkdir -p outgroup
cd outgroup

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/215/705/GCF_000215705.1_ASM21570v1/GCF_000215705.1_ASM21570v1_genomic.fna.gz
gunzip GCF_000215705.1_ASM21570v1_genomic.fna.gz

##########################
###Outgroup Pseudomonas###
##########################
cd /Net/Groups/pbtdata/01_RAG/03_methods/bioinformatics/databases/ncbi-ref-genomes/pseudomonas_02.2025
mkdir -p outgroup
cd outgroup

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/016/028/635/GCF_016028635.1_ASM1602863v1/GCF_016028635.1_ASM1602863v1_genomic.fna.gz
gunzip GCF_016028635.1_ASM1602863v1_genomic.fna.gz

##########################
###Outgroup Reinheimera###
##########################
cd /Net/Groups/pbtdata/01_RAG/03_methods/bioinformatics/databases/ncbi-ref-genomes/pararheinheimera_02.2025
mkdir -p outgroup
cd outgroup

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/227/745/GCF_000227745.2_ASM22774v3/GCF_000227745.2_ASM22774v3_genomic.fna.gz
gunzip GCF_000227745.2_ASM22774v3_genomic.fna.gz

###########################
###Outgroup Pseudolabrys###
###########################
cd /Net/Groups/pbtdata/01_RAG/03_methods/bioinformatics/databases/ncbi-ref-genomes/pseudolabrys_02.2025
mkdir -p outgroup
cd outgroup

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/092/925/GCF_000092925.1_ASM9292v1/GCF_000092925.1_ASM9292v1_genomic.fna.gz
gunzip GCF_000092925.1_ASM9292v1_genomic.fna.gz
