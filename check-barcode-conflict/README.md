# Check for Barcode Conflict v1.0 (Linux version)

## Command-line
python3 check-barcode.py <samplesheet.csv> <br>

## Introduction
Correct barcodes are necessary to generate meaningful sequencing results.  This script checks for conflicting barcodes that allows one mismatched base or only exact matches.  Variable barcode length and mismatch can be assessed in this script. <br>

**Output File**
mismatch0.txt: contains a list of samples with conflicting barcodes with exact match <br>
mismatch1.txt: contains a list of samples with conflictiong barcodes with mismatch = 1 <br>


