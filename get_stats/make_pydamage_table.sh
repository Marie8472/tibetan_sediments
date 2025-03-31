#!bin/bash

cd /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/Ancient_DNA/pydamage/analyze
csvfile="/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/pydamage_table.csv"
echo "Sample,reference,predicted_accuracy,null_model_p0,null_model_p0_stdev,damage_model_p,damage_model_p_stdev,damage_model_pmin,damage_model_pmin_stdev,damage_model_pmax,damage_model_pmax_stdev,pvalue,qvalue,RMSE,nb_reads_aligned,coverage,reflen,CtoT-0,CtoT-1,CtoT-2,CtoT-3,CtoT-4,CtoT-5,CtoT-6,CtoT-7,CtoT-8,CtoT-9,CtoT-10,CtoT-11,CtoT-12,CtoT-13,CtoT-14,CtoT-15,CtoT-16,CtoT-17,CtoT-18,CtoT-19" > $csvfile
for sample in $(ls); do
    echo $sample
    while read LINE; do
        if [ ! -z "$LINE" ]; then
            IFS=',' read -r -a linearray <<< "$LINE"
            if [[ "${linearray[0]}" != "reference" ]]; then
                echo "${sample},${LINE}" >> $csvfile
            fi
        fi
    done < $sample/pydamage_results/pydamage_results.csv
done