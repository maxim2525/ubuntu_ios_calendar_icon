#!/bin/bash

# Check if a desktop file argument was provided
if [ -z "$1" ]; then
    echo "Error: No argument provided. Please specify a .desktop file name."
    echo "Usage: $0 <YourApp.desktop>"
    exit 1
fi

DESKTOP_FILE_NAME="$1"

# Resolve absolute path of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_SCRIPT="${SCRIPT_DIR}/ios_calendar_icon.sh"

# Check if ios_calendar_icon.sh exists
if [ ! -f "$TARGET_SCRIPT" ]; then
    echo "Error: ios_calendar_icon.sh not found in script directory: $SCRIPT_DIR"
    exit 1
fi

# Replace DESKTOP_FILE=BLANK with DESKTOP_FILE=<your value>
sed -i "s|^DESKTOP_FILE=.*|DESKTOP_FILE=${DESKTOP_FILE_NAME}|" "$TARGET_SCRIPT"

# Define paths
SERVICE_FILE="/etc/systemd/system/daily-task.service"
TIMER_FILE="/etc/systemd/system/daily-task.timer"

# Write the service file
sudo tee "$SERVICE_FILE" > /dev/null <<EOF
[Unit]
Description=refresh calendar icon

[Service]
Type=oneshot
ExecStart=${TARGET_SCRIPT}
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

# Reload systemd and start timer
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable --now daily-task.timer

echo "✅ daily-task.timer is active and will run ios_calendar_icon.sh daily at midnight."
echo "➡️  Set DESKTOP_FILE=${DESKTOP_FILE_NAME} inside ios_calendar_icon.sh"
