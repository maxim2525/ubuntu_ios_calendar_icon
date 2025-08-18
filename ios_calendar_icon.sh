#!/bin/bash

# Set the path to your .desktop file
DESKTOP_FILE="/home/user/.local/share/applications/ios-shortcut.desktop"

# Get current date parts
#uncomment first DAY_NAME and comment second one to show the full day name

#DAY_NAME=$(date +%A) 
DAY_NAME=$(date +%a | tr '[:lower:]' '[:upper:]' | cut -c1-2)

DAY_NUMBER=$(date +%-d)
MONTH_DAY=$(date +%m%d)  # e.g., 0923

# Set icon output path with date-based filename
ICON_NAME="ios_calendar_${MONTH_DAY}.png"
ICON_PATH="$HOME/apps/icons/$ICON_NAME"

# Create the new icon
convert "$HOME/apps/icons/ios_calendar_blank.png" \
  -background none \
  -gravity North -pointsize 403 -font "$HOME/shortcuts/fonts/CamberTRIAL-Rg.otf" \
  -fill red -annotate +0+170 "$DAY_NAME" \
  -gravity Center -pointsize 1400 -font "$HOME/shortcuts/fonts/Salve-Sans.otf" \
  -fill black -annotate +0+350 "$DAY_NUMBER" \
  "$ICON_PATH"

# Update the .desktop file's Icon= line
# Note: we use sed to replace the line starting with Icon=
sed -i "s|^Icon=.*|Icon=$ICON_PATH|" "$DESKTOP_FILE"
