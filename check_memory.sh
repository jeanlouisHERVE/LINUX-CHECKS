#Memory usage script: Check the amount of free memory available and alert if it falls below a specified limit.

total_memory_space=$(cat /proc/meminfo | grep MemTotal | awk '{print $2}'| sed 's/kB//')
echo "$total_memory_space"
free_memory_space=$(cat /proc/meminfo | grep MemFree | awk '{print $2}'| sed 's/kB//')
echo "$free_memory_space"