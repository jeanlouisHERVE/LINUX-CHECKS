#!/bin/bash
#Disk space monitoring script: Check disk usage for each partition and send alerts if it exceeds a certain threshold.

#tmpfs              794M    1,7M  793M   1% /run
#/dev/sda3           24G     18G  5,4G  77% /
#tmpfs              3,9G     32M  3,9G   1% /dev/shm
#tmpfs              5,0M    4,0K  5,0M   1% /run/lock
#/dev/sda2          512M    5,3M  507M   2% /boot/efi
#tmpfs              794M    140K  794M   1% /run/user/1000
#/dev/sr0 

##variables
command_output=$(df -P | awk '!/\/dev\/sr0/')
partition_name=""
total_partition_storage=0
total_unused_partition_storage=0
cr=0

##script
echo "$command_output" | tail -n +2 | while IFS= read -r line; do
    partition_name=$(echo "$line" | awk '{print $1}')

    #check state for each partition
    total_partition_storage=$(echo "$line" | awk '{print $5}' | sed 's/[^0-9]//g')
    if [ -n "$total_partition_storage" ]; then
        total_unused_partition_storage=$((100 - $total_partition_storage))
        if [ $total_partition_storage -ge 50 ] && [ $total_partition_storage -lt 75 ]; then
            echo "[INFO] >> $partition_name << has $total_unused_partition_storage% of freespace"
            cr=0
        elif [ $total_partition_storage -ge 75 ] && [ $total_partition_storage -lt 80 ]; then
            echo "[WARNING] >> $partition_name << has $total_unused_partition_storage% of freespace"
            cr=0
        elif [ $total_partition_storage -ge 80 ]; then
            echo "[DANGER]  >> $partition_name << has $total_unused_partition_storage% of freespace"
            cr=1
        else
            echo "[INFO]    >> $partition_name << has $total_unused_partition_storage% of freespace"
            cr=0
        fi
    fi
done

if [ $cr -eq 1 ]; then 
    exit 1
else 
    exit 0
fi
