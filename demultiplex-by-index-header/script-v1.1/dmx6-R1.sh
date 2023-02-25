#!/bin/bash

################################################################################################################
#  Author     : Wei Chun (John) Chen
#  E-mail     : weichun.chen@admerahealth.com
#  Date       : 2/13/2023
#  Description: Split undetermined reads by index header

#### version 1.1
#################################################################################
R1=$1
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
if(($type == 2)); then

LC_ALL=C zcat $R1 | grep --no-group-separator -A3 "${pattern1}.*${pattern7}\|${pattern2}.*${pattern7}\|${pattern3}.*${pattern7}\|${pattern4}.*${pattern7}\|${pattern5}.*${pattern7}\|${pattern6}.*${pattern7}\|${pattern1}.*${pattern8}\|${pattern2}.*${pattern8}\|${pattern3}.*${pattern8}\|${pattern4}.*${pattern8}\|${pattern5}.*${pattern8}\|${pattern6}.*${pattern8}\|${pattern1}.*${pattern9}\|${pattern2}.*${pattern9}\|${pattern3}.*${pattern9}\|${pattern4}.*${pattern9}\|${pattern5}.*${pattern9}\|${pattern6}.*${pattern9}\|${pattern1}.*${pattern10}\|${pattern2}.*${pattern10}\|${pattern3}.*${pattern10}\|${pattern4}.*${pattern10}\|${pattern5}.*${pattern10}\|${pattern6}.*${pattern10}\|${pattern1}.*${pattern11}\|${pattern2}.*${pattern11}\|${pattern3}.*${pattern11}\|${pattern4}.*${pattern11}\|${pattern5}.*${pattern11}\|${pattern6}.*${pattern11}\|${pattern1}.*${pattern12}\|${pattern2}.*${pattern12}\|${pattern3}.*${pattern12}\|${pattern4}.*${pattern12}\|${pattern5}.*${pattern12}\|${pattern6}.*${pattern12}\|${pattern1}.*${pattern7}\|${pattern1}.*${pattern8}\|${pattern1}.*${pattern9}\|${pattern1}.*${pattern10}\|${pattern1}.*${pattern11}\|${pattern1}.*${pattern12}\|${pattern2}.*${pattern7}\|${pattern2}.*${pattern8}\|${pattern2}.*${pattern9}\|${pattern2}.*${pattern10}\|${pattern2}.*${pattern11}\|${pattern2}.*${pattern12}\|${pattern3}.*${pattern7}\|${pattern3}.*${pattern8}\|${pattern3}.*${pattern9}\|${pattern3}.*${pattern10}\|${pattern3}.*${pattern11}\|${pattern3}.*${pattern12}\|${pattern4}.*${pattern7}\|${pattern4}.*${pattern8}\|${pattern4}.*${pattern9}\|${pattern4}.*${pattern10}\|${pattern4}.*${pattern11}\|${pattern4}.*${pattern12}\|${pattern5}.*${pattern7}\|${pattern5}.*${pattern8}\|${pattern5}.*${pattern9}\|${pattern5}.*${pattern10}\|${pattern5}.*${pattern11}\|${pattern5}.*${pattern12}\|${pattern6}.*${pattern7}\|${pattern6}.*${pattern8}\|${pattern6}.*${pattern9}\|${pattern6}.*${pattern10}\|${pattern6}.*${pattern11}\|${pattern6}.*${pattern12}" | gzip > $output/${samplename}_S1001_L100_R1_100.fastq.gz

fi

if(($type == 1)); then
LC_ALL=C zcat $R1 | grep --no-group-separator -A3 "${pattern1}\|${pattern2}\|${pattern3}\|${pattern4}\|${pattern5}\|${pattern6}" | gzip > $output/${samplename[$i]}_S100_L000_R1_100.fastq.gz
fi

