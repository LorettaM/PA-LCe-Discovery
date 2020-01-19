#!/bin/sh
#!/bin/sh

#PBS -N hg38_pairs_align
#PBS -q UCTlong
#PBS -l nodes=1:ppn=5:series600
#PBS -M mgglor001@myuct.ac.za
#PBS -m abe
##Environmental setting

export PATH=/opt/exp_soft/fastx-0.13:$PATH
export PATH=/opt/exp_soft/bowtie2-2.2.6:$PATH
export PATH=/home/mgglor001/sratoolkit.2.9.0-centos_linux64/bin/fastq-dump.2:$PATH

cd /researchdata/fhgfs/mgglor001
#Caco2_Control1.1
/home/mgglor001/sratoolkit.2.9.0-centos_linux64/bin/fastq-dump.2 SRR299299
#Caco2_Test1.2
/home/mgglor001/sratoolkit.2.9.0-centos_linux64/bin/fastq-dump.2 SRR299297
#HCT116_Control1.1
/home/mgglor001/sratoolkit.2.9.0-centos_linux64/bin/fastq-dump.2 SRR299382
#HCT116_Test3.1
/home/mgglor001/sratoolkit.2.9.0-centos_linux64/bin/fastq-dump.2 SRR604580

