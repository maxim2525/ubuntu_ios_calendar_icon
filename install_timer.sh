#!/bin/bash

# Check if an argument (command) was passed
if [ -z "$1" ]; then
    echo "Error: No command provided for ExecStart."
    echo "Usage: $0 <command-to-run-daily>"
    exit 1
fi

COMMAND="$1"

# Define paths
SERVICE_FILE="/etc/systemd/system/daily-task.service"
TIMER_FILE="/etc/systemd/system/daily-task.timer"

# Write the service file
sudo tee "$SERVICE_FILE" > /dev/null <<EOF
[Unit]
Description=refresh calendar icon

[Service]
Type=oneshot
ExecStart=${COMMAND}
EOF

# Write the timer file
sudo tee "$TIMER_FILE" > /dev/null <<EOF
[Unit]
Description=Run daily task once per day

[Timer]
OnCalendar=*-*-* 00:00
Persistent=true

[Install]
WantedBy=timers.target
EOF

# Reload systemd
sudo systemctl daemon-reexec
sudo systemctl daemon-reload

# Enable and start the timer
sudo systemctl enable --now daily-task.timer

echo "✅ daily-task.timer has been created and enabled."
