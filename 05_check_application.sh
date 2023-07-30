#!/bin/bash
#Application-specific checks: Create scripts tailored to monitor specific applications or services running on the system.
###check status of the application 

#variables
app_name="application"
app_url="http://your_app_url"


check_application_status(app_name):
    
    status_output=$(sudo systemctl status $app_name)

    if echo "$status_output" | grep -q "Active: active (running)"; then
        echo "[INFO]  >> application: $app_name << is active and running"
        exit 0
    elif echo "$status_output" | grep -q "Active: failed (Result: start-limit-hit)"; then
        echo "[DANGER]  >> application: $app_name << failed to start"
        exit 1
    else echo "$status_output" | grep -q "Active: inactive (dead)";
        echo "[DANGER]  >> application: $app_name << is inactive"
        exit 1
    fi


check_application_response_time(app_url):
    while true; do
        response_time=$(curl -o /dev/null -s -w "%{time_total}\n" "$app_url")
        echo "Response Time: ${response_time} seconds"
        ###add check regarding the response time check
    done


check_application_status(app_name)
check_application_response_time(app_url)