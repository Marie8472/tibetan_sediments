#!bin/bash

outfile="/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/bins_contigs_table.csv"

## CONCOCT
cd /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/GenomeBinning/CONCOCT/bins
echo "Sample,bin,contig_id" > $outfile
echo CONCOCT
for file in $(ls); do
    IFS='-' read -a array <<< $file
    name="${array[2]}"
    IFS='_' read -a array <<< $name
    sample="${array[0]}"
    tmp=($(zgrep '>' $file))
    for item in "${tmp[@]}"; do
        if [[ $item == *k* ]]; then
            contig_id="${item//>/}"
            echo "$sample,$file,$contig_id" >> $outfile
        fi
    done
done
echo MaxBin2
## MaxBin2
cd /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/GenomeBinning/MaxBin2
for file in $(ls); do
    IFS='-' read -a array <<< $file
    name="${array[2]}"
    IFS='.' read -a array <<< $name
    sample="${array[0]}"
    tmp=($(zgrep '>' $file))
    for item in "${tmp[@]}"; do
        if [[ $item == *k* ]]; then
            contig_id="${item//>/}"
            echo "$sample,$file,$contig_id" >> $outfile
        fi
    done
done
echo Metabat
## Metabat
cd /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/GenomeBinning/MetaBAT2/bins

for file in $(ls); do
    IFS='-' read -a array <<< $file
    name="${array[2]}"
    IFS='.' read -a array <<< $name
    sample="${array[0]}"
    tmp=($(zgrep '>' $file))
    for item in "${tmp[@]}"; do
        if [[ $item == *k* ]]; then
            contig_id="${item//>/}"
            echo "$sample,$file,$contig_id" >> $outfile
        fi
    done
done

## DASTool
echo DASTool
refined_bins_outfile="/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/refined_bins_contigs_table.csv"
cd "/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/GenomeBinning/DASTool/bins"

echo "Sample,bin,contig_id" > $refined_bins_outfile

for file in $(ls); do
    IFS='-' read -a array <<< $file
    name="${array[2]}"
    IFS='.' read -a array <<< $name
    sample="${array[0]}"
    tmp=($(grep '>' $file))
    for item in "${tmp[@]}"; do
        if [[ $item == *k* ]]; then
            contig_id="${item//>/}"
            echo "$sample,$file,$contig_id" >> $refined_bins_outfile
        fi
    done
done
