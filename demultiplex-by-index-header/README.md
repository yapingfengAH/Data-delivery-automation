# demultiplex-by-index-header v1.1

## **Command-line** <br>
nohup ./main.sh -w /folderpath -h dmx -p &lt;parallel runs&gt; -j &lt;projectID&gt; -a Undetermined-R1.fastq.gz -b Undetermined-R2.fastq.gz -s SampleSheet.csv -l &lt;barcode length&gt; -m &lt;mismatch&gt; -k &lt;index type&gt; > /folderpath/&lt;ProjectID&gt;.log.out 2>&1 & <br>

**Arguments** <br>
-w  Working directory path <br>
-h  Script ID for matching job ID (please use “dmx” as default) <br>
-p  Max number of parallel runs (use 10 as default, may use more) <br>
-j Project folder name (same name as log.out file) <br>
-a  Undetermined reads R1: fastq.gz file <br>
-b  Undetermined reads R2: fastq.gz file <br>
-s  Samplesheet: csv file <br>
-l  Barcode length:  6; 8; 10 <br>
-m  Mismatch:  0 = no mismatch;  1 = one mismatch <br>
-k  Index type:  1 = single index;  2 = dual indexes <br>

**Example** <br>
nohup ./main.sh -w /fast-data/BI/RUO_wchen/test/demultiplex-v1.1 -h dmx -p 20 -j 22167-01 -a /fast-data/BI/RUO_wchen/FastQ/undetermined-reads/Undetermined-121922-x-fc1_S0_L004_R1_001.fastq.gz -b /fast-data/BI/RUO_wchen/FastQ/undetermined-reads/Undetermined-121922-x-fc1_S0_L004_R2_001.fastq.gz -s /fast-data/BI/RUO_wchen/samplesheet/SampleSheet-121922-x-fc1-L04-test2.csv -l 6 -m 1 -k 2 > /fast-data/BI/RUO_wchen/test/demultiplex-v1.1/22167-01.log.out 2>&1 &

**Note** <br>
The name of log.out file should to the same as project folder name.  For example, if the project folder name is 22167-01, then the log.out file will be 22167-01.log.out.

FastQ files will be generated in the “fastq” folder under the project folder.

Other files that will also be generated under the project folder: <br>
mm1.txt – Variation of Index 1 <br>
mm2.txt – Variation of Index 2 <br>
samplelist.txt – List containing samples and barcodes from the samplesheet <br>
runtime.txt – Total run time of the script. <br>

## **Introduction** <br>
Demultiplex-by-Index-Header script splits undetermined reads by their index header, and provides an alternative way of performing demultiplex locally instead of re-demultiplexing samples from run using the more computational-demanding bcl2fastq program.  Variable barcode length, mismatch, and type can be assessed using this script. <br>

**Advantage** <br>
• Consume less resources using built-in Bash command zcat and grep. <br>
• Allow less time to complete by parallel processing. * <br>

**Limitation** <br>
• Less customization in order to reduce computational complexity. <br>
• Data with huge size may still take longer time to process when compared to using demultiplex application on BaseSpace. * <br>

## Requirement
**Input Files** <br>
• Undetermined reads R1: fastq.gz file (compressed) <br>
• Undetermined reads R2: fastq.gz file (compressed) <br>
• Samplesheet (see examples below): csv file <br>

Creat a samplesheet from the template.  Note that columns Samples ID, Index (i7), and Index2 (i5) are needed for the script.  This samplesheet shows dual indexes with nucleotide length of 8 each.

![image](https://github.com/yapingfengAH/Data-delivery-automation/blob/master/demultiplex-by-index-header/images/index_duel_8_nt.jpg)

This samplesheet shows dual indexes with length of 6.

![image](https://github.com/yapingfengAH/Data-delivery-automation/blob/master/demultiplex-by-index-header/images/index_duel_6_nt.jpg)

This samplesheet shows single index with length of 6.  Note that column Index2 should be filled with a place-holder index, and wil not affect the results.

![image](https://github.com/yapingfengAH/Data-delivery-automation/blob/master/demultiplex-by-index-header/images/index_single_6_nt.jpg)

**Required Scripts (placed in same folder)** <br>
• Main.sh – Master script <br>
• convert2txt.py <br>
• dmx0-R1.sh <br>
• dmx0-R2.sh <br>
• dmx6-R1.sh <br>
• dmx6-R1.sh <br>
• dmx8-R1.sh <br>
• dmx8-R1.sh <br>
• dmx10-R1.sh <br>
• dmx10-R1.sh <br>

**Programming Language** <br>
• Bash <br>
• Python <br>

## Additional Note
To count reads: echo $(zcat file.fastq.gz|wc -l)/4|bc <br>
To check current jobs: ps <br>
To cancel individual job: kill <job-ID> <br>
To cancel all jobs in user account: pkill -u <user-ID> <br>
Cancel all jobs only when no other important jobs are running. <br>

