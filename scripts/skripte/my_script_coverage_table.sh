echo -e "Strain\tR1_file\tR2_file\tR1_reads\tR2_reads\tTotal_bases_read\tGenome_bp\tCoverage" > coverage_table.tsv
for soj in 1 2 3 4 5; do
Name_R1_file=$(find "$soj" -maxdepth 1 -type f -name "*_1.fq" | head -n 1)
Name_R2_file=$(find "$soj" -maxdepth 1 -type f -name "*_2.fq" | head -n 1)

if [ -z "$Name_R1_file" ] || [ -z "$Name_R2_file" ]; then
echo -e "$soj\tStrain_not_found\tStrain_not_found\tNA\tNA\tNA\t4000000\tNA" >> coverage_table.tsv
continue

fi

R1_reads=$(( $(wc -l < "$Name_R1_file") / 4 ))
R2_reads=$(( $(wc -l < "$Name_R2_file") / 4 ))

Total_bases_read=$(( R1_reads * 150  + R2_reads * 150 ))
Genome_bp=4000000
Coverage_x=$(awk "BEGIN {printf\"%.2f\", $Total_bases_read / $Genome_bp}")
echo -e "$soj\t$(basename "$Name_R1_file")\t$(basename "$Name_R2_file")\t$R1_reads\t$R2_reads\t$Total_bases_read\t$Genome_bp\t$Coverage_x" >> coverage_table.tsv
done

