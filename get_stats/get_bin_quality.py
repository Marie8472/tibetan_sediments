import csv

##unrefined
with open('/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/GenomeBinning/QC/checkm2_summary_unrefined.tsv',newline='') as csvfile:
    data = list(csv.reader(csvfile, delimiter='\t'))
## refined
# with open('/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/mag/mag_results3/GenomeBinning/QC/CheckM2/DASTOOL/quality_report.tsv',newline='') as csvfile:
#     data = list(csv.reader(csvfile, delimiter='\t'))

checkm2_dict = {}
for i in range(0,len(data)):
    if data[i][1] != "Completeness":
        bin_name = data[i][0].split('.fa')[0]
        checkm2_quality = "Low"
        #completion > 90% and contamination < 5%
        if float(data[i][1]) > 90.0 and float(data[i][2]) < 5.0:
            checkm2_quality = "High"
        #completion >= 50% and contamination < 10%
        elif float(data[i][1]) >= 50.0 and float(data[i][2]) < 10.0:
            checkm2_quality ="Medium"

        checkm2_dict[bin_name] = checkm2_quality

##unrefined
with open('/Net/Groups/pbtdata/01_RAG/09_sediments/tibetan_sediments/04-analysis/bin_quality.csv','w') as file:
    w = csv.writer(file)
    w.writerow(["bin","checkm2_quality"])
    for key in checkm2_dict.keys():
        w.writerow([key,checkm2_dict[key]])