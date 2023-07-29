#Log file analysis script: Analyze log files for errors, warnings, or any other specific patterns.
#!/bin/bash

# Define the log file path
LOG_FILE="/var/log/messages"

# Check if the log file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found: $LOG_FILE"
    exit 1
fi

# Function to request sudo password once
sudo_prompt() {
    # Prompt the user for their password and keep it cached for a short time
    # so that subsequent sudo commands within this script won't ask for the password again.
    sudo -v
}

# Function to analyze logs with elevated privileges using sudo
analyze_logs_with_sudo() {
    # Count occurrences of each log level (INFO, WARNING, ERROR)
    count_info=$(grep -c "INFO" "$LOG_FILE")
    count_warning=$(grep -c "WARNING" "$LOG_FILE")
    count_error=$(grep -c "ERROR" "$LOG_FILE")

    # Output the log level counts
    echo "Log Analysis Report:"
    echo "---------------------"
    echo "INFO count: $count_info"
    echo "WARNING count: $count_warning"
    echo "ERROR count: $count_error"
    echo

    # Extract the most common error messages (assuming ERROR logs start with "ERROR:") ==> to adapt
    echo "Most common ERROR messages:"
    echo "--------------------------"
    grep "ERROR:" "$LOG_FILE" | cut -d ":" -f 3- | sort | uniq -c | sort -nr | head -n 5

    if [[ $count_error -gt 0 ]]; then
        exit 1 
}

# Check if running with sudo (elevated privileges)
if [[ $EUID -eq 0 ]]; then
    # If already running with sudo, call the function directly
    analyze_logs_with_sudo
else
    # If not running with sudo, request password and run the script with sudo
    sudo_prompt
    sudo bash -c "$(declare -f analyze_logs_with_sudo); analyze_logs_with_sudo
fi