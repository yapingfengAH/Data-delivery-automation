#!/bin/bash

################################################################################# command line
##### Demultiplex
##### example: nohup ./main.sh -w /fast-data/BI/RUO_wchen/test/demultiplex-v1.1 -h dmx -p 20 -j 22167-01 -a /fast-data/BI/RUO_wchen/FastQ/undetermined-reads/Undetermined-121922-x-fc1_S0_L004_R1_001.fastq.gz -b /fast-data/BI/RUO_wchen/FastQ/undetermined-reads/Undetermined-121922-x-fc1_S0_L004_R2_001.fastq.gz -s /fast-data/BI/RUO_wchen/samplesheet/SampleSheet-121922-x-fc1-L04.csv -l 6 -m 1 -k 2 > /fast-data/BI/RUO_wchen/test/demultiplex-v1.1/22167-01.log.out 2>&1 &

################################################################################## calculate time
start=$(date +%s%N)

################################################################################## parse arguments
while getopts w:h:p:j:a:b:s:l:m:k: flag
do
case "${flag}" in
w) workdir="${OPTARG}";;
h) nohupid="${OPTARG}";;
p) parallel_run="${OPTARG}";;
j) project_folder="${OPTARG}";;
a) R1="${OPTARG}";;
b) R2="${OPTARG}";;
s) samplesheet="${OPTARG}";;
l) barcode_length="${OPTARG}";;
m) mismatch="${OPTARG}";;
k) type="${OPTARG}";;
esac
done

#echo "Working directory: $workdir" # working directory where scripts are located
#echo "nohup ID: $nohupid" # an abbreviated ID for the sh files displayed in jobs
#echo "Parallel runs: $parallel_run # max number of parallels running at the same time
#echo "Project folder name: $project_folder" # project folder name
#echo "Read 1: $R1" # undetermined read 1
#echo "Read 2: $R2" # undetermined read 2
#echo "Samplesheet: $samplesheet"; # csv file
#echo "Length of barcode: $barcode_length"; # number of nucleotides for barcode
#echo "Number of mismatch: $mismatch" # 0 or 1
#echo "Type of index: $type" # 1 = single or 2 = duel

############################################################################################################### function
function can_run_new_nohup(){
    #### To find how many specific nohup are running at the same time

    local _set_p_run=$1
    local _nohup_id=$2
	#echo $_nohup_id
	local _current_run=($(ps | grep -P "$_nohup_id" | wc -l))
	#echo $_current_run

	if [[ $_current_run -lt $_set_p_run ]]
	then
	    echo 1
	else
	    echo 0
	fi
}

############################################################################################################### create output directory
cd $workdir

if [ -d "$workdir/$project_folder" ]; then
echo "Directory already exists."
else
mkdir $project_folder
fi

cd $workdir/$project_folder
if [ -d "$workdir/$project_folder/fastq" ]; then
echo "Directory already exists."
else
mkdir fastq
fi

############################################################################################################### extract information from samplesheet
cd $workdir

echo "Length of barcodes: $barcode_length"
echo "Number of mismatch: $mismatch"

python3 convert2txt.py $samplesheet
rm temp.csv
mv mm1.txt $workdir/$project_folder/
mv mm2.txt $workdir/$project_folder/
mv samplelist.txt $workdir/$project_folder/

echo "Created a txt file containing variation of Index 1: mm1.txt"
echo "Created a txt file containing variation of Index 2: mm2.txt"
echo "Created a txt file containing sample and barcode list: samplelist.txt"
echo "Moved mm1.txt, mm2.txt, and samplelist.txt to the project folder."

