#!bin/bash

# CHECKm2
cd /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/GenomeBinning/QC/CheckM2
tsvfile="/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/GenomeBinning/QC/checkm2_summary_unrefined.tsv"
bool=1
for dir in $(ls); do
    if [[ $dir != quality* ]] && [[ $dir != "DASTOOL" ]]; then
    echo $dir
        if [ $bool -eq 1 ]; then
            cat $dir/quality_report.tsv > $tsvfile
            bool=0
        else
            tail -n +2 $dir/quality_report.tsv >> $tsvfile
        fi
    fi
done
