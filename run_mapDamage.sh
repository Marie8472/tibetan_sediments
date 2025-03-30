#!/bin/bash

source ~/.bashrc
conda activate mapDamage
cd /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mapdamage/output
fasta_path=/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/Assembly/MEGAHIT
path=/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mapdamage
# mkdir -p $path/fasta
# mkdir -p $path/bam
for dir in /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/Assembly/MEGAHIT/QC/ERR*; do
    sample="${dir/"/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/Assembly/MEGAHIT/QC/"/}"    
    cp $fasta_path/MEGAHIT-$sample.contigs.fa.gz $path/fasta/
    gunzip $path/fasta/MEGAHIT-$sample.contigs.fa.gz
    echo $sample
    mapDamage -i $dir/MEGAHIT-$sample-$sample.bam -r $path/fasta/MEGAHIT-$sample.contigs.fa --rescale --single-stranded --rescale-out $path/bam/MEGAHIT-$sample-$sample.rescale.bam
done
