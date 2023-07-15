#Disk space monitoring script: Check disk usage and send alerts if it exceeds a certain threshold.

#the total amount of used diskspace
total_used_storage=$(df -h --total | grep "total" | awk '{print $5}'| sed 's/%//')
total_used_storage=$(($total_used_storage))
echo "The percentage of total used storage : $total_used_storage%"

#the total amount of unused diskspace
total_unused_storage=$((100-$total_used_storage))
echo "The percentage of total unused storage : $total_unused_storage%"

if [ $total_used_storage -gt 50 ]; then
    echo "[INFO] At least half of the allocated space is used"
elif [ $total_used_storage -gt 75 ]; then
    echo "[WARNING] At least 75% of the allocated space is used"
elif [ $total_used_storage -gt 75 ]; then
    echo "[DANGER] At least 80% of the allocated space is used"
fi