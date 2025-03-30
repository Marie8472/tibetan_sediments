#!bin/bash
#conda activate samtools
outputfile="/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mapped_reads_stats.csv"
echo "Sample,#_reads,label" > $outputfile
unmapped_reads=0
mapped_reads=0
while read LINE; do
    if [ ! -z "$LINE" ]; then
        IFS=',' read -a linearray <<< "$LINE"
        if [[ "${linearray[0]}" != "sample" ]]; then
            sample="${linearray[0]}"
            echo $sample
            path="/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/Assembly/MEGAHIT/QC/${sample}/MEGAHIT-${sample}-${sample}.bam"
            
            # -f Flag muss erfüllt werden
            # -F flag darf nicht nicht erfüllt werden
            # Flag 4 --> read unmapped
            unmapped_reads=$(samtools view -f 4 $path | wc -l)
            mapped_reads=$(samtools view -F 4 $path | wc -l)
            reads=$(($mapped_reads + $unmapped_reads))
            echo "MEGAHIT-${sample},${mapped_reads},mapped" >> $outputfile
            echo "MEGAHIT-${sample},${unmapped_reads},unmapped" >> $outputfile
        fi
    fi
done < /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/03-data/samplesheet_after_fastp.csv
# #conda deactivate

coverage_outputfile="/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/coverage_stats.csv"
echo "Sample,contig,length,#mapped_reads" > $coverage_outputfile
cd /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/Assembly/MEGAHIT/QC
list="ERR12814414 ERR12814416 ERR12814417 ERR12814418 ERR12814419 ERR12814422 ERR12814424 ERR12814425 ERR12814428 ERR12814430 ERR12814431 ERR12814432 ERR12814434 ERR12814436 ERR12814438 ERR12814440 ERR12814443 ERR12814444 ERR12814446 ERR12814448 ERR12814450 ERR12814453 ERR12814454 ERR12814455 ERR12814457 ERR12814458 ERR12814460 ERR12814461 ERR12814463 ERR12814464 ERR12814465 ERR12814467 ERR12814469 ERR12814470 ERR12814471 ERR12814472 ERR12814473 ERR12814474 ERR12814475 ERR12814476"
for sample in $list; do
    echo $sample
    #samtools index --threads 6 $sample/MEGAHIT-$sample-$sample.bam
    samtools idxstats --threads 6 $sample/MEGAHIT-$sample-$sample.bam > samtools_tmp
    while read LINE; do
        IFS=',' read -r -a linearray <<< "$LINE"
        if [[ "${linearray[0]}" == *$sample ]]; then
            tmp="${linearray[1]}"
            contig="${tmp/>/}"           
            length=$(grep -w $contig samtools_tmp | awk '{print $2}' | cut -d ':' -f 2)
            number_mapped_reads=$(samtools view --threads 6 -c $sample/MEGAHIT-$sample-$sample.bam $contig) 
            if [[ $number_mapped_reads != 0 ]]; then
                echo "${sample},$contig,${length},${number_mapped_reads}" >> $coverage_outputfile
            fi
        fi
    done <  /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/contig_stats.csv
done
