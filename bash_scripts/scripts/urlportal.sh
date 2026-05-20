#!/bin/bash
#             _   _     _      _
#  __ _  ___ | |_| |__ | | ___| |_ _   _
# / _` |/ _ \| __| '_ \| |/ _ \ __| | | |
#| (_| | (_) | |_| |_) | |  __/ |_| |_| |
# \__, |\___/ \__|_.__/|_|\___|\__|\__,_|
# |___/
#       https://www.youtube.com/user/gotbletu
#       https://twitter.com/gotbletu
#       https://github.com/gotbletu
#       gotbletu@gmail.com

#                   _                  _        _
#        _   _ _ __| |_ __   ___  _ __| |_ __ _| |
#       | | | | '__| | '_ \ / _ \| '__| __/ _` | |
#       | |_| | |  | | |_) | (_) | |  | || (_| | |
#        \__,_|_|  |_| .__/ \___/|_|   \__\__,_|_|
#                    |_|
#       DESC: custom way to handle url (similar idea to xdg-open, mailcap)
#             works with just about all programs (e.g w3m, rtv, newsboat, urlview ...etc)
#       DEMO: https://www.youtube.com/watch?v=2jyfrmBYzVQ
#       install: lynx youtube-dl task-spooler newsboat rtv w3m mpv urlview tmux feh plowshare streamlink curl coreutils


# newsboat:
#     vim ~/.newsboat/config
#         browser ~/.scripts/urlportal.sh

# rtv:
#     vim ~/.bashrc
#         export RTV_BROWSER=~/.scripts/urlportal.sh

# w3m:
#     vim ~/.w3m/keymap
#         open url under cursor (default: Esc+Shift+M); e.g 2+Esc+Shift+M
#         keymap  e       EXTERN_LINK ~/.scripts/urlportal.sh

# urlview:
#     vim ~/.urlview
#         COMMAND ~/.scripts/urlportal.sh

# references:
# cirrusuk http://arza.us/paste/piper
# obosob https://github.com/michael-lazar/rtv/issues/78#issuecomment-125507472
# budlabs - mpv queue https://www.youtube.com/watch?v=-vbr3-mHoRs
#                     https://github.com/budlabs/youtube/blob/master/letslinux/032-queue-files-in-mpv/openvideo
# ji99 - mpv queue script https://www.reddit.com/r/commandline/comments/920p5d/bash_script_for_queueing_youtube_links_in_mpv/


# BROWSERCLI="w3m"
# BROWSER="chromium"
# DEFAULT="xdg-open"
# DEFAULT="chromium --incognito" DEFAULT="w3m"
DEFAULT="$BROWSERCLI"
## short videos/animated gif clips
VIDEO_CLIP="mpv"
#IMAGEGUI="feh -. -x -B black -g 900x600-15+60"
# IMAGECLI="w3m /usr/lib/w3m/cgi-bin/treat_as_url.cgi -o display_image=1 -o imgdisplay=/usr/lib/w3m/w3mimgdisplay"
#IMAGECLI="w3m -o display_image=1 -o imgdisplay=w3mimgdisplay"
# IMAGECLI="fbi"
TORRENTCLI="transmission-remote --add"
# LIVEFEED='streamlink -p "mpv --cache 2048 --ontop --no-border --force-window --autofit=500x280 --geometry=-15-60"'
DDL_PATH=~/Downloads/plowshare
DDL_CLIP_FAST=~/.config/plowshare/queuefast.txt


# enable case-insensitive matching
shopt -s nocasematch

case "$1" in 
    *duckduckgo.com/l/*)
    urlint="$(sed -E 's/.*(https?.*)/\1/' <<<"$1")"
    url="$(python3 -c "import urllib.parse as ul;print(ul.unquote_plus('$urlint'))")"
    ;;
    *)
    url="$1"
    ;;
esac
case "$url" in
    *.diff)
        file="$(date +%Y.%m.%d%T::%N).jpg";wget --backups -O /tmp/$file "$url" &>/dev/null
        ps aux | grep -v grep | grep tmux > /dev/null 2>&1
        if [ $? -eq 0 ];then
            tmux new-window -n nvim && tmux send-keys "nvim \"/tmp/$file\" && tmux kill-pane" 'Enter'
        else
             nohup alacritty -e nvim /tmp/$file &>/dev/null &
        fi
        ;;
    *nitter.*/pic/*)
        file="$(date +%Y.%m.%d%T::%N).jpg";wget --backups -O /tmp/$file "$url" &>/dev/null && nohup sxiv /tmp/$file &>/dev/null &
        ;;
    *vt.tiktok*)
        nohup $VIDEO_CLIP "$url" &>/dev/null &
        ;;
    *nitter.*/pic/*)
        file="$(date +%Y.%m.%d.%T::%N).jpg";wget --backups -O /tmp/$file "$url" &>/dev/null && nohup sxiv /tmp/$file &>/dev/null &
        ;;
    *bibliogram.*/imageproxy*)
        file="$(date +%Y.%m.%d%T::%N).jpg";wget --backups -O /tmp/$file "$url" &>/dev/null && nohup sxiv /tmp/$file &>/dev/null & 
        ;;
    *bibliogram.*/videoproxy*)
        nohup $VIDEO_CLIP "$url" &>/dev/null &
        ;;
    *showroom-live.com/*)
        nohup streamlink "$url" best &>/dev/null &
        ;;
    *gfycat.com/*|*streamable.com/*)
        nohup $VIDEO_CLIP "${url/.gifv/.webm}" > /dev/null 2>&1 &
        ;;
    *v.redd.it/*|*video.twimg.com/*|*dailymotion.com*)
        nohup $VIDEO_CLIP "$url" > /dev/null 2>&1 &
        ;;
    *invidious*)
        nohup $VIDEO_CLIP "$url" &>/dev/null &
        ;;
    *youtube.com/watch*|*youtu.be/*|*clips.twitch.tv/* )
        nohup $VIDEO_CLIP "$url" &>/dev/null &
        ;;
    *dailymotion.com/video/*)
        nohup $VIDEO_CLIP "$url" &>/dev/null &
        ;;
    *twitch.tv/*)
        nohup $VIDEO_CLIP "$url" &>/dev/null &
        ;;
    *reddit.com/r/*)
        ps aux | grep -v grep | grep tmux > /dev/null 2>&1
        if [ $? -eq 0 ];then
            tmux new-window -n rtv && tmux send-keys "rtv --no-autologin -l \"$url\" && tmux kill-pane" 'Enter'
        else
            nohup alacritty -e rtv --no-autologin -l "$url" &>/dev/null &
        fi
        ;;
    *i.imgur.com/*.gifv|*i.imgur.com/*.mp4|*i.imgur.com/*.webm|*i.imgur.com/*.gif)
        nohup $VIDEO_CLIP "$url" > /dev/null 2>&1 &
        ;;
    *i.imgur.com/*| *imgur.com/*.*)
        file="$(date +%Y.%m.%d%T::%N).jpg";wget --backups -O /tmp/$file "$url" &>/dev/null && nohup sxiv /tmp/$file &>/dev/null &
        # nohup $IMAGEGUI "$url" > /dev/null 2>&1 &
        #tmux new-window -n pixcli && tmux send-keys "$IMAGECLI '$url' && tmux kill-pane" 'Enter'
        ;;
    mailto:*)
        ps aux | grep -v grep | grep tmux > /dev/null 2>&1
        if [ $? -eq 0 ];then
            tmux new-window -n neomutt && tmux send-keys "neomutt -- \"$url\" && tmux kill-pane" 'Enter'
        else
            nohup alacritty -e neomutt -- "$url" &>/dev/null &
        fi
        ;;
    *.pls|*.m3u)
        nohup $VIDEO_CLIP "$url" &>/dev/null &
        ;;
    magnet:*|*.torrent)
        $TORRENTCLI "$url" 
        ;;
    *.jpg|*.jpeg|*.png|*:large)
        #tmux new-window -n pixcli && tmux send-keys "$IMAGECLI '$url' && tmux kill-pane" 'Enter'
        file="$(date +%Y.%m.%d%T::%N).jpg";wget --backups -O /tmp/$file "$url" &>/dev/null && nohup sxiv /tmp/$file &>/dev/null &
        # nohup $IMAGEGUI "$url" > /dev/null 2>&1 &
        ;;
    *.pdf)
        file="$(date +%Y.%m.%d%T::%N).jpg";wget --backups -O /tmp/$file "$url" &>/dev/null && nohup zathura /tmp/$file &>/dev/null &
        ;;
    *.gif|*.webm)
        nohup $VIDEO_CLIP "${url/.gifv/.webm}" > /dev/null 2>&1 &
        ;;
#    *zippyshare.com/*|*mediafire.com/file/*|*sendspace.com/file/*)
#        if pgrep -f $DDL_CLIP_FAST > /dev/null
#        then
#            echo "$url" >> $DDL_CLIP_FAST
#        else
#            echo "$url" >> $DDL_CLIP_FAST

#            cat $DDL_CLIP_FAST | awk '!x[$0]++' | sponge $DDL_QUEUE_FAST
#            tmux split-window -fv -p 20 && tmux send-keys "until [[ \$(cat $DDL_CLIP_FAST | grep -v '#' | wc -l) -eq 0 ]]; do mkdir -p $DDL_PATH && cd $DDL_PATH && plowdown -m $DDL_QUEUE_FAST -o $DDL_PATH ; done" 'Enter'
#        fi
#        ;;
    *.mp4|*.mkv|*.avi|*.wmv|*.m4v|*.mpg|*.mpeg|*.flv|*.ogm|*.ogv|*.gifv)
        nohup $VIDEO_CLIP "$url" &>/dev/null &
        ;;
    *.mp3|*.m4a|*.wav|*.ogg|*.oga|*.flac)
        nohup $VIDEO_CLIP "$url" &>/dev/null &
        ;;
    *|*.html)
        # $DEFAULT "$url"
        ps aux | grep -v grep | grep tmux > /dev/null 2>&1
        if [ $? -eq 0 ];then
            tmux new-window -n w3m && tmux send-keys "$DEFAULT \"$url\" && tmux kill-pane" 'Enter'
        else
            nohup alacritty -e $DEFAULT "$url" &>/dev/null &
        fi
        ;;
esac
