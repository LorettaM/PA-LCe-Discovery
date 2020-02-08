#!/bin/sh

#  6. findknownmotifs with homer.sh
#  
#
#  Created by Loretta Magagula on 2019/03/11.
#
#
#ls *.bed | while read id; do bedtools intersect -v -a $id -b /Users/lollie/Documents/2018/MhlangaLab/Projects/PhD/Local_Data/Genomes/hg38.blacklist.bed > $id.f.bed
#done
#ls *.f.bed | while read id; do bedtools sort -i $id > $id.s.bed
#done
#ls *.s.bed | while read id; do bedtools merge -i $id > $id.m.bed
#done
#for file in *.f.bed.s.bed.m.bed
#do
#mv "$file" "${file%.f.bed.s.bed.m.bed}.bed"/Users/lollie/Programs/miniconda2/bin/icuinfo
#done


#Find CTCF motif in Peaks .bed

ls *.bed | while read id; do
cut -f1-3 $id > $id.cut.bed
done

ls *.cut.bed | while read id; do
bedtools sort -i $id -g /Volumes/LorettaBAnalysis/Battis/Local_Data/Genomes/hg38/hg38.chrom.sizes.txt > $id.sorted.bed
done

#1.Annotate Peaks with CTCF motif
ls *.sorted.bed | while read id; do
/Users/lollie/Programs/miniconda2/bin/annotatePeaks.pl $id /Users/lollie/Programs/miniconda2/bin/.//data/genomes/hg38 -m /Users/lollie/Programs/miniconda2/data/knownTFs/motifs/ctcf.motif -mfasta $id.fa -mbed $id.m.bed -annStats $id.ctcf.f.annStats > $id.ctcfannotatedfa.bed
done

ls *.ctcfannotatedfa.bed | while read id; do /Users/lollie/Programs/miniconda2/bin/.//bin//annotatePeaks.pl $id hg38 -m /Users/lollie/Programs/miniconda2/data/knownTFs/motifs/ctcf.motif -mfasta $id.ctcf.ann.fa -mbed $id.ctcf.ann.bed -annStats $id.annStats > $id.ctcf.annotated.bed ; done


#Find CTCF motif in Fasta
#bedtools, sort & merge?

ls *.fa | while read id; do /Users/lollie/Programs/miniconda2/bin/findMotifs.pl $id fasta . -find /Users/lollie/Programs/miniconda2/motifs/ctcf.motif > $id.CTCFMotif.bed; done

#reports as .csv
ls *.fa | while read id; do /Users/lollie/Programs/miniconda2/bin/findMotifs.pl  $id fasta . -find /Users/lollie/Programs/miniconda2/motifs/ctcf.motif > $id.CTCFMotif.csv ; done


#findMotifsGenome

ls *.fa | while read id; do /Users/lollie/Programs/miniconda2/bin/findMotifs.pl $id /Users/lollie/Programs/miniconda2/bin/.//data/genomes/hg38/ $id.findknownmotifs -fasta /Users/lollie/Programs/miniconda2/bin/.//data/genomes/hg38/hg38.fa ; done


