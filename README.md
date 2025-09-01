<img width="250" height="85" alt="image" src="https://github.com/user-attachments/assets/6a40d598-dff8-43e2-b06a-c01e1aae7107" />



generates an icon with the current date like the mac/ios icon for the calendar application.

suitable for chromium apps

## requirements

```
sudo apt-get install imagemagick
```

you'll need these fonts:</br>
```
Salve-Sans.otf
CamberTRIAL-Rg.otf (https://blogfonts.com/camber-trial-rg.font)
```

## installation

1. install https://www.icloud.com/calendar/ as an app and create a shortcut/place it in the dock
2. download the scripts and place it in a folder
3. go to `~/.local/share/applications` and copy the path of the calendar .desktop file
4. run `install.sh <path-of-calendar-desktop-file>`
5. you can delete `install.sh` after that

<br/> use `uninstall.sh` to delete the service and timer

## dayname options

there are multiple options on how to display the day name:

-display full day name
-display short day name (2 letters)
-display short day name (3 letters)
-display month name (e.g., September)
-display three letters of the month (e.g., Sep)

open ios_calendar_icon.sh with an editor and comment out the DAY_NAME line underneath the according comment for the option
