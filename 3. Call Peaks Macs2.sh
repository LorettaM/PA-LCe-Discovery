#!/bin/sh

#  3. Call Peaks Macs2.sh
#  
#
#  Created by Loretta Magagula on 2019/03/05.
#  

macs2 callpeak -t CRC_Caco2_CTCF_Test_1.2.bam -c CRC_Caco2_CTCF_Control_1.1.bam -g hs -n CRC_Caco2_CTCF_Test_1.2.macs -p 0.01
macs2 callpeak -t CRC_DLD1_CTCF_Test_1.1.bam -c CRC_DLD1_CTCF_Control_1.1.bam -g hs -n CRC_DLD1_CTCF_Test_1.1.macs -p 0.01
macs2 callpeak -t CRC_HCT116_CTCF_Test_3.1.bam -c CRC_HCT116_CTCF_Control_1.1.bam -g hs -n CRC_HCT116_CTCF_Test_3.1.macs -p 0.01
macs2 callpeak -t CTCF_SColon37_Test_1.1.bam -c CTCF_SColon37_Control_1.1.bam -g hs -n CTCF_SColon37_Test_1.1.macs -p 0.01
macs2 callpeak -t CTCF_SColon54_Test_1.1.bam -c CTCF_SColon54_Control_1.1.bam -g hs -n CTCF_SColon54_Test_1.1.macs -p 0.01

#remove blacklisted regions post peak calling
ls *.macs_peaks.narrowPeak | while read id; do
bedtools subtract -a $id -b /Users/lollie/Documents/2018/MhlangaLab/Projects/PhD/Local_Data/Genomes/hg38.blacklist.bed > $id.bl_filter.narrowPeak
done

#change suffix of filtered files
for file in *.macs_peaks.narrowPeak
do
mv "$file" "${file%..macs_peaks.narrowPeak}.unfiltered.narrowPeak"
done

#remove weird chromosomes
ls *.bl_filter.narrowPeak | while read id; do
sed '/chrM/d;/random/d;/alt/d;/chrUn/d' < $id > $id.filtered.narrowPeak
done
#remove intermediate files
ls *.bl_filter.narrowPeak | while read id; do
rm $id
done

#change suffix of filtered files
for file in *.macs_peaks.narrowPeak.bl_filter.narrowPeak.filtered.narrowPeak
do
mv "$file" "${file%.macs_peaks.narrowPeak.bl_filter.narrowPeak.filtered.narrowPeak}.macs_peaks.narrowPeak"
done


