#Memory usage script: Check the amount of free memory available and alert if it falls below a specified limit.

total_memory_space=$(cat /proc/meminfo | grep MemTotal | awk '{print $2}'| sed 's/kB//')
#echo "$total_memory_space"
free_memory_space=$(cat /proc/meminfo | grep MemFree | awk '{print $2}'| sed 's/kB//')
#echo "$free_memory_space"

if [ -n "$total_memory_space" ] && [ -n "$free_memory_space" ]; then
    percentage_free_memory_space=$(($free_memory_space * 100 / $total_memory_space))
    #echo "$percentage_free_memory_space%"
    if [ $percentage_free_memory_space -ge 50 ] && [ $percentage_free_memory_space -lt 75 ]; then
        echo "[INFO] >> memory << has $percentage_free_memory_space% of freespace"
    elif [ $percentage_free_memory_space -ge 75 ] && [ $percentage_free_memory_space -lt 80 ]; then
        echo "[WARNING] >> memory << has $percentage_free_memory_space% of freespace"
    elif [ $percentage_free_memory_space -ge 80 ]; then
        echo "[DANGER]  >> memory << has $percentage_free_memory_space% of freespace"
    else
        echo "[INFO]    >> memory << has $percentage_free_memory_space% of freespace"
    fi
fi