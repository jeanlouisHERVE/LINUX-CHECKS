#Disk space monitoring script: Check disk usage and send alerts if it exceeds a certain threshold.

total_used_storage=$(df -h --total | grep "total" | awk '{print $5}'| sed 's/%//')
echo "The percentage of total used storage : $total_used_storage%"

total_unused_storage=$((100-$total_used_storage))
echo "The percentage of total unused storage : $total_unused_storage%"