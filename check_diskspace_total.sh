#Disk space monitoring script: Check disk usage and send alerts if it exceeds a certain threshold.

total_used_storage=$(df -h --total | grep "total" | awk '{print $5}')
echo $total_used_storage

total_unused_storage=$(df -h --total | grep "total" | awk '{print $5}')
echo $total_unused_storage