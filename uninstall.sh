#!/bin/bash

SERVICE_NAME="daily-task"
SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}.service"
TIMER_FILE="/etc/systemd/system/${SERVICE_NAME}.timer"

echo "🛑 Stopping and disabling ${SERVICE_NAME}.timer..."
sudo systemctl stop "${SERVICE_NAME}.timer"
sudo systemctl disable "${SERVICE_NAME}.timer"

echo "🧹 Removing systemd unit files..."
sudo rm -f "$SERVICE_FILE" "$TIMER_FILE"

echo "🔄 Reloading systemd..."
sudo systemctl daemon-reexec
sudo systemctl daemon-reload

echo "✅ Uninstall complete. ${SERVICE_NAME} timer and service have been removed."
