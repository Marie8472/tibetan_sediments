#!bin/bash

reads_output_file_class="/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/reads_taxonomy_table_class.csv"
cd /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/Taxonomy/kraken2
echo "Sample,Percentage,#Fragments,Rank,NCBI_Id,Name" > $reads_output_file_class

for sample in $(ls); do
    while read LINE; do
        if [ ! -z "$LINE" ]; then
            IFS=$'\t' read -r -a linearray <<< "$LINE"
            # Rank code, only phylum
            if [[ ${linearray[3]} == C* ]]; then
                perentage="${linearray[0]}"
                #echo $perentage
                fragments="${linearray[2]}" #Number of fragments assigned directly to this taxon
                rank="${linearray[3]}"
                NCBI_Id="${linearray[4]}"
                name="${linearray[5]}"
                name="${name//,/;}"

                echo "${sample},${perentage},${fragments},${rank},${NCBI_Id},${name}" >> $reads_output_file_class
            fi
        fi
    done < $sample/*.txt
done

