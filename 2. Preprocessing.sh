#bash

#cd /Volumes/LorettaBAnalysis/Battis/bioinfo/TrainingData2

#STEP2: Sequence Quality check with FASTQC on downloaded FASTQs
#ls *.fastq| while read id; do
#FASTQC $id;
#done

#STEP 2: Check raw read count
#Print total number of reads, total number unique reads, percentage of unique reads, most abundant sequence, its frequency, and percentage of total in file.fq
#ls *.fastq| while read id ; do
#cat $id | awk '((NR-2)%4==0){read=$1;total++;count[read]++}END{for(read in count){if(!max||count[read]>max) {max=count[read];maxRead=read};if(count[read]==1){unique++}};print total,unique,unique*100/total,maxRead,count[maxRead],count[maxRead]*100/total}' > rawreadcount.txt
#done
#
##STEP3a: Read length check
#ls *.fastq| while read id;do
#cat $id| awk 'NR%4==0{count[length($1)]++}END{for(len in count){print len}}' > readlength.txt
#done

#STEP 3b: Truncate reads if necessary
#ls *.fastq| while read id ; do
#/opt/exp_soft/fastx-0.13/bin/fastx_trimmer -f 1 -l 30 -i $id -o $id.30bp.fastq
#done
#Re-count reads
#ls *.30bp.fastq| while read id ; do
#cat $id| awk 'NR%4==0{count[length($1)]++}END{for(len in count){print len}}' > rawreadcount30.txt
#done
#STEP4: Read mapping
#4a: Bowtie2
ls *.fastq| while read id; do
bowtie2 -q -p 10 -x /Volumes/LorettaBAnalysis/Battis/bioinfo/ChipSeq/Bowtie_Pre-built_Indexes/hg38/hg38/Homo_sapiens_GRCh38  -U $id -S $id.sam
done

##sort samfiles
ls *.sam | while read id; do
samtools sort -@4 $id > $id.sam
done

#4c: samtobam
ls *.sam.sam | while read id; do
samtools view -bT /Users/lollie/Documents/2018/MhlangaLab/Projects/PhD/Local_Data/Genomes/hg38/hg38.fa $id > $id.bam
done
ls *.sam.sam | while read id; do
samtools view -bT /Volumes/LorettaBAnalysis/Battis/Local_Data/Genomes/hg38/hg38.fa $id > $id.bam
done


##extract unique reads
ls *.sam.sam.bam | while read id; do
samtools view -h $id | grep -E -v "XS:i" | grep -E "@|AS:i" | samtools view -b - >| $id.uniq.bam
done



#exract mapped reads
ls *.sam.sam.bam.uniq.bam | while read id; do
samtools view -F 0x04 -b $id > $id.uniqm.bam
done
#exract MAPQ > 30
ls *.sam.sam.bam.uniq.bam.uniqm.bam | while read id; do
samtools view -q 30 -b $id > $id.q.bam
done

#sort
ls *.fastq.sam.sam.bam.uniq.bam.uniqm.bam.q.bam| while read id; do
samtools sort $id > $id.ss.bam
done

#mark duplicates
ls *.sam.sam.bam.uniq.bam.uniqm.bam.q.bam.ss.bam | while read  id; do
/Users/lollie/miniconda2/pkgs/picard-2.21.3-0/bin/picard MarkDuplicates I=$id O=$id.marked.bam M=$id.metrics.txt
done

#sort
ls *.fastq.sam.sam.bam.uniq.bam.uniqm.bam.q.bam.ss.bam.marked.bam | while read id; do
samtools sort $id > $id.ss.bam
done

#index
ls *.fastq.sam.sam.bam.uniq.bam.uniqm.bam.q.bam.ss.bam.marked.bam.ss.bam | while read id; do
samtools index $id > $id.bam
done

#5 renaming file extensions
rename -S .fastq.sam.sam.bam.uniq.bam.uniqm.bam.q.bam.ss.bam.marked.bam.ss.bam .marked.bam *.fastq.sam.sam.bam.uniq.bam.uniqm.bam.q.bam.ss.bam.marked.bam.ss.bam
rename -S .fastq.sam.sam.bam.uniq.bam.uniqm.bam.q.bam.ss.bam.marked.bam.ss.bam.bai .marked.bai *.fastq.sam.sam.bam.uniq.bam.uniqm.bam.q.bam.ss.bam.marked.bam.ss.bam.bai



