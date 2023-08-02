#!/usr/bin/env bats

# Require minimum BATS_VERSION 1.5.0
bats_require_minimum_version 1.5.0

##installation 
#git clone https://github.com/bats-core/bats-core.git
#cd bats-core
#./install.sh /usr/local

##TO DO 
#add alias to run healthcheck

###FUNCTIONS TO TEST
check_cpu_usage() {
    local critical_level=80  # Set the critical level as desired (percentage)

    local cpu_usage=$(top -bn 1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    cpu_usage=$(( $cpu_usage ))  # Remove decimal part
    echo "cpu_usage: $cpu_usage"

    if [ "$cpu_usage" -ge "$critical_level" ]; then
        echo "[DANGER]  >> cpu usage << is at ${cpu_usage}%!"
        exit 1
        # You can add notification commands here, e.g., sending an email, displaying a desktop notification, etc.
    else
        exit 0
    fi
}

display_cpu_frequency() {
    echo "CPU Frequency and Scaling:"
    get_max_frequency=$( lscpu | grep "CPU MHz" | sed 's/MHz//' )
    max_frequency=$(( $get_max_frequency ))
    
    ###installation of cpufrequtils
    #sudo apt-get install cpufrequtils
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

# Test scripts
@test "diskspace_total" {
  run ./00_check_diskspace_total.sh
  echo "$status"
  [ "$status" -eq 0 ]
}

@test "diskspace_partition" {
  run ./06_check_diskspace_partition.sh
  echo "$status"
  [ "$status" -eq 0 ]
}

@test "memory" {
  run ./01_check_memory.sh
  echo "$status"
  [ "$status" -eq 0 ]
}

# @test "users" {
#   run ./02_check_user.sh
#   echo "$status"
#   [ "$status" -eq 0 ]
# }

@test "cpu_usage" {
  result="$(( check_cpu_usage ))"
  echo "result"
  [ "$result" -eq 0 ]
}

