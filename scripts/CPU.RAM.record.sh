if [ $# -lt 2 ]
then
echo "********************************************************************"
echo "Script was written for project : Packaging and containerizing of bioinformatics software: advances, challenges, and opportunities"
echo "This script was written by Neha Rajkumar"
echo "********************************************************************"
echo ""
echo "1 - input text"
echo "2 - output file"
echo "--------------------------------------"
exit 1
fi

jobs=$1
output=$2
#put this in a loop

#while read in_data; 
#       do
#               job_id=$(awk '{print $1}')
#               SRA_ID=$(awk '{print $2}')
#               type=$(awk '{print $3}')
                #echo $job_id
                #echo $SRA_ID
                #echo $type
#               CPU_time=$(qacct -j $job_id | grep cpu| awk '{print $2}')
#               RAM=$(qacct -j $job_id | grep maxvmem| awk '{print $2}')
#               echo $CPU_time ' ' $RAM
                #echo $SRA_ID ' ' $type ' ' $CPU_time ' ' $RAM >> $output
#done < $jobs

awk '{print $1" "$2 " "$3 " "$4}' $1 | while read job_id SRA_ID type UTIME;
do 
        CPU_time=$(qacct -j $job_id | grep cpu| awk '{print $2}')
        RAM=$(qacct -j $job_id | grep maxvmem| awk '{print $2}')
        UTIME=$(qacct -j $job_id | grep ru_utime| awk '{print $2}')
        echo $SRA_ID '  ' $type '       ' $CPU_time '   ' $RAM '        ' $UTIME >> $output
done