############################################################################################################### build array
list=()
read -r -d '' -a array < "$workdir/$project_folder/samplelist.txt"
for ((i=0; i<${#array[@]}; i++)); do
list+=("${array[$i]}")
done
echo "Sample list: ${list[@]}"
#echo ${list[1]}
echo "length of sample list: ${#list[@]}"
len=$((${#list[@]}/3))
echo "number of total samples: $len"

number=()
for ((i=0; i<$len; i++)); do
number+=("$i")
done
echo "${number[@]}"


mm1=() # i7 barcodes for mismatch
read -r -d '' -a array < "$workdir/$project_folder/mm1.txt"
for ((i=0; i<${#array[@]}; i++)); do
mm1+=("${array[$i]}")
done
echo "Variation of Index 1: ${mm1[@]}"
mm2=() # i5 barcodes for mismatch
read -r -d '' -a array < "$workdir/$project_folder/mm2.txt"
for ((i=0; i<${#array[@]}; i++)); do
mm2+=("${array[$i]}")
done
echo "Variation of Index 2: ${mm2[@]}"

#sample=()
#n=0
#for ((i=0; i<$len; i++)); do
#sample+=("${list[$n]}")
#n=$((n + 3))
#done
#echo "sample name: ${sample[@]}"
#
#read1=()
#for file in `ls $workdir/$project_folder/*R1*.fastq.gz`
#do
#   #echo $file
#   read1+=($file)
#done
#echo "Read1 files: ${read1[@]}"
#
#read2=()
#for file in `ls $workdir/$project_folder/*R2*.fastq.gz`
#do
#   #echo $file
#   read2+=($file)
#done
#echo "Read2 files: ${read2[@]}"
#
#read=()
#for file in `ls $workdir/$project_folder/*.fastq.gz`
#do
#   #echo $file
#   read+=($file)
#done
#echo "Read files in working directory: ${read[@]}"
#_len=$((${#read[@]}))
#echo "number of total samples: $_len"

############################################################################################################### start demultiplex
############################################################################################################### mismatch = 0
if(($mismatch == 0)); then
COUNT=0
for ((i=0; i<${#number[@]}; i++)); do
echo "number: ${number[i]}"
echo "start COUNT: $COUNT"
#echo ${read1[$i]}
#echo ${read2[$i]}

while true ### parallel
do
run_nohup_flag=($(can_run_new_nohup $parallel_run $nohupid))
if [[ $run_nohup_flag -eq 1 ]]
then
break
fi
sleep 60s
done

if(($barcode_length == 6)); then

if(($type == 2)); then
nohup ./dmx0-R1.sh $R1 ${list[$COUNT + 1]} ${list[$COUNT + 2]} $workdir/$project_folder/fastq ${list[$COUNT]} 2 &

nohup ./dmx0-R2.sh $R2 ${list[$COUNT + 1]} ${list[$COUNT + 2]} $workdir/$project_folder/fastq ${list[$COUNT]} 2 &
echo ${list[$COUNT]}
echo ${list[$COUNT + 1]}
echo ${list[$COUNT + 2]}
sleep 30s
ps
fi

if(($type == 1)); then ### for single index, please fill the space of second index as a place holder-index in the samplesheet
nohup ./dmx0-R1.sh $R1 ${list[$COUNT + 1]} ${list[$COUNT + 2]} $workdir/$project_folder/fastq ${list[$COUNT]} 1 &

nohup ./dmx0-R2.sh $R2 ${list[$COUNT + 1]} ${list[$COUNT + 2]} $workdir/$project_folder/fastq ${list[$COUNT]} 1 &
echo ${list[$COUNT]}
echo ${list[$COUNT + 1]}
echo ${list[$COUNT + 2]}
sleep 30s
ps
fi
fi

if(($barcode_length == 8)); then

if(($type == 2)); then
nohup ./dmx0-R1.sh $R1 ${list[$COUNT + 1]} ${list[$COUNT + 2]} $workdir/$project_folder/fastq ${list[$COUNT]} 2 &

nohup ./dmx0-R2.sh $R2 ${list[$COUNT + 1]} ${list[$COUNT + 2]} $workdir/$project_folder/fastq ${list[$COUNT]} 2 &
echo ${list[$COUNT]}
echo ${list[$COUNT + 1]}
echo ${list[$COUNT + 2]}
sleep 30s
ps
fi

if(($type == 1)); then
nohup ./dmx0-R1.sh $R1 ${list[$COUNT + 1]} ${list[$COUNT + 2]} $workdir/$project_folder/fastq ${list[$COUNT]} 1 &

nohup ./dmx0-R2.sh $R2 ${list[$COUNT + 1]} ${list[$COUNT + 2]} $workdir/$project_folder/fastq ${list[$COUNT]} 1 &
echo ${list[$COUNT]}
echo ${list[$COUNT + 1]}
echo ${list[$COUNT + 2]}
sleep 30s
ps
fi
fi

if(($barcode_length == 10)); then

if(($type == 2)); then
nohup ./dmx0-R1.sh $R1 ${list[$COUNT + 1]} ${list[$COUNT + 2]} $workdir/$project_folder/fastq ${list[$COUNT]} 2 &

nohup ./dmx0-R2.sh $R2 ${list[$COUNT + 1]} ${list[$COUNT + 2]} $workdir/$project_folder/fastq ${list[$COUNT]} 2 &
echo ${list[$COUNT]}
echo ${list[$COUNT + 1]}
echo ${list[$COUNT + 2]}
sleep 30s
ps
fi

if(($type == 1)); then
nohup ./dmx0-R1.sh $R1 ${list[$COUNT + 1]} ${list[$COUNT + 2]} $workdir/$project_folder/fastq ${list[$COUNT]} 1 &

nohup ./dmx0-R2.sh $R2 ${list[$COUNT + 1]} ${list[$COUNT + 2]} $workdir/$project_folder/fastq ${list[$COUNT]} 1 &
echo ${list[$COUNT]}
echo ${list[$COUNT + 1]}
echo ${list[$COUNT + 2]}
sleep 30s
ps
fi
fi

COUNT=$((COUNT + 3))
echo "end COUNT: $COUNT"

done
fi

############################################################################################################### mismatch = 1
if(($mismatch == 1)); then
COUNT=0
COUNTER=0
for ((i=0; i<${#number[@]}; i++)); do
echo "number: ${number[i]}"
echo "start COUNT: $COUNT"
echo "start COUNTER: $COUNTER"

while true ### parallel
do
run_nohup_flag=($(can_run_new_nohup $parallel_run $nohupid))
if [[ $run_nohup_flag -eq 1 ]]
then
break
fi
sleep 60s
done

if(($barcode_length == 6)); then

if(($type == 2)); then
nohup ./dmx6-R1.sh $R1 ${list[$COUNT + 1]} ${list[$COUNT + 2]} ${mm1[$COUNTER]} ${mm1[$COUNTER + 1]} ${mm1[$COUNTER + 2]} ${mm1[$COUNTER + 3]} ${mm1[$COUNTER + 4]} ${mm1[$COUNTER + 5]} ${mm2[$COUNTER]} ${mm2[$COUNTER + 1]} ${mm2[$COUNTER + 2]} ${mm2[$COUNTER + 3]} ${mm2[$COUNTER + 4]} ${mm2[$COUNTER + 5]} $workdir/$project_folder/fastq ${list[$COUNT]} 2 &

nohup ./dmx6-R2.sh $R2 ${list[$COUNT + 1]} ${list[$COUNT + 2]} ${mm1[$COUNTER]} ${mm1[$COUNTER + 1]} ${mm1[$COUNTER + 2]} ${mm1[$COUNTER + 3]} ${mm1[$COUNTER + 4]} ${mm1[$COUNTER + 5]} ${mm2[$COUNTER]} ${mm2[$COUNTER + 1]} ${mm2[$COUNTER + 2]} ${mm2[$COUNTER + 3]} ${mm2[$COUNTER + 4]} ${mm2[$COUNTER + 5]} $workdir/$project_folder/fastq ${list[$COUNT]} 2 &
echo ${list[$COUNT]}
echo ${list[$COUNT + 1]}
echo ${list[$COUNT + 2]}
echo "Index 1: ${mm1[$COUNTER]}"
echo "Index 2: ${mm2[$COUNTER]}"
sleep 30s
ps
fi

if(($type == 1)); then
nohup ./dmx6-R1.sh $R1 ${list[$COUNT + 1]} ${list[$COUNT + 2]} ${mm1[$COUNTER]} ${mm1[$COUNTER + 1]} ${mm1[$COUNTER + 2]} ${mm1[$COUNTER + 3]} ${mm1[$COUNTER + 4]} ${mm1[$COUNTER + 5]} ${mm2[$COUNTER]} ${mm2[$COUNTER + 1]} ${mm2[$COUNTER + 2]} ${mm2[$COUNTER + 3]} ${mm2[$COUNTER + 4]} ${mm2[$COUNTER + 5]} $workdir/$project_folder/fastq ${list[$COUNT]} 1 &

nohup ./dmx6-R2.sh $R2 ${list[$COUNT + 1]} ${list[$COUNT + 2]} ${mm1[$COUNTER]} ${mm1[$COUNTER + 1]} ${mm1[$COUNTER + 2]} ${mm1[$COUNTER + 3]} ${mm1[$COUNTER + 4]} ${mm1[$COUNTER + 5]} ${mm2[$COUNTER]} ${mm2[$COUNTER + 1]} ${mm2[$COUNTER + 2]} ${mm2[$COUNTER + 3]} ${mm2[$COUNTER + 4]} ${mm2[$COUNTER + 5]} $workdir/$project_folder/fastq ${list[$COUNT]} 1 &
echo ${list[$COUNT]}
echo ${list[$COUNT + 1]}
echo ${list[$COUNT + 2]}
sleep 30s
ps
fi
fi

if(($barcode_length == 8)); then

if(($type == 2)); then
nohup ./dmx8-R1.sh $R1 ${list[$COUNT + 1]} ${list[$COUNT + 2]} ${mm1[$COUNTER]} ${mm1[$COUNTER + 1]} ${mm1[$COUNTER + 2]} ${mm1[$COUNTER + 3]} ${mm1[$COUNTER + 4]} ${mm1[$COUNTER + 5]} ${mm1[$COUNTER + 6]} ${mm1[$COUNTER + 7]} ${mm2[$COUNTER]} ${mm2[$COUNTER + 1]} ${mm2[$COUNTER + 2]} ${mm2[$COUNTER + 3]} ${mm2[$COUNTER + 4]} ${mm2[$COUNTER + 5]} ${mm2[$COUNTER + 6]} ${mm2[$COUNTER + 7]} $workdir/$project_folder/fastq ${list[$COUNT]} 2 &

nohup ./dmx8-R2.sh $R2 ${list[$COUNT + 1]} ${list[$COUNT + 2]} ${mm1[$COUNTER]} ${mm1[$COUNTER + 1]} ${mm1[$COUNTER + 2]} ${mm1[$COUNTER + 3]} ${mm1[$COUNTER + 4]} ${mm1[$COUNTER + 5]} ${mm1[$COUNTER + 6]} ${mm1[$COUNTER + 7]} ${mm2[$COUNTER]} ${mm2[$COUNTER + 1]} ${mm2[$COUNTER + 2]} ${mm2[$COUNTER + 3]} ${mm2[$COUNTER + 4]} ${mm2[$COUNTER + 5]} ${mm2[$COUNTER + 6]} ${mm2[$COUNTER + 7]} $workdir/$project_folder/fastq ${list[$COUNT]} 2 &
echo ${list[$COUNT]}
echo ${list[$COUNT + 1]}
echo ${list[$COUNT + 2]}
echo "Index 1: ${mm1[$COUNTER]}"
echo "Index 2: ${mm2[$COUNTER]}"
sleep 30s
ps
fi

if(($type == 1)); then
nohup ./dmx8-R1.sh $R1 ${list[$COUNT + 1]} ${list[$COUNT + 2]} ${mm1[$COUNTER]} ${mm1[$COUNTER + 1]} ${mm1[$COUNTER + 2]} ${mm1[$COUNTER + 3]} ${mm1[$COUNTER + 4]} ${mm1[$COUNTER + 5]} ${mm1[$COUNTER + 6]} ${mm1[$COUNTER + 7]} ${mm2[$COUNTER]} ${mm2[$COUNTER + 1]} ${mm2[$COUNTER + 2]} ${mm2[$COUNTER + 3]} ${mm2[$COUNTER + 4]} ${mm2[$COUNTER + 5]} ${mm2[$COUNTER + 6]} ${mm2[$COUNTER + 7]} $workdir/$project_folder/fastq ${list[$COUNT]} 1 &

nohup ./dmx8-R2.sh $R2 ${list[$COUNT + 1]} ${list[$COUNT + 2]} ${mm1[$COUNTER]} ${mm1[$COUNTER + 1]} ${mm1[$COUNTER + 2]} ${mm1[$COUNTER + 3]} ${mm1[$COUNTER + 4]} ${mm1[$COUNTER + 5]} ${mm1[$COUNTER + 6]} ${mm1[$COUNTER + 7]} ${mm2[$COUNTER]} ${mm2[$COUNTER + 1]} ${mm2[$COUNTER + 2]} ${mm2[$COUNTER + 3]} ${mm2[$COUNTER + 4]} ${mm2[$COUNTER + 5]} ${mm2[$COUNTER + 6]} ${mm2[$COUNTER + 7]} $workdir/$project_folder/fastq ${list[$COUNT]} 1 &
echo ${list[$COUNT]}
echo ${list[$COUNT + 1]}
echo ${list[$COUNT + 2]}
sleep 30s
ps
fi
fi

if(($barcode_length == 10)); then

if(($type == 2)); then
nohup ./dmx10-R1.sh $R1 ${list[$COUNT + 1]} ${list[$COUNT + 2]} ${mm1[$COUNTER]} ${mm1[$COUNTER + 1]} ${mm1[$COUNTER + 2]} ${mm1[$COUNTER + 3]} ${mm1[$COUNTER + 4]} ${mm1[$COUNTER + 5]} ${mm1[$COUNTER + 6]} ${mm1[$COUNTER + 7]} ${mm1[$COUNTER + 8]} ${mm1[$COUNTER + 9]} ${mm2[$COUNTER]} ${mm2[$COUNTER + 1]} ${mm2[$COUNTER + 2]} ${mm2[$COUNTER + 3]} ${mm2[$COUNTER + 4]} ${mm2[$COUNTER + 5]} ${mm2[$COUNTER + 6]} ${mm2[$COUNTER + 7]} ${mm2[$COUNTER + 8]} ${mm2[$COUNTER + 9]} $workdir/$project_folder/fastq ${list[$COUNT]} 2 &

nohup ./dmx10-R2.sh $R2 ${list[$COUNT + 1]} ${list[$COUNT + 2]} ${mm1[$COUNTER]} ${mm1[$COUNTER + 1]} ${mm1[$COUNTER + 2]} ${mm1[$COUNTER + 3]} ${mm1[$COUNTER + 4]} ${mm1[$COUNTER + 5]} ${mm1[$COUNTER + 6]} ${mm1[$COUNTER + 7]} ${mm1[$COUNTER + 8]} ${mm1[$COUNTER + 9]} ${mm2[$COUNTER]} ${mm2[$COUNTER + 1]} ${mm2[$COUNTER + 2]} ${mm2[$COUNTER + 3]} ${mm2[$COUNTER + 4]} ${mm2[$COUNTER + 5]} ${mm2[$COUNTER + 6]} ${mm2[$COUNTER + 7]} ${mm2[$COUNTER + 8]} ${mm2[$COUNTER + 9]} $workdir/$project_folder/fastq ${list[$COUNT]} 2 &
echo ${list[$COUNT]}
echo ${list[$COUNT + 1]}
echo ${list[$COUNT + 2]}
echo "Index 1: ${mm1[$COUNTER]}"
echo "Index 2: ${mm2[$COUNTER]}"
sleep 30s
ps
fi

if(($type == 1)); then
nohup ./dmx10-R1.sh $R1 ${list[$COUNT + 1]} ${list[$COUNT + 2]} ${mm1[$COUNTER]} ${mm1[$COUNTER + 1]} ${mm1[$COUNTER + 2]} ${mm1[$COUNTER + 3]} ${mm1[$COUNTER + 4]} ${mm1[$COUNTER + 5]} ${mm1[$COUNTER + 6]} ${mm1[$COUNTER + 7]} ${mm1[$COUNTER + 8]} ${mm1[$COUNTER + 9]} ${mm2[$COUNTER]} ${mm2[$COUNTER + 1]} ${mm2[$COUNTER + 2]} ${mm2[$COUNTER + 3]} ${mm2[$COUNTER + 4]} ${mm2[$COUNTER + 5]} ${mm2[$COUNTER + 6]} ${mm2[$COUNTER + 7]} ${mm2[$COUNTER + 8]} ${mm2[$COUNTER + 9]} $workdir/$project_folder/fastq ${list[$COUNT]} 1 &

nohup ./dmx10-R2.sh $R2 ${list[$COUNT + 1]} ${list[$COUNT + 2]} ${mm1[$COUNTER]} ${mm1[$COUNTER + 1]} ${mm1[$COUNTER + 2]} ${mm1[$COUNTER + 3]} ${mm1[$COUNTER + 4]} ${mm1[$COUNTER + 5]} ${mm1[$COUNTER + 6]} ${mm1[$COUNTER + 7]} ${mm1[$COUNTER + 8]} ${mm1[$COUNTER + 9]} ${mm2[$COUNTER]} ${mm2[$COUNTER + 1]} ${mm2[$COUNTER + 2]} ${mm2[$COUNTER + 3]} ${mm2[$COUNTER + 4]} ${mm2[$COUNTER + 5]} ${mm2[$COUNTER + 6]} ${mm2[$COUNTER + 7]} ${mm2[$COUNTER + 8]} ${mm2[$COUNTER + 9]} $workdir/$project_folder/fastq ${list[$COUNT]} 1 &
echo ${list[$COUNT]}
echo ${list[$COUNT + 1]}
echo ${list[$COUNT + 2]}
sleep 30s
ps
fi
fi

COUNT=$((COUNT + 3))
echo "end COUNT: $COUNT"
COUNTER=$((COUNTER + $barcode_length))
echo "end COUNTER: $COUNTER"

done
fi

################################################################################## calculate time
while true ### parallel
do
run_nohup_flag=($(can_run_new_nohup 1 $nohupid))
if [[ $run_nohup_flag -eq 1 ]]
then
break
fi
sleep 60s
done

end=$(date +%s%N)
echo "Elapsed Time (in seconds): $(($((end-$start))/1000000000)) seconds" > $workdir/$project_folder/runtime.txt
echo "Elapsed Time (in seconds): $(($((end-$start))/1000000000)) seconds"
echo "Elapsed Time (in minutes): $(($(($end-$start))/60000000000)) minutes" >> $workdir/$project_folder/runtime.txt
echo "Elapsed Time (in minutes): $(($(($end-$start))/60000000000)) minutes"

echo "Moved the log.out file to the project folder."
mv ${project_folder}.log.out $workdir/$project_folder

cd $workdir/$project
chmod 777 -R $workdir/$project

