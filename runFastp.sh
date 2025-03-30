#!/bin/bash

while read LINE; do
    if [ ! -z "$LINE" ]; then
        IFS=',' read -r -a linearray <<< "$LINE"
        sample=${linearray[0]}
        if [[ $sample == "sample" ]]; then
            read -r -a linearray <<< "$LINE"
        fi
        fastp --in1 /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/03-data/reads/${sample}_1.fastq.gz --in2 /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/03-data/reads/${sample}_2.fastq.gz --out1 /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/fastp/${sample}_1.fastq.gz --out2 /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/fastp/${sample}_2.fastq.gz \
        -a auto --poly_g_min_len 10 --poly_x_min_len 10 --qualified_quality_phred 15 --unqualified_percent_limit 40 --n_base_limit 5 \
        --length_required 30 --low_complexity_filter 30 --dont_overwrite --detect_adapter_for_pe  --trim_poly_g --trim_poly_x -w 25 --json /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/fastp/${sample}.json --html /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/fastp/${sample}.html 
    fi
done < /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/03-data/samplesheet.csv
