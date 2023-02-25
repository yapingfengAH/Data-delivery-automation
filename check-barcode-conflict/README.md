# Check for Barcode Conflict v1.0 (Linux version)

## Command-line
nohup python3 check-barcode.py <samplesheet.csv> > filename.log.out 2>&1 & <br>

**Output File** <br>
mismatch0.txt: contains a list of conflicting barcode sample(s) with exact match if presented <br>
mismatch1.txt: contains a list of conflicting-barcode sample(s) with mismatch = 1 if presented <br>
a log.out file generated from nohup

## Introduction
Correct barcodes are necessary to generate meaningful sequencing results.  This script checks for conflicting barcodes that allows one mismatched base or only exact matches.  Variable barcode length and mismatch (0 or 1) condition can be assessed in this script. <br>

## Requirement
**Requried Script** <br>
• check-barcode.py <br>
• samplesheet.csv <br>

**Programming Language** <br>
• Python <br>

**Note** <br>
For sample with single index, a string of "G" is used as a place-holder index in the "index2" column of the samplesheet.  For example, for sample with a barcode length of 6, the place-holder index is "GGGGGG".

