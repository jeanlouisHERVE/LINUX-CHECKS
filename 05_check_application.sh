#Application-specific checks: Create scripts tailored to monitor specific applications or services running on the system.
###check status of the application 
app_name="application"
status_output=$(sudo systemctl status $app_name)

if echo "$status_output" | grep -q "Active: active (running)"; then
    echo "[INFO]  >> application: $app_name << is running"
    exit 0
else
    echo "[DANGER]  >> application: $app_name << is stopped"
    exit 1
fi