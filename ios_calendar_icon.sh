#!/bin/bash

# Get directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Set the path to your .desktop file
DESKTOP_FILE="$HOME/.local/share/applications/ios_calendar.desktop"

#Get current date info

#uncomment first DAY_NAME and comment second one to show the full day name
#DAY_NAME=$(date +%A) 

DAY_NAME=$(date +%a | tr '[:lower:]' '[:upper:]' | cut -c1-2)
DAY_NUMBER=$(date +%-d)
MONTH_DAY=$(date +%m%d)

# Build icon path relative to script location
ICON_NAME="ios_calendar_${MONTH_DAY}.png"
ICON_PATH="${SCRIPT_DIR}/${ICON_NAME}"

# Create the new icon
convert "${SCRIPT_DIR}/ios_calendar_blank.png" \
  -background none \
  -gravity North -pointsize 403 -font "$HOME/.local/share/fonts/CamberTRIAL-Rg.otf" \
  -fill red -annotate +0+170 "$DAY_NAME" \
  -gravity Center -pointsize 1400 -font "$HOME/.local/share/fonts/Salve-Sans.otf" \
  -fill black -annotate +0+350 "$DAY_NUMBER" \
  "$ICON_PATH"

# Update the .desktop file to point to the new icon
sed -i "s|^Icon=.*|Icon=$ICON_PATH|" "$DESKTOP_FILE"
