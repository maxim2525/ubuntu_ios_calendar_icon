#!/bin/bash

# Get directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
USER_HOME="$(echo "$SCRIPT_DIR" | cut -d/ -f1-3)"

# Set the path to your .desktop file
DESKTOP_FILE=BLANK

#Get current date info


#display full day name
#DAY_NAME=$(date +%A) 

#display short day name (2 letters)
#DAY_NAME=$(date +%a | tr '[:lower:]' '[:upper:]' | cut -c1-2)

#display short day name (3 letters)
DAY_NAME=$(date +%a | tr '[:lower:]' '[:upper:]' | cut -c1-3)

# display month name (e.g., September)
#DAY_NAME=$(date +%B)

# display three letters of the month (e.g., Sep)
#DAY_NAME=$(date +%b | tr '[:lower:]' '[:upper:]')

DAY_NUMBER=$(date +%-d)
MONTH_DAY=$(date +%m%d)

# Build icon path relative to script location
ICON_NAME="ios_calendar_${MONTH_DAY}.png"
ICON_PATH="${SCRIPT_DIR}/${ICON_NAME}"

# remove old icons
rm -f "${SCRIPT_DIR}/ios_calendar_"*.png

# Create the new icon
convert "${SCRIPT_DIR}/blank_calendar.png" \
  -background none \
  -gravity North -pointsize 40 -font "$USER_HOME/.local/share/fonts/CamberTRIAL-Rg.otf" \
  -fill red -annotate +0+18 "$DAY_NAME" \
  -gravity Center -pointsize 140 -font "$USER_HOME/.local/share/fonts/Salve-Sans.otf" \
  -fill black -annotate +0+36 "$DAY_NUMBER" \
  "$ICON_PATH"

# Update the .desktop file to point to the new icon
sed -i "s|^Icon=.*|Icon=$ICON_PATH|" "$DESKTOP_FILE"
