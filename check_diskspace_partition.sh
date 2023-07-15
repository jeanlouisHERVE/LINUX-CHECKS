#!/bin/bash
#Disk space monitoring script: Check disk usage for each partition and send alerts if it exceeds a certain threshold.

#tmpfs              794M    1,7M  793M   1% /run
#/dev/sda3           24G     18G  5,4G  77% /
#tmpfs              3,9G     32M  3,9G   1% /dev/shm
#tmpfs              5,0M    4,0K  5,0M   1% /run/lock
#/dev/sda2          512M    5,3M  507M   2% /boot/efi
#tmpfs              794M    140K  794M   1% /run/user/1000
#/dev/sr0 


while IFS= read -r line; do
    echo "$line"
    #partition_name=$($line | awk '{print $0}')
    #used_storage=$(df -h --total | grep "total" | awk '{print $5}'| sed 's/%//')
    #used_storage=$(($used_storage))
    #echo "$partition_name uses $used_storage% of its partition"
done < <(df -h)




#the amount of used diskspace on ****
#partition_name=$($line | awk '{print $0}')
#used_storage=$(df -h --total | grep "total" | awk '{print $5}'| sed 's/%//')
#used_storage=$(($used_storage))
#echo "$partition_name uses $used_storage% of its partition"

#the total amount of unused diskspace
#total_unused_storage=$((100-$total_used_storage))
#echo "The percentage of total unused storage : $total_unused_storage%"

#if [ $total_used_storage -gt 50 ]; then
#    echo "[INFO] At least half of the allocated space is used"
#elif [ $total_used_storage -gt 75 ]; then
#    echo "[WARNING] At least 75% of the allocated space is used"
#elif [ $total_used_storage -gt 75 ]; then
#    echo "[DANGER] At least 80% of the allocated space is used"
#fi