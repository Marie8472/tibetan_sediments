#!bin/bash

phylophlan_write_config_file \
    -d a \
    -o 02_tol.cfg \
    --db_aa diamond \
    --map_dna diamond \
    --map_aa diamond \
    --msa mafft \
    --trim trimal \
    --tree1 iqtree \
    --verbose 2>&1 | tee phylophlan_write_config_file.log

phylophlan \
    -i input \
    -d phylophlan \
    -f 02_tol.cfg \
    --diversity medium \
    --fast \
    -o output \
    --genome_extension .fa \
    --nproc 15 \
    --verbose 2>&1 | tee logs/phylophlan.log

####################
###Hydromicrobium###
####################

while read LINE; do
    if [ ! -z "$LINE" ]; then
        IFS=$'\t' read -r -a linearray <<< "$LINE"
        if [[ ${linearray[1]} == *g__Hydromicrobium* ]]; then
            cp "/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/input/${linearray[0]}.fa" /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/hydromicrobium/input
        fi
    fi
done < /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/gtdbtk/results/gtdbtk.bac120.summary.tsv


while read LINE; do
    if [ ! -z "$LINE" ]; then
        if [[ $LINE == '>'* ]]; then
            length=${#LINE}
            if [[ $length -ge 50 ]]; then
                echo $LINE 'length' $length
            fi
        fi
    fi
done < /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/phylophlan_databases/hydromicrobium/hydromicrobium.fna



#download core porteins from https://www.uniprot.org/uniparc?query=hydromicrobium
#

mkdir -p /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/hydromicrobium
gunzip /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/coreproteins/hydromicrobium/uniparc_hydromicrobium_2025_02_11.fasta.gz
CORE_Proteins='/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/coreproteins/hydromicrobium/uniparc_hydromicrobium_2025_02_11.fasta'

phylophlan_setup_database \
    -i $CORE_Proteins \
    -t a \
    -d hydromicrobium \
    -o /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/phylophlan_databases/hydromicrobium \
    --verbose --overwrite --genome_extension .fa
mkdir -p /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/hydromicrobium/input
input_dir="/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/hydromicrobium/input"
output_dir="/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/hydromicrobium/output"

while read LINE; do
    if [ ! -z "$LINE" ]; then
        IFS=$'\t' read -r -a linearray <<< "$LINE"
        if [[ ${linearray[1]} == *g__Hydromicrobium* ]]; then
            cp "/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/input/${linearray[0]}.fa" $input_dir
        fi
    fi
done < /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/gtdbtk/results/gtdbtk.bac120.summary.tsv

for dir in /Net/Groups/pbtdata/01_RAG/03_methods/bioinformatics/databases/ncbi-ref-genomes/hydromicrobium_02.2025/ncbi_dataset/data/G*; do
    cp $dir/* $input_dir
done

cp /Net/Groups/pbtdata/01_RAG/03_methods/bioinformatics/databases/ncbi-ref-genomes/hydromicrobium_02.2025/outgroup/GCA_002304935.1_ASM230493v1_genomic.fna $input_dir

for file in $input_dir/*.fna; do 
    new_file="${file::-3}" 
    mv $file "${new_file}fa"
done

phylophlan \
    -i $input_dir \
    -d phylophlan_databases/hydromicrobium \
    -f config.cfg \
    --diversity medium \
    --accurate \
    -o $output_dir \
    --nproc 25 \
    --verbose \
    --genome_extension .fa


# #download core porteins from https://www.uniprot.org/uniref?query=%28+%28+%28+%28+identity%3A0.9+%29+pseudomonas+iridis%29+%29+%29
# #/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/coreproteins/pseudomonas_iridis/uniref_identity_0_9_pseudomonas_irid_2025_02_10.fasta.gz
CORE_Proteins='/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/coreproteins/pseudomonas_iridis/uniref_identity_0_9_pseudomonas_irid_2025_02_10.fasta'

phylophlan_setup_database \
    -i /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/coreproteins/pseudomonas_iridis/uniref_identity_0_9_pseudomonas_irid_2025_02_10.fasta \
    -t a \
    -d pseudomonas \
    -o /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/phylophlan_databases/pseudomonas \
    --verbose --overwrite
    # -e .fna \
    # -t n 

input_dir="/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/pseudomonas/input"
output_dir="/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/pseudomonas/output"
while read LINE; do
    if [ ! -z "$LINE" ]; then
        IFS=$'\t' read -r -a linearray <<< "$LINE"
        if [[ ${linearray[1]} == *g__Pseudomonas* ]]; then
            cp "/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/input/${linearray[0]}.fa" $input_dir
        fi
    fi
done < /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/gtdbtk/results/gtdbtk.bac120.summary.tsv

for dir in /Net/Groups/pbtdata/01_RAG/03_methods/bioinformatics/databases/ncbi-ref-genomes/pseudomonas_02.2025/RefSeq_ncbi_dataset/ncbi_dataset/data/G*; do
    cp $dir/* $input_dir
done

for dir in /Net/Groups/pbtdata/01_RAG/03_methods/bioinformatics/databases/ncbi-ref-genomes/pseudomonas_02.2025/MAGs_ncbi_dataset/ncbi_dataset/data/G*; do
    cp $dir/* $input_dir
done


cp /Net/Groups/pbtdata/01_RAG/03_methods/bioinformatics/databases/ncbi-ref-genomes/pseudomonas_02.2025/outgroup/GCF_016028635.1_ASM1602863v1_genomic.fna $input_dir
for file in $input_dir/*.fna; do 
    new_file="${file::-3}" 
    mv $file "${new_file}fa"
done

phylophlan \
    -i $input_dir \
    -d phylophlan_databases/pseudomonas \
    -f config.cfg \
    --diversity low \
    --accurate \
    -o $output_dir \
    --nproc 28 \
    --verbose \
    --genome_extension .fa


################
###Acidovorax###
################

#download core porteins from https://www.uniprot.org/uniref?query=%28+%28+identity%3A0.9+%29+acidovorax+facilis%29
#/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/coreproteins/acidovorax_facilis/uniref_identity_0_9_acidovorax_facil_2025_02_10.fasta.gz

mkdir -p /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/acidovorax
gunzip /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/coreproteins/acidovorax_facilis/uniref_identity_0_9_acidovorax_facil_2025_02_10.fasta.gz
CORE_Proteins='/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/coreproteins/acidovorax_facilis/uniref_identity_0_9_acidovorax_facil_2025_02_10.fasta'

phylophlan_setup_database \
    -i $CORE_Proteins \
    -t a \
    -d acidovorax \
    -o /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/phylophlan_databases/acidovorax \
    --verbose --overwrite
mkdir -p /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/acidovorax/input
input_dir="/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/acidovorax/input"
output_dir="/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/acidovorax/output"

while read LINE; do
    if [ ! -z "$LINE" ]; then
        IFS=$'\t' read -r -a linearray <<< "$LINE"
        if [[ ${linearray[1]} == *g__Acidovorax* ]]; then
            cp "/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/input/${linearray[0]}.fa" $input_dir
        fi
    fi
done < /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/gtdbtk/results/gtdbtk.bac120.summary.tsv

for dir in /Net/Groups/pbtdata/01_RAG/03_methods/bioinformatics/databases/ncbi-ref-genomes/acidovorax_02.2025/ncbi_dataset/data/G*; do
    cp $dir/* $input_dir
done


cp /Net/Groups/pbtdata/01_RAG/03_methods/bioinformatics/databases/ncbi-ref-genomes/acidovorax_02.2025/outgroup/GCF_000215705.1_ASM21570v1_genomic.fna $input_dir

for file in $input_dir/*.fna; do 
    new_file="${file::-3}"  
    mv $file "${new_file}fa"
done
phylophlan \
    -i $input_dir \
    -d phylophlan_databases/acidovorax \
    -f config.cfg \
    --diversity medium \
    --accurate \
    -o $output_dir \
    --nproc 25 \
    --verbose --genome_extension .fa

##################
###Pseudolabrys###
##################

#download core porteins from https://www.uniprot.org/uniref?query=%28+%28+%28+identity%3A0.9+%29+pseudolabrys+taiwanensis+%29+%29
#

mkdir -p /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/pseudolabrys
gunzip /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/coreproteins/pseudolarys_taiwanensis/uniref_identity_0_9_pseudolabrys_tai_2025_02_11.fasta.gz
CORE_Proteins='/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/coreproteins/pseudolarys_taiwanensis/uniref_identity_0_9_pseudolabrys_tai_2025_02_11.fasta'

phylophlan_setup_database \
    -i $CORE_Proteins \
    -t a \
    -d pseudolabrys \
    -o /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/phylophlan_databases/pseudolabrys \
    --verbose --overwrite

mkdir -p /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/pseudolabrys/input
input_dir="/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/pseudolabrys/input"
output_dir="/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/pseudolabrys/output"

while read LINE; do
    if [ ! -z "$LINE" ]; then
        IFS=$'\t' read -r -a linearray <<< "$LINE"
        if [[ ${linearray[1]} == *g__Pseudolabrys* ]]; then
            cp "/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/input/${linearray[0]}.fa" $input_dir
        fi
    fi
done < /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/gtdbtk/results/gtdbtk.bac120.summary.tsv

for dir in /Net/Groups/pbtdata/01_RAG/03_methods/bioinformatics/databases/ncbi-ref-genomes/pseudolabrys_02.2025/ncbi_dataset/data/G*; do
    cp $dir/* $input_dir
done


cp /Net/Groups/pbtdata/01_RAG/03_methods/bioinformatics/databases/ncbi-ref-genomes/pseudolabrys_02.2025/outgroup/GCF_000092925.1_ASM9292v1_genomic.fna $input_dir

for file in $input_dir/*.fna; do 
    new_file="${file::-3}"  
    mv $file "${new_file}fa"
done

phylophlan \
    -i $input_dir \
    -d phylophlan_databases/pseudolabrys \
    -f config.cfg \
    --diversity medium \
    --accurate \
    -o $output_dir \
    --nproc 25 \
    --verbose --genome_extension .fa


######################
###Pararheinheimera###
######################

#download core porteins from https://www.uniprot.org/uniref?query=%28identity%3A0.9%29Rheinheimera+sp+MM224
#
mkdir -p /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/pararheinheimera
gunzip /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/coreproteins/rheinheimera_sp_MM224/uniref_identity_0_9_Rheinheimera_sp_2025_02_10.fasta.gz
CORE_Proteins='/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/coreproteins/rheinheimera_sp_MM224/uniref_identity_0_9_Rheinheimera_sp_2025_02_10.fasta'

phylophlan_setup_database \
    -i $CORE_Proteins \
    -t a \
    -d pararheinheimera \
    -o /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/phylophlan_databases/pararheinheimera \
    --verbose --overwrite

mkdir -p /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/pararheinheimera/input
input_dir="/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/pararheinheimera/input"
output_dir="/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/pararheinheimera/output"

while read LINE; do
    if [ ! -z "$LINE" ]; then
        IFS=$'\t' read -r -a linearray <<< "$LINE"
        if [[ ${linearray[1]} == *g__Pararheinheimera* ]]; then
            cp "/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/phylophlan/input/${linearray[0]}.fa" $input_dir
        fi
    fi
done < /Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/gtdbtk/results/gtdbtk.bac120.summary.tsv

for dir in /Net/Groups/pbtdata/01_RAG/03_methods/bioinformatics/databases/ncbi-ref-genomes/pararheinheimera_02.2025/ncbi_dataset/data/G*; do
    cp $dir/* $input_dir
done


cp /Net/Groups/pbtdata/01_RAG/03_methods/bioinformatics/databases/ncbi-ref-genomes/pararheinheimera_02.2025/outgroup/GCF_000227745.2_ASM22774v3_genomic.fna $input_dir

for file in $input_dir/*.fna; do 
    new_file="${file::-3}"  
    mv $file "${new_file}fa"
done

phylophlan \
    -i $input_dir \
    -d phylophlan_databases/pararheinheimera \
    -f config.cfg \
    --diversity medium \
    --accurate \
    -o $output_dir \
    --nproc 25 \
    --verbose --genome_extension .fa


