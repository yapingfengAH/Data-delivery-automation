#!/bin/bash

#### version 1.1
#################################################################################
R2=$1
index1=$2
index2=$3
output=$4
samplename=$5
type=$6

#################################################################################
if(($type == 2)); then
LC_ALL=C zcat $R2 | fgrep --no-group-separator -A3 $index1 | fgrep --no-group-separator -A3 $index2 | gzip > $output/${samplename}_S1001_L100_R2_100.fastq.gz
fi

if(($type == 1)); then
LC_ALL=C zcat $R2 | fgrep --no-group-separator -A3 $index1 | gzip > $output/${samplename}_S1001_L100_R2_100.fastq.gz
fi

