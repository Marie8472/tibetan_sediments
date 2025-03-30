#!bin/bash

cd /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/QC_shortreads/remove_phix

csvfile="/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/number_of_reads.csv"
echo "Sample,#_reads,label" > $csvfile
for file in $(ls); do
    while read LINE; do
        if [ ! -z "$LINE" ]; then
            IFS=' ' read -r -a linearray <<< "$LINE"
            processed_reads="${linearray[0]}"
            sample=${file/_run0_phix_removed.bowtie2.log/}
            echo "${sample},${processed_reads},processed" >> $csvfile
            break
        fi
    done < $file
    while read ROW; do
        if [ ! -z "$ROW" ]; then
            IFS=$'\t' read -r -a lines <<< "$ROW"
            if [[ $sample == "${lines[0]}" ]]; then
                raw_reads="${lines[17]}"
                echo "${sample},${raw_reads},raw" >> $csvfile
                break
            fi
        fi
    done < /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/03-data/reads/filereport_read_run_PRJEB74036_tsv.txt
    
done