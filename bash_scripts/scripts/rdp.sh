#!/bin/bash
#/bpp:8

if [ $# -eq 0 ];then
    echo "Access.lnk
Amnesia - The Dark Descent.lnk
Backup and Sync from Google.lnk
COMSOL Multiphysics 5.5.lnk
Counter-Strike WaRzOnE.lnk
DB Browser (SQLCipher).lnk
Discord.lnk
Epic Games Launcher.lnk
Excel.lnk
Firefox.lnk
Google Chrome.lnk
Google Docs.lnk
Google Sheets.lnk
Google Slides.lnk
HiBitUninstaller.lnk
IDLE (Python 3.8 64-bit).lnk
Immersive Control Panel.lnk
IObit Unlocker.lnk
iw3mp (2).lnk
iw3mp.lnk
JDownloader 2.lnk
KeePassXC.lnk
matlab.lnk
MEGAsync.lnk
Microsoft Edge.lnk
Microsoft Teams.lnk
Notepad++.lnk
Outlook.lnk
PeaZip.lnk
PowerPoint.lnk
PowerToys (Preview).lnk
PowerToys.lnk
PUBG LITE.lnk
Publisher.lnk
qbittorrent.lnk
QuickCPU.lnk
Skype for Business.lnk
Start Zoom.lnk
Steam.lnk
SumatraPDF.lnk
TeamSpeak 3 Client.lnk
Visual Studio Installer.lnk
Word.lnk"
elif [ "$@" == "1" ];then
    $TERMINAL -e xfreerdp -wallpaper /compression -themes /async-update /microphone /async-input /audio-mode:0 /clipboard /scale:140 /f /v:192.168.100.66 /u:$DESK_NAME /p:$DESK_PASS /smart-sizing &> /dev/null
else  
    $TERMINAL -e xfreerdp /microphone /audio-mode:0 /clipboard /v:192.168.100.66 /u:$DESK_NAME /p:$DESK_PASS /f /smart-sizing /app:"C:/Users/ziaul/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/$@"
fi
#/dynamic-resolution
