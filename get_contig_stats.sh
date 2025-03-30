#!bin/bash


# gets the length and contig id of each contig for each sample

cd /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/Assembly/MEGAHIT

echo "Sample,contig_id,contig_length" > /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/contig_stats.csv

for file in $(ls); do
    
    if [[ $file == *.contigs.fa.gz ]]; then
        echo $file
        basename "$file"
        name="$(basename -- $file)"
        IFS='.' read -a namearray <<< "$name"
        sample=${namearray[0]}
        zgrep '>' $file > /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/temp
        while read LINE; do
            if [ ! -z "$LINE" ]; then
                IFS=' ' read -r -a linearray <<< "$LINE"
                contig_id=${linearray[0]}
                IFS='=' read -a line <<< "$LINE"
                contig_length=${line[3]}
                echo "${sample},${contig_id},${contig_length}" >> /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/contig_stats.csv
            fi
        done < /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/temp
    fi
done < /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/Assembly/MEGAHIT
rm /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/temp


# combines the data from quast with the previous data
echo "" > /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/full_contig_stats.csv
while read LINE; do
    if [ ! -z "$LINE" ]; then
        IFS=',' read -a linearray <<< "$LINE"
        sample="${linearray[0]}"

        while read ROW; do
            if [ ! -z "$ROW" ]; then
                IFS=',' read -a lines <<< "$ROW"
                if [[ $sample == "${lines[0]}" ]]; then
                    l=""
                    for i in {1..23}; do
                        l="${l},${lines[$i]}"
                    done
                    echo "${LINE}${l}" >> /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/full_contig_stats.csv
                fi
            fi
        done < /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/combinedQUAST_table.csv
    fi
done < /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/contig_stats.csv
