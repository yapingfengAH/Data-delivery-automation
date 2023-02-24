# Check for Barcode Conflict v1.0 (Linux version)

## Command-line
nohup python3 check-barcode.py <samplesheet.csv> > test.log.out 2>&1 & <br>

**Output File** <br>
mismatch0.txt: contains a list of conflicting barcode sample(s) with exact match <br>
mismatch1.txt: contains a list of conflicting-barcode sample(s) with mismatch = 1 <br>
a log.out file generated from nohup

## Introduction
Correct barcodes are necessary to generate meaningful sequencing results.  This script checks for conflicting barcodes that allows one mismatched base or only exact matches.  Variable barcode length and mismatch can be assessed in this script. <br>

## Requirement

**Requried Script** <br>
• check-barcode.py <br>

**Programming Language** <br>
• Python <br>

