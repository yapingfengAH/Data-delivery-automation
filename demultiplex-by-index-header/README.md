# demultiplex-by-index-header

Command-line:
nohup ./main.sh -w /folderpath -h dmx -p <parallel runs> -j <projectID> -a Undetermined-R1.fastq.gz -b Undetermined-R2.fastq.gz -s SampleSheet.csv -l <barcode length> -m <mismatch> -k <index type> > /folderpath/<ProjectID>.log.out 2>&1 & <br>

Example:



Arguments: <br>
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

Note: The name of log.out file should to the same as project folder name.  For example, if the project folder name is 22167-01, then the log.out file will be 22167-01.log.out.

FastQ files will be generated in the “fastq” folder under the project folder.

Other files that will also be generated under the project folder: <br>
mm1.txt – Variation of Index 1 <br>
mm2.txt – Variation of Index 2 <br>
samplelist.txt – List containing samples and barcodes from the samplesheet <br>
runtime.txt – Total run time of the script. <br>
