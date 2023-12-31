#!/bin/bash
#CPU load monitoring script: Monitor CPU usage and notify if it reaches a critical level.
# Function to check CPU usage and notify if it reaches a critical level
check_cpu_usage() {
    local critical_level=80  # Set the critical level as desired (percentage)

    local cpu_usage=$(top -bn 1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    cpu_usage=${cpu_usage%.*}  # Remove decimal part

    if [ "$cpu_usage" -ge "$critical_level" ]; then
        echo "[DANGER]  >> cpu usage << is at ${cpu_usage}%!"
        exit 1
        # You can add notification commands here, e.g., sending an email, displaying a desktop notification, etc.
    else
        exit 0
    fi
}
# CPU Usage: Monitor the overall CPU usage to understand its workload. You can use tools like top, htop, or glances 
# to view the CPU usage in real-time. These tools provide a breakdown of CPU usage by individual processes and threads, 
# helping you identify resource-intensive applications.

# CPU Frequency and Scaling: Check the CPU frequency to determine if the processor is running at its maximum capability
#  or if it's being scaled down to conserve power. The cpufreq-info or lscpu commands can provide information on CPU 
#  frequency scaling.
display_cpu_frequency() {
    echo "CPU Frequency and Scaling:"
    get_max_frequency=$( lscpu | grep "CPU MHz" | sed 's/MHz//' )
    max_frequency=$(( $get_max_frequency ))
    
    ###installation of cpufrequtils
    total_actual_frequency=0  ### to define 

    if [ -n "$max_frequency" ] && [ -n "$total_actual_frequency" ]; then
    percentage_actual_cpu=$(($total_actual_frequency * 100 / $max_frequency))
    #echo "percentage_actual_cpu, $percentage_actual_cpu%"
    if [ $percentage_actual_cpu -ge 50 ] && [ $percentage_actual_cpu -lt 75 ]; then
        echo "[INFO]    >> cpu << uses $percentage_actual_cpu% of its capacity"
        exit 0    
    elif [ $percentage_actual_cpu -ge 75 ] && [ $percentage_actual_cpu -lt 80 ]; then
        echo "[WARNING] >> cpu << uses $percentage_actual_cpu% of its capacity"
        exit 0   
    elif [ $percentage_actual_cpu -ge 80 ]; then
        echo "[DANGER]  >> cpu << uses $percentage_actual_cpu% of its capacity"
        exit 1  
    else
        echo "[INFO]    >> cpu << uses $percentage_actual_cpu% of its capacity"
        exit 0
    fi
fi
}


# CPU Temperature: Monitor the CPU temperature to ensure it's operating within safe limits. Excessive heat can affect
#  performance and lead to thermal throttling. Use tools like sensors or lm-sensors to retrieve CPU temperature readings.
#==> installation of lm-sensors 

display_cpu_temperature() {
    echo "CPU Temperature:"
    sensors
    # Alternative: lm-sensors
}


# CPU Model and Features: Identify the specific model and features of your CPU. The lscpu command provides detailed 
# information about the CPU architecture, vendor, cores, cache sizes, and more.
display_cpu_model_and_features() {
    echo "CPU Model and Features:"
    lscpu
}
# CPU Load Average: Examine the system's load average, which represents the average number of processes waiting to 
# be executed over different time intervals. You can view the load average using the uptime command or by reading the /proc/loadavg file.
display_cpu_load_average() {
    echo "CPU Load Average:"
    uptime
    # Alternative: cat /proc/loadavg
}

# Interrupts and Context Switches: Monitor the number of interrupts and context switches occurring on the CPU. Tools
#  like vmstat or sar can display these statistics, providing insights into system performance and potential bottlenecks.
display_interrupts_and_context_switches() {
    echo "Interrupts and Context Switches:"
    vmstat -w 1 5
}

# CPU Performance Counters: Utilize performance monitoring tools like perf to access CPU performance counters. These
#  counters provide low-level details on CPU events, such as cache misses, branch predictions, and instructions retired,
#  helping you analyze and optimize performance-critical code.
display_cpu_performance_counters() {
    echo "CPU Performance Counters:"
    perf stat sleep 5
    # Note: The above command captures CPU events for the 'sleep 5' command.
    # You can replace 'sleep 5' with any other command or your application.
}
# CPU Affinity: Explore CPU affinity settings to control which CPUs are utilized by specific processes or threads.
# The taskset command allows you to assign or query CPU affinity for a given process.
process_list=["",""]

display_cpu_affinity(process_name) {
    echo "CPU Affinity for $process_name:"
    process_pid=$(ps -e | grep $process_name | awk '{print $1}')

    # Replace 'YOUR_PROCESS_PID' with the PID of the process you want to query or modify CPU affinity for.
    # For example, 'taskset -p 1234' to get the current affinity or 'taskset -c 0-3 1234' to set affinity to CPUs 0 to 3.
    current_affinity=$(taskset -p $process_pid)
    echo "[INFO]    >> cpu affinity : $process_name << pid $process_pid: $current_affinity"
}
for process in $process_list:
    if pgrep -x "$process" > /dev/null; then
        echo "Process '$process' is running."
        display_cpu_affinity($process)
    else
        echo "Process '$process' is not running."
    fi


# Main script
check_cpu_usage
display_cpu_frequency
display_cpu_temperature
display_cpu_model_and_features
display_cpu_load_average
display_interrupts_and_context_switches
display_cpu_performance_counters
