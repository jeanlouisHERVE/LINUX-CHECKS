#Disk space monitoring script: Check disk usage and send alerts if it exceeds a certain threshold.

#the total amount of used diskspace
percentage_total_used_storage=$(df -h --total | grep "total" | awk '{print $5}'| sed 's/%//')
percentage_total_used_storage=$(($percentage_total_used_storage))
echo "The percentage of total used storage : $percentage_total_used_storage%"

#==> add size of diskpace left to the result sentence

#/!\ to rebuild 

#the total amount of unused diskspace
percentage_total_unused_storage=$((100-$percentage_total_unused_storage))
echo "The percentage of total unused storage : $percentage_total_unused_storage%"

if [ -n "$percentage_total_used_storage" ] && [ -n "$percentage_total_unused_storage" ]; then
    percentage_total_unused_storage=$(($percentage_total_unused_storage))
    percentage_total_unused_storage=$((100 - $percentage_total_unused_storage))
    if [ $percentage_total_unused_storage -ge 50 ] && [ $percentage_total_unused_storage -lt 75 ]; then
        echo "[INFO] >> Diskspace << has $percentage_total_unused_storage% of freespace"
    elif [ $percentage_total_unused_storage -ge 75 ] && [ $percentage_total_unused_storage -lt 80 ]; then
        echo "[WARNING] >> Diskspace << has $percentage_total_unused_storage% of freespace"
    elif [ $percentage_total_unused_storage -ge 80 ]; then
        echo "[DANGER]  >> Diskspace << has $percentage_total_unused_storage% of freespace"
    else
        echo "[INFO]    >> Diskspace << has $percentage_total_unused_storage% of freespace (percentage_total_unused_storage)"
    fi
fi