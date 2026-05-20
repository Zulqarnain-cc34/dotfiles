#This is a collection of programs and commands I launch on wm startup
# source for the terminal


xwallpaper --stretch ~/.config/wall.png 
redshift -x && redshift -O 3500 
nm-applet > /dev/null 2>&1 &
xss-lock slock > /dev/null 2>&1 &
/usr/lib/kdeconnectd > /dev/null 2>&1 &
kdeconnect-indicator > /dev/null 2>&1 &
# mpDris2 > /dev/null 2>&1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd > /dev/null 2>&1 &
fcitx-autostart > /dev/null 2>&1 &
picom --experimental-backends --backend glx > /dev/null 2>&1 &
pasystray > /dev/null 2>&1 &
~/bin/bash_scripts/personal/random-wallpaper.sh > /dev/null 2>&1 &
~/bin/bash_scripts/notify_email.sh > /dev/null 2>&1 &
~/bin/bash_scripts/notification_log > /dev/null 2>&1 &
~/bin/bash_scripts/notify-calcurse.sh > /dev/null 2>&1 &
greenclip daemon > /dev/null 2>&1 &
# trayer --edge top --align right --widthtype request --heighttype pixel --height 20  --transparent true --tint 0x00000000 > /dev/null 2>&1 &

(test=$(ps -aux | grep "dwmblocks" |wc -l);[[ ${test} -eq 1 ]] && dwmblocks) &
#(nm-applet &>/dev/null ) &
#(pasystray &>/dev/null ) &


#/usr/lib/org_kde_powerdevil & 

#syncthing &>/dev/null &
#qdbus-qt5 org.kde.kdeconnect /modules/kdeconnect/devices/a9453025af094072/sftp mountAndWait &
#mpd &
#transmission-daemon &

#~/.dwm/kdeservices.sh &

#xss-lock xsecurelock &

#rclone mount --vfs-cache-mode=writes --dir-cache-time=72h Gdrive:/ ~/Public/Gdrive &
#rclone mount --vfs-cache-mode=writes --dir-cache-time=72h mysecret:/ ~/Public/mysecret &

#latte-dock & 


#while true;do ~/.dwm/check_if_services_are_running.sh ;sleep 20s ;done &

#while true;do ~/bin/bash_scripts/cpu_speed_cheak_and_notifier.sh ;sleep 20s ;done &

# while true; do xsetroot -name "Cpu: $(lscpu | awk  '/CPU MHz:/ {print $3}')|Free Memory: $(free -m | grep '^Mem' | awk '{print $4"MB"}') | Battery: $(cat /sys/class/power_supply/BAT0/capacity)% $(cat /sys/class/power_supply/BAT0/status | head -c 1)"; sleep 1s ;done &
