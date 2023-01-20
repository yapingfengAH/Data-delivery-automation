# demultiplex-by-index-header

Command-line:



Example:



Arguments: <br>
-w  Working directory path <br>
-h  Script ID for matching job ID (please use “dmx” as default)
-p  Max number of parallel runs (10 as default, may use more)
-j Project folder name (same name as log.out file)
-a  Undetermined reads R1: fastq.gz file
-b  Undetermined reads R2: fastq.gz file
-s  Samplesheet: csv file
-l  Barcode length:  6; 8; 10
-m  Mismatch:  0 = no mismatch;  1 = one mismatch
-k  Index type:  1 = single index;  2 = dual indexes

Note: The name of log.out file should to the same as project folder name.  For example, if the project folder name is 22167-01, then the log.out file will be 22167-01.log.out.

FastQ files will be generated in the “fastq” folder under the project folder.

Other files that will also be generated under the project folder:
mm1.txt – Variation of Index 1
mm2.txt – Variation of Index 2
samplelist.txt – List containing samples and barcodes from the samplesheet
runtime.txt – Total run time of the script.

