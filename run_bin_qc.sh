#!bin/bash

list='MetaBAT2 CONCOCT MaxBin2'

for bin in $list; do
    echo checkm2 $bin
    checkm2 predict  -x .fa.gz --tmpdir /Net/Groups/ccdata/users/MKaiser/04-analysis/mag/mag_results3/Bins/tmp --force --threads 4 --input /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/GenomeBinning/${bin}/bins --output-directory /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/GenomeBinning/QC/CheckM2/${bin}
done

echo DASTool
checkm2 predict  -x .fa --tmpdir /Net/Groups/ccdata/users/MKaiser/04-analysis/mag/mag_results3/Bins/tmp --force --threads 4 --input /Net/Groups/ccdata/users/MKaiser/04-analysis/mag/mag_results3/GenomeBinning/DASTool/bins --output-directory /Net/Groups/ccdata/users/MKaiser/04-analysis/mag/mag_results3/GenomeBinning/QC/CheckM2/DASTOOL
