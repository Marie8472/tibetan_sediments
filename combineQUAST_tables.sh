#!bin/bash
csvfile="/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/combinedQUAST_table.csv"

cd /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/Assembly/MEGAHIT/QC

echo "Sample,# contigs (>= 0 bp),# contigs (>= 1000 bp),# contigs (>= 5000 bp),# contigs (>= 10000 bp),\
# contigs (>= 25000 bp),# contigs (>= 50000 bp),Total length (>= 0 bp),Total length (>= 1000 bp),\
Total length (>= 5000 bp),Total length (>= 10000 bp),Total length (>= 25000 bp),Total length (>= 50000 bp),\
# contigs,Largest contig,Total length,GC (%),N50,N75,L50,L75,# N's per 100 kbp,# predicted rRNA genes,age" > $csvfile
for dir in $(ls); do
    string=""
    while read LINE; do
         if [ ! -z "$LINE" ]; then
            IFS=$'\t' read -r -a linearray <<< "$LINE"
            if [[ "${linearray[1]}" == MEGAHIT* ]]; then
                IFS=" - " read -r -a array <<< "${linearray[1]}"
                name=${array[1]}
            fi
            string="${string}${linearray[1]},"
             
         fi
    done < $dir/QUAST/report.tsv

    while read LINE; do
    
        if [ ! -z "$LINE" ]; then
            read -a linearray <<< "$LINE"

            sample=${linearray[0]}
            if [[ $sample == $name ]]; then
            
                library_name=${linearray[15]}
                
                while read ROW; do
                    if [ ! -z "$ROW" ]; then
                        IFS=';' read -r -a lines <<< "$ROW"
                        if [[ ${lines[0]} == $library_name ]]; then
                            age=${lines[2]}
                            if [[ $age == "/" ]]; then
                                age=""
                            fi
                            break
                        fi
                    fi
                done < /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/03-data/sciadv.adn8490_data_s1_to_s3/adn8490_data_s3.csv
            fi
        fi
    done < /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/03-data/reads/filereport_read_run_PRJEB74036_tsv.txt

    echo $string$age >> $csvfile
done
