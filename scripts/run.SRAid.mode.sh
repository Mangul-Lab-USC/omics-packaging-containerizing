
if [ $# -lt 3 ]
then
echo "********************************************************************"
echo "Script was written for project : Packaging and containerizing of bioinformatics software: advances, challenges, and opportunities"
echo "This script was written by Neha Rajkumar"
echo "********************************************************************"
echo ""
echo "1 - SRA_ID"
echo "2 - type: source_code,bioconda,spack"
echo "3 - output"
echo "--------------------------------------"
exit 1
fi


SRA_ID=$1
type=$2
output=$3
name=$type$SRA_ID
seq_path="/u/flashscratch/n/neharajk/raw-sequences"

if [ "$type" == "source_code" ]
then
	bwa_path="/u/flashscratch/n/neharajk/bwa-source/bwa/bwa"
elif [ "$type" == "spack" ]
then 
	bwa_path="/u/home/n/neharajk/scratch/bwa-spack/bwa"	
else
	bwa_path="/u/home/n/neharajk/anaconda3/bin/bwa"
fi

echo $bwa_path


echo $bwa_path mem genome.fa ${seq_path}/${SRA_ID}_1.fastq ${seq_path}/${SRA_ID}_2.fastq
echo "$bwa_path mem genome.fa ${seq_path}/${SRA_ID}_1.fastq ${seq_path}/${SRA_ID}_2.fastq" >run.${SRA_ID}.${type}.bwa.sh
chmod u+x run.${SRA_ID}.${type}.bwa.sh



job_id=$(qsub -m bea -cwd -V -N $name -l h_data=24G,highp,time=24:00:00 run.${SRA_ID}.${type}.bwa.sh | awk '{print $3}')
echo $job_id ' ' $SRA_ID ' ' $type>>$3 



