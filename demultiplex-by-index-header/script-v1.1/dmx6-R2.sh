#!/bin/bash

#### version 1.1
#################################################################################
R2=$1
index1=$2
index2=$3
pattern1=$4
pattern2=$5
pattern3=$6
pattern4=$7
pattern5=$8
pattern6=$9
pattern7=${10}
pattern8=${11}
pattern9=${12}
pattern10=${13}
pattern11=${14}
pattern12=${15}
output=${16}
samplename=${17}
type=${18}

#################################################################################
#echo "R2 = $R2"
#echo "index1 = $index1"
#echo "index2 = $index2"
#echo "pattern1 = $pattern1"
#echo "pattern2 = $pattern2"
#echo "pattern3 = $pattern3"
#echo "pattern4 = $pattern4"
#echo "pattern5 = $pattern5"
#echo "pattern6 = $pattern6"
#echo "pattern7 = $pattern7"
#echo "pattern8 = $pattern8"
#echo "pattern9 = $pattern9"
#echo "pattern10 = $pattern10"
#echo "pattern11 = $pattern11"
#echo "pattern12 = $pattern12"
#echo "type = $type"
#echo "sample name = $samplename"
#echo "output = $output"
#echo "combined pattern1 = "${pattern1}.*${index2}

#################################################################################
if(($type == 2)); then

LC_ALL=C zcat $R2 | grep --no-group-separator -A3 "${pattern1}.*${pattern7}\|${pattern2}.*${pattern7}\|${pattern3}.*${pattern7}\|${pattern4}.*${pattern7}\|${pattern5}.*${pattern7}\|${pattern6}.*${pattern7}\|${pattern1}.*${pattern8}\|${pattern2}.*${pattern8}\|${pattern3}.*${pattern8}\|${pattern4}.*${pattern8}\|${pattern5}.*${pattern8}\|${pattern6}.*${pattern8}\|${pattern1}.*${pattern9}\|${pattern2}.*${pattern9}\|${pattern3}.*${pattern9}\|${pattern4}.*${pattern9}\|${pattern5}.*${pattern9}\|${pattern6}.*${pattern9}\|${pattern1}.*${pattern10}\|${pattern2}.*${pattern10}\|${pattern3}.*${pattern10}\|${pattern4}.*${pattern10}\|${pattern5}.*${pattern10}\|${pattern6}.*${pattern10}\|${pattern1}.*${pattern11}\|${pattern2}.*${pattern11}\|${pattern3}.*${pattern11}\|${pattern4}.*${pattern11}\|${pattern5}.*${pattern11}\|${pattern6}.*${pattern11}\|${pattern1}.*${pattern12}\|${pattern2}.*${pattern12}\|${pattern3}.*${pattern12}\|${pattern4}.*${pattern12}\|${pattern5}.*${pattern12}\|${pattern6}.*${pattern12}\|${pattern1}.*${pattern7}\|${pattern1}.*${pattern8}\|${pattern1}.*${pattern9}\|${pattern1}.*${pattern10}\|${pattern1}.*${pattern11}\|${pattern1}.*${pattern12}\|${pattern2}.*${pattern7}\|${pattern2}.*${pattern8}\|${pattern2}.*${pattern9}\|${pattern2}.*${pattern10}\|${pattern2}.*${pattern11}\|${pattern2}.*${pattern12}\|${pattern3}.*${pattern7}\|${pattern3}.*${pattern8}\|${pattern3}.*${pattern9}\|${pattern3}.*${pattern10}\|${pattern3}.*${pattern11}\|${pattern3}.*${pattern12}\|${pattern4}.*${pattern7}\|${pattern4}.*${pattern8}\|${pattern4}.*${pattern9}\|${pattern4}.*${pattern10}\|${pattern4}.*${pattern11}\|${pattern4}.*${pattern12}\|${pattern5}.*${pattern7}\|${pattern5}.*${pattern8}\|${pattern5}.*${pattern9}\|${pattern5}.*${pattern10}\|${pattern5}.*${pattern11}\|${pattern5}.*${pattern12}\|${pattern6}.*${pattern7}\|${pattern6}.*${pattern8}\|${pattern6}.*${pattern9}\|${pattern6}.*${pattern10}\|${pattern6}.*${pattern11}\|${pattern6}.*${pattern12}" | gzip > $output/${samplename}_S1001_L100_R2_100.fastq.gz

fi

if(($type == 1)); then
LC_ALL=C zcat $R2 | grep --no-group-separator -A3 "${pattern1}\|${pattern2}\|${pattern3}\|${pattern4}\|${pattern5}\|${pattern6}" | gzip > $output/${samplename[$i]}_S100_L000_R2_100.fastq.gz
fi
