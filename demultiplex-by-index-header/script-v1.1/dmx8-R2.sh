#!/bin/bash

################################################################################################################
#  Author     : Wei Chun (John) Chen
#  E-mail     : weichun.chen@admerahealth.com
#  Date       : 2/13/2023
#  Description: Split undetermined reads by index header

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
pattern13=${16}
pattern14=${17}
pattern15=${18}
pattern16=${19}
output=${20}
samplename=${21}
type=${22}

#################################################################################
if(($type == 2)); then

LC_ALL=C zcat $R2 | grep --no-group-separator -A3 "${pattern1}.*${pattern9}\|${pattern2}.*${pattern9}\|${pattern3}.*${pattern9}\|${pattern4}.*${pattern9}\|${pattern5}.*${pattern9}\|${pattern6}.*${pattern9}\|${pattern7}.*${pattern9}\|${pattern8}.*${pattern9}\|${pattern1}.*${pattern10}\|${pattern2}.*${pattern10}\|${pattern3}.*${pattern10}\|${pattern4}.*${pattern10}\|${pattern5}.*${pattern10}\|${pattern6}.*${pattern10}\|${pattern7}.*${pattern10}\|${pattern8}.*${pattern10}\|${pattern1}.*${pattern11}\|${pattern2}.*${pattern11}\|${pattern3}.*${pattern11}\|${pattern4}.*${pattern11}\|${pattern5}.*${pattern11}\|${pattern6}.*${pattern11}\|${pattern7}.*${pattern11}\|${pattern8}.*${pattern11}\|${pattern1}.*${pattern12}\|${pattern2}.*${pattern12}\|${pattern3}.*${pattern12}\|${pattern4}.*${pattern12}\|${pattern5}.*${pattern12}\|${pattern6}.*${pattern12}\|${pattern7}.*${pattern12}\|${pattern8}.*${pattern12}\|${pattern1}.*${pattern13}\|${pattern2}.*${pattern13}\|${pattern3}.*${pattern13}\|${pattern4}.*${pattern13}\|${pattern5}.*${pattern13}\|${pattern6}.*${pattern13}\|${pattern7}.*${pattern13}\|${pattern8}.*${pattern13}\|${pattern1}.*${pattern14}\|${pattern2}.*${pattern14}\|${pattern3}.*${pattern14}\|${pattern4}.*${pattern14}\|${pattern5}.*${pattern14}\|${pattern6}.*${pattern14}\|${pattern7}.*${pattern14}\|${pattern8}.*${pattern14}\|${pattern1}.*${pattern15}\|${pattern2}.*${pattern15}\|${pattern3}.*${pattern15}\|${pattern4}.*${pattern15}\|${pattern5}.*${pattern15}\|${pattern6}.*${pattern15}\|${pattern7}.*${pattern15}\|${pattern8}.*${pattern15}\|${pattern1}.*${pattern16}\|${pattern2}.*${pattern16}\|${pattern3}.*${pattern16}\|${pattern4}.*${pattern16}\|${pattern5}.*${pattern16}\|${pattern6}.*${pattern16}\|${pattern7}.*${pattern16}\|${pattern8}.*${pattern16}\|${pattern1}.*${pattern9}\|${pattern1}.*${pattern10}\|${pattern1}.*${pattern11}\|${pattern1}.*${pattern12}\|${pattern1}.*${pattern13}\|${pattern1}.*${pattern14}\|${pattern1}.*${pattern15}\|${pattern1}.*${pattern16}\|${pattern2}.*${pattern9}\|${pattern2}.*${pattern10}\|${pattern2}.*${pattern11}\|${pattern2}.*${pattern12}\|${pattern2}.*${pattern13}\|${pattern2}.*${pattern14}\|${pattern2}.*${pattern15}\|${pattern2}.*${pattern16}\|${pattern3}.*${pattern9}\|${pattern3}.*${pattern10}\|${pattern3}.*${pattern11}\|${pattern3}.*${pattern12}\|${pattern3}.*${pattern13}\|${pattern3}.*${pattern14}\|${pattern3}.*${pattern15}\|${pattern3}.*${pattern16}\|${pattern4}.*${pattern9}\|${pattern4}.*${pattern10}\|${pattern4}.*${pattern11}\|${pattern4}.*${pattern12}\|${pattern4}.*${pattern13}\|${pattern4}.*${pattern14}\|${pattern4}.*${pattern15}\|${pattern4}.*${pattern16}\|${pattern5}.*${pattern9}\|${pattern5}.*${pattern10}\|${pattern5}.*${pattern11}\|${pattern5}.*${pattern12}\|${pattern5}.*${pattern13}\|${pattern5}.*${pattern14}\|${pattern5}.*${pattern15}\|${pattern5}.*${pattern16}\|${pattern6}.*${pattern9}\|${pattern6}.*${pattern10}\|${pattern6}.*${pattern11}\|${pattern6}.*${pattern12}\|${pattern6}.*${pattern13}\|${pattern6}.*${pattern14}\|${pattern6}.*${pattern15}\|${pattern6}.*${pattern16}\|${pattern7}.*${pattern9}\|${pattern7}.*${pattern10}\|${pattern7}.*${pattern11}\|${pattern7}.*${pattern12}\|${pattern7}.*${pattern13}\|${pattern7}.*${pattern14}\|${pattern7}.*${pattern15}\|${pattern7}.*${pattern16}\|${pattern8}.*${pattern9}\|${pattern8}.*${pattern10}\|${pattern8}.*${pattern11}\|${pattern8}.*${pattern12}\|${pattern8}.*${pattern13}\|${pattern8}.*${pattern14}\|${pattern8}.*${pattern15}\|${pattern8}.*${pattern16}" | gzip > $output/${samplename}_S1001_L100_R2_100.fastq.gz

fi

if(($type == 1)); then
LC_ALL=C zcat $R2 | grep --no-group-separator -A3 "${pattern1}\|${pattern2}\|${pattern3}\|${pattern4}\|${pattern5}\|${pattern6}\|${pattern7}\|${pattern8}" | gzip > $output/${samplename[$i]}_S100_L000_R2_100.fastq.gz
fi

