#!bin/bash

nextflow run . \
--input /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/03-data/funcscan_samplesheet_mq.csv \
--outdir /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/funcscan_rerun/funcscan/funcsan_results_mq \
-w /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/funcscan_rerun/funcscan/funcsan_work_mq \
-c /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/02-scripts/funcscan_rerun.config \
-profile singularity \
--run_taxa_classification \
--save_db \
--save_annotations -resume

nextflow run . \
--input /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/03-data/funcscan_samplesheet_hq.csv \
--outdir /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/funcscan_rerun/funcscan/funcsan_results_hq \
-w /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/funcscan_rerun/funcscan/funcsan_work_hq \
-c /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/02-scripts/funcscan_rerun.config \
-profile singularity \
--run_taxa_classification \
--save_db \
--save_annotations -resume
