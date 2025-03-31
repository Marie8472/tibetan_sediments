#!/bin/bash

duplicates='ERR12814413 ERR12814415 ERR12814423 ERR12814427 ERR12814429 ERR12814435 ERR12814437 ERR12814439 ERR12814442 ERR12814445 ERR12814447 ERR12814449 ERR12814452 ERR12814456 ERR12814462 ERR12814468'

cd /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/03-data/
while read LINE; do
    duplicate=1
    if [ ! -z "$LINE" ]; then
        read -a linearray <<< "$LINE"

        sample=${linearray[0]}
        for d in $duplicates; do
            if [[ $d == $sample ]]; then
                duplicate=0
            fi
        done
        if [[ $duplicate -eq 1 ]]; then
            short_reads_1="/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/fastp/${sample}_1.fastq.gz"
            short_reads_2="/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/fastp/${sample}_2.fastq.gz"
            echo "${sample},0,${short_reads_1},${short_reads_2}," >> samplesheet_after_fastp.csv
        fi
    fi
done < /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/03-data/reads/filereport_read_run_PRJEB74036_tsv.txt  


samplesheet='/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/03-data/funcscan_samplesheet_mq.csv'

echo 'sample,fasta' > $samplesheet
while read LINE; do
    duplicate=1
    if [ ! -z "$LINE" ]; then
        IFS=',' read  -a linearray <<< "$LINE"

        if [[ "${linearray[1]}" == "Medium" ]] || [[ "${linearray[1]}" == "High" ]]; then
       
            for sample in $duplicates; do
                if [[ "${linearray[0]}" == *$sample* ]]; then
                    duplicate=0
                fi
            done
            if [[ $duplicate -eq 1 ]]; then
                sample=${linearray[0]}
                fasta="/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/GenomeBinning/DASTool/bins/${sample}.fa"
                echo "${fasta}" >> $samplesheet
                echo $sample
                # copy to folder to use as input for phylophlan
                cp $fasta /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/input
            fi
        fi
    fi
done < /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/refined_bin_quality.csv