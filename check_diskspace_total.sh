#!/bin/bash
#Disk space monitoring script: Check disk usage and send alerts if it exceeds a certain threshold.

##variables
percentage_total_used_storage=0
percentage_total_unused_storage=0
size_total_unused_storage=0

##script
#the total percentage of used diskspace
percentage_total_used_storage=$(df -h --total | grep "total" | awk '{print $5}'| sed 's/%//')
percentage_total_used_storage=$(($percentage_total_used_storage))
#echo "The percentage of total used storage : $percentage_total_used_storage%"

#the total percentage of unused diskspace
percentage_total_unused_storage=$((100 - $percentage_total_used_storage))
#echo "The percentage of total unused storage : $percentage_total_unused_storage%"

#the total amount of unused diskspace
size_total_unused_storage=$(df -h --total | grep "total" | awk '{print $4}'| sed 's/G//')
#echo "The size of total unused storage : $size_total_unused_storage%"
percentage_total_used_storage=76

if [ -n "$percentage_total_used_storage" ] && [ -n "$percentage_total_unused_storage" ]; then
    if [ $percentage_total_used_storage -ge 50 ] && [ $percentage_total_used_storage -lt 75 ]; then
        #echo "[INFO]    >> Diskspace << has $percentage_total_unused_storage% of freespace"
        exit 0
    elif [ $percentage_total_used_storage -ge 75 ] && [ $percentage_total_used_storage -lt 80 ]; then
        #echo "[WARNING] >> Diskspace << has $percentage_total_unused_storage% of freespace"
        exit 1
    elif [ $percentage_total_used_storage -ge 80 ]; then
        #echo "[DANGER]  >> Diskspace << has $percentage_total_unused_storage% of freespace"
        exit 1
    else
        #echo "[INFO]    >> Diskspace << has $percentage_total_unused_storage% of freespace ($size_total_unused_storage"G")"
        exit 0
    fi
fi