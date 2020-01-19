#!/bin/sh

#PBS -N SColonhg38_pairs_align
#PBS -q UCTlong
#PBS -l nodes=1:ppn=25:series600
#PBS -M loretta@mhlangalab.org
#PBS -m abe
##Environmental setting

export PATH=/opt/exp_soft/fastx-0.13:$PATH
export PATH=/opt/exp_soft/bowtie2-2.2.6:$PATH
export PATH=/home/mgglor001/sratoolkit.2.9.0-centos_linux64/bin/fastq-dump.2:$PATH

cd /researchdata/fhgfs/mgglor001
#########CTCF_SColon54_Test_1.1
###call files from encode
curl -O -L https://www.encodeproject.org/files/ENCFF800GHL/@@download/ENCFF800GHL.fastq.gz
curl -O -L https://www.encodeproject.org/files/ENCFF100YUK/@@download/ENCFF100YUK.fastq.gz
##decompress
gzip -d ENCFF800GHL.fastq.gz
mv ENCFF800GHL.fastq CTCF_SColon54_Test_1.1_Pair_1.fastq
rm ENCFF800GHL.fastq
gzip -d ENCFF100YUK.fastq.gz
mv ENCFF100YUK.fastq CTCF_SColon54_Test_1.1_Pair_2.fastq
rm ENCFF100YUK.fastq
##align
bowtie2 -q -p 10 -x /researchdata/fhgfs/mgglor001/hg38/Homo_sapiens_GRCh38 -1 CTCF_SColon54_Test_1.1_Pair_1.fastq -2 CTCF_SColon54_Test_1.1_Pair_2.fastq -S CTCF_SColon54_Test_1.1.fastq.sam

#########CTCF_SColon54_Control_1.1
###call files from encode
curl -O -L https://www.encodeproject.org/files/ENCFF848NLY/@@download/ENCFF848NLY.fastq.gz
Curl -O -L https://www.encodeproject.org/files/ENCFF592JZV/@@download/ENCFF592JZV.fastq.gz
##decompress
gzip -d ENCFF848NLY.fastq.gz
mv ENCFF848NLY.fastq CTCF_SColon54_Control_1.1_Pair_1.fastq
rm ENCFF848NLY.fastq
gzip -d ENCFF592JZV.fastq.gz
mv ENCFF592JZV.fastq CTCF_SColon54_Control_1.1_Pair_2.fastq
rm ENCFF592JZV.fastq
##align
bowtie2 -q -p 10 -x /researchdata/fhgfs/mgglor001/hg38/Homo_sapiens_GRCh38 -1 CTCF_SColon54_Control_1.1_Pair_1.fastq -2 CTCF_SColon54_Control_1.1_Pair_2.fastq -S CTCF_SColon54_Control_1.1.fastq.sam

#######CTCF_SColon37_Control_1.1
##call files from encode
curl -O -L https://www.encodeproject.org/files/ENCFF913JQM/@@download/ENCFF913JQM.fastq.gz
curl -O -L https://www.encodeproject.org/files/ENCFF024VTZ/@@download/ENCFF024VTZ.fastq.gz
###decompress
gzip -d ENCFF913JQM.fastq.gz
mv ENCFF913JQM.fastq CTCF_SColon37_Control_1.1_Pair_1.fastq
rm ENCFF913JQM.fastq
gzip -d ENCFF024VTZ.fastq.gz
mv ENCFF024VTZ.fastq CTCF_SColon37_Control_1.1_Pair_2.fastq
rm ENCFF024VTZ.fastq
##align
bowtie2 -q -p 10 -x /Volumes/LorettaBAnalysis/Battis/bioinfo/ChipSeq/Bowtie_Pre-built_Indexes/hg38/hg38/Homo_sapiens_GRCh38 -1 CTCF_TColon37_Control_1.1_Pair_1.fastq -2 CTCF_TColon37_Control_1.1_Pair_2.fastq -S CTCF_TColon37_Control.fastq.sam


#######CTCF_SColon37_Test_1.1
call files from encode
curl -O -L https://www.encodeproject.org/files/ENCFF991UEV/@@download/ENCFF991UEV.fastq.gz
curl -O -L https://www.encodeproject.org/files/ENCFF547KHV/@@download/ENCFF547KHV.fastq.gz
##decompress
gzip -d ENCFF991UEV.fastq.gz
mv ENCFF991UEV.fastq CTCF_SColon37_Test_1.1_Pair_1.fastq
ENCFF991UEV.fastq
gzip -d ENCFF547KHV.fastq.gz
mv ENCFF547KHV.fastq CTCF_SColon37_Test_1.1_Pair_2.fastq
ENCFF547KHV.fastq
#align
bowtie2 -q -p 10 -x /researchdata/fhgfs/mgglor001/hg38/Homo_sapiens_GRCh38 -1 CTCF_SColon37_Test_1.1_Pair_1.fastq -2 CTCF_SColon37_Test_1.1_Pair_2.fastq -S CTCF_SColon37_Test_1.1.fastq.sam


