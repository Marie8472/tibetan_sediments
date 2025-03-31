#!/bin/bash


nextflow run . \
--input /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/03-data/samplesheet_after_fastp.csv \
--outdir /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3 \
-w /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_work3 \
-profile singularity \
-c ./nf-core_small.config \
--max_memory 500.GB \
--max_cpus 50 \
--max_time 200.h \
--skip_spades \
--skip_spadeshybrid \
--kraken2_db /Net/Groups/ccdata/databases/kraken2_12.1.2024/k2_standard_16gb_20240112.tar.gz \
--megahit_options "--min-contig-len 500 --k-min 31 --k-max 149 --k-step 10 --no-mercy" \
--skip_prodigal \
--skip_prokka \
--skip_metaeuk \
--min_contig_size 1600 \
--save_assembly_mapped_reads \
--ancient_dna \
--skip_clipping \
--busco_clean \
--run_gunc \
--gunc_save_db \
--binning_map_mode own \
--refine_bins_dastool \
--skip_gtdbtk \
--bin_domain_classification \
--cat_db /Net/Groups/ccdata/databases/cat_2021/CAT_prepare_20210107.tar.gz \
--cat_official_taxonomy \
--skip_binqc  -resume

# --postbinning_input refined_bins_only
#--gtdbtk_pplacer_cpus 1 \
# --gtdb_db /Net/Groups/ccdata/databases/GTDB/v214.1 \
# --gtdbtk_min_completeness 70 \
# --gtdbtk_min_perc_aa 50 \
#--save_busco_db \
#--save_checkm_data \
#--skip_binning \
#--megahit_fix_cpu_1 \
#--assembly_input /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/03-data/smallSamplesheet_assemblies.csv \
#--megahit_options "--presets meta-large --kmin-1pass"
#--skip_metabat2 \
#--skip_maxbin2 \
#--skip_concoct \
#--skip_binqc \
#--skip_krona \
#--reads_minlength 30 \