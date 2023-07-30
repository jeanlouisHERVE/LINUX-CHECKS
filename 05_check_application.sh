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


###ideas of checks 

# CPU Usage: Monitor the application's CPU usage to detect any abnormal spikes or high utilization 
# that could indicate performance issues or resource bottlenecks.

# Memory Usage: Track the application's memory usage to ensure it stays within acceptable limits 
# and to identify potential memory leaks.

# Disk Usage: Monitor disk space usage to avoid running out of storage, which could lead to 
# application errors or failures.

# Network Usage: Keep an eye on network activity to ensure the application is communicating 
# properly and efficiently.

# Response Time and Latency: Measure the application's response time and latency to ensure 
# it meets performance expectations for users.

# Throughput: Monitor the number of requests or transactions the application processes per unit 
# of time to assess its workload and capacity.

# Error Rates and Logs: Track the occurrence of errors, warnings, and exceptions within the 
# application and review logs to identify and resolve issues promptly.

# Application Availability: Monitor the application's uptime and availability to detect and 
# address any service interruptions.

# Concurrency and Thread/Process Count: Monitor the number of concurrent users or threads/child 
# processes to understand the application's concurrency demands.

# Security and Vulnerabilities: Regularly scan the application for security vulnerabilities and 
# potential threats to ensure a secure environment.

# Custom Business Metrics: Depending on the application's functionality, monitor custom metrics 
# relevant to its specific use case and business requirements.

# Database Performance: If the application uses a database, monitor database performance, query 
# response times, and connection pool usage.

# External Service Dependencies: If the application relies on external services, monitor the 
# health and response times of these dependencies to identify potential bottlenecks.

# Load Balancer and Web Server Metrics: If the application is behind a load balancer or web 
# server, monitor the load balancer's health and the server's metrics to ensure proper distribution of traffic.

# Container Metrics (if applicable): If the application runs in containers, monitor container 
# metrics like CPU, memory, and network usage.