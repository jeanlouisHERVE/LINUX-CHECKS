#Application-specific checks: Create scripts tailored to monitor specific applications or services running on the system.
###check status of the application 
app_name="application"
status_output=$(sudo systemctl status $app_name)

if echo "$status_output" | grep -q "Active: active (running)"; then
    echo "[INFO]  >> application: $app_name << is active and running"
    exit 0
elif echo "$status_output" | grep -q "Active: failed (Result: start-limit-hit)";
    echo "[DANGER]  >> application: $app_name << failed to start"
    exit 1
elif echo "$status_output" | grep -q "Active: inactive (dead)";
    echo "[DANGER]  >> application: $app_name << is inactive"
    exit 1
fi