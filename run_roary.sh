#!/bin/bash

#installt new db
# bakta_db download --output /Net/Groups/ccdata/databases/bakta5.1 --type full


source ~/.bashrc
list='Hydromicrobium Acidovorax Pseudolabrys Pararheinheimera Pseudomonas'
outpath='/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/bakta'

conda activate bakta

for genus in $list; do
    echo $genus
    while read MAG; do
        if [[ $MAG == *DASTool* ]]; then
            tmp="${MAG/"/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/GenomeBinning/DASTool/bins/"/}"
            bin="${tmp/.fa/}"
            echo $bin
            bakta $MAG --keep-contig-headers --skip-plot --threads 40 --verbose --output $outpath/$genus/$bin --prefix $bin --db /Net/Groups/ccdata/databases/bakta5.1/db -f
        fi
    done < "/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/ezTree/${genus}/${genus}_list"
    
    while read MAG; do

        tmp="${MAG/"/Net/Groups/pbtdata/01_RAG/03_methods/bioinformatics/databases/"*"/"/}"
        bin="${tmp/.fna/}"
        echo $bin
        bakta $MAG --keep-contig-headers --skip-plot --threads 15 --verbose --output $outpath/$genus/$bin --prefix $bin --db /Net/Groups/ccdata/databases/bakta5.1/db -f

    done < "/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/bakta/${genus}/ref_seq_list"
done

conda deactivate
conda activate roary

# high quality and medium together

for genus in $list; do
    echo $genus
    roary \
    -p 15 \
    -f /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/roary/${genus}_ref_seqs \
    -e \
    -n \
    -v \
    -cd 90 \
    -i 90 \
    -g 85000 \
    /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/bakta/$genus/*/*gff3
done


conda deactivate
