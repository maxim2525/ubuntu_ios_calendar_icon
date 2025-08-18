<img width="386" height="90" alt="image" src="https://github.com/user-attachments/assets/267ee671-e1f4-47b2-8ce8-352f2b300e90" />


generates an icon with the current date like the mac/ios icon for the calendar application.

suitable for chromium apps

requires:

> sudo apt-get install imagemagick

> Salve-Sans.otf

> CamberTRIAL-Rg.otf (https://blogfonts.com/camber-trial-rg.font)


1. install https://www.icloud.com/calendar/ as an app and create a shortcut/place it in the dock
2. download the script, place it in a folder and run it. it should generate a ios_calendar.png file
3. go to ~/.local/share/applications and find the calendar .desktop file and open it with an editor
4. replace the location in the line which starts with "Icon=" with the file location of the ios_calendar.png file



to automate the icon generation:

sudo nano /etc/systemd/system/daily-task.service
```
[Unit]
Description=refresh calendar icon

[Service]
Type=oneshot
ExecStart=/home/youruser/apps/ios_calendar_icon.sh
```

sudo nano /etc/systemd/system/daily-task.timer
```
[Unit]
Description=Run daily task once per day

[Timer]
OnCalendar=*-*-* 00:00
Persistent=true

[Install]
WantedBy=timers.target
```

```
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable --now daily-task.timer
```


to use full day name open the .sh file and uncomment this line

`
#DAY_NAME=$(date +%A)
`

and comment the line underneath

`
DAY_NAME=$(date +%a | tr '[:lower:]' '[:upper:]' | cut -c1-2)
`
