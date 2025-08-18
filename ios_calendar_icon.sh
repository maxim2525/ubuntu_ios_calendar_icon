#!/bin/bash

#use first for full dayname or second for first two letters in uppercase

#DAY_NAME=$(date +%A)
DAY_NAME=$(date +%a | tr '[:lower:]' '[:upper:]' | cut -c1-2)

DAY_NUMBER=$(date +%-d)


convert ios_calendar_blank.png \
  -background none \
  -gravity North -pointsize 403 -font "~/.local/share/fonts/CamberTRIAL-Rg.otf" \
  -fill red -annotate +0+170 "$DAY_NAME" \
  -gravity Center -pointsize 1400 -font "~/.local/share/fonts/Salve-Sans.otf" \
  -fill black -annotate +0+350 "$DAY_NUMBER" \
  ios_calendar_.png
