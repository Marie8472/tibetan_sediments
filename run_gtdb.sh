#!bin/bash
gtdbtk classify_wf --genome_dir /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/GenomeBinning/DASTool/bins/ \
 --tmpdir ../04-analysis/gtdbtk/tmp --cpus 30 --mash_db /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/gtdbtk/mash_db \
 --out_dir /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/gtdbtk/results -x fa \
 --pplacer_cpus 25 --scratch_dir /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/gtdbtk/scratch

#conda env config vars set GTDBTK_DATA_PATH="/Net/Groups/ccdata/databases/GTDBtk/GTDBtk_v220/release220"