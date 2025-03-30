#!/bin/bash

while read LINE; do
    
    if [ ! -z "$LINE" ]; then
        IFS=',' read -r -a linearray <<< "$LINE"

        sample=${linearray[0]}

        if [[ $sample == "sample" ]] || [[ $sample == "ERR12814417" ]]; then

            read -r -a linearray <<< "$LINE"
        else
            megahit -1 /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/fastp/${sample}_1.fastq.gz \
            -2 /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/fastp/${sample}_2.fastq.gz\
            -o /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/megahit_sensitive_${sample} \
            --presets meta-sensitive --min-contig-len 500 --no-mercy --num-cpu-threads 25
            #--k-min 31 --k-max 149 --k-step 10
        fi
    fi
done < /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/03-data/smallSamplesheet.csv
