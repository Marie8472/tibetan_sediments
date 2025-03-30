#!bin/bash

tsvfile="/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/funcscan_rerun/funcscan/taxonomy.tsv"
echo $'bin \tcontig  \tLCA NCBI taxon ID \tlca rank name \tlca scientific name \t1 \t2 \t3 \t4 \ttax_1 \ttax_2' >$tsvfile
echo "high"
for dir in /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/funcscan_rerun/funcscan/funcsan_results_hq/taxa_classification/mmseqs_createtsv/*; do
    #echo $dir
    for file in $dir/*; do            
        tmp=$(basename $file)
        bin=${tmp%.*}
        
        while read LINE; do
            if [ ! -z "$LINE" ]; then
                IFS=$'\t' read -r -a linearray <<< "$LINE"
                #echo $dir3
                echo $bin $'\t' ${linearray[0]}$'\t' ${linearray[1]}$'\t' ${linearray[2]}$'\t' ${linearray[3]}$'\t' ${linearray[4]}$'\t' ${linearray[5]}$'\t' ${linearray[6]}$'\t' ${linearray[7]} $'\t' ${linearray[8]} $'\t' ${linearray[9]} >> $tsvfile
            fi
        done < $file
    done
done
echo "medium"
for dir in /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/funcscan_rerun/funcscan/funcsan_results_mq/taxa_classification/mmseqs_createtsv/*; do
    #echo $dir
    for file in $dir/*; do            
        tmp=$(basename $file)
        bin=${tmp%.*}
        
        while read LINE; do
            if [ ! -z "$LINE" ]; then
                IFS=$'\t' read -r -a linearray <<< "$LINE"
                #echo $dir3
                echo $bin $'\t' ${linearray[0]}$'\t' ${linearray[1]}$'\t' ${linearray[2]}$'\t' ${linearray[3]}$'\t' ${linearray[4]}$'\t' ${linearray[5]}$'\t' ${linearray[6]}$'\t' ${linearray[7]} $'\t' ${linearray[8]} $'\t' ${linearray[9]} >> $tsvfile
            fi
        done < $file
    done
done