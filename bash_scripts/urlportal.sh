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
#        browser ~/.scripts/urlportal.sh

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

# DEFAULT opener program (used as a browser-like fallback)
DEFAULT="firefox"

# Short videos / animated clips handler
VIDEO_CLIP="mpv"

# Torrent client CLI
TORRENTCLI="transmission-remote --add"

# Enable case-insensitive matching in case patterns
shopt -s nocasematch

# Require at least one argument
if [ -z "$1" ]; then
  echo "Usage: $0 <url>"
  exit 1
fi

# Normalize DuckDuckGo redirect links to the real URL
case "$1" in
  *duckduckgo.com/l/*)
    # Extract the embedded http(s) URL
    urlint="$(sed -E 's/.*(https?.*)/\1/' <<<"$1")"
    # URL-decode it via Python
    url="$(python3 -c "import urllib.parse as ul;print(ul.unquote_plus('$urlint'))")"
    ;;
  *)
    url="$1"
    ;;
esac

case "$url" in
  # Nitter images
  *nitter.*/pic/*)
    wget -qO /tmp/web.img -- "$url" && sxiv /tmp/web.img &
    ;;

  # TikTok short URLs
  *vt.tiktok*)
    "$VIDEO_CLIP" "$url" >/dev/null 2>&1 &
    ;;

  # Bibliogram image proxy
  *bibliogram.*/imageproxy*)
    wget -qO /tmp/web.img -- "$url" && sxiv /tmp/web.img &
    ;;

  # Bibliogram video proxy
  *bibliogram.*/videoproxy*)
    "$VIDEO_CLIP" "$url" >/dev/null 2>&1 &
    ;;

  # Gfycat / Streamable (convert .gifv → .webm for mpv)
  *gfycat.com/* | *streamable.com/*)
    u="${url/.gifv/.webm}"
    "$VIDEO_CLIP" "$u" >/dev/null 2>&1 &
    ;;

  # Reddit hosted video / Twitter video / Dailymotion
  *v.redd.it/* | *video.twimg.com/* | *dailymotion.com*)
    "$VIDEO_CLIP" "$url" >/dev/null 2>&1 &
    ;;

  # Invidious frontends
  *invidious*)
    "$VIDEO_CLIP" "$url" >/dev/null 2>&1 &
    ;;

  # YouTube, youtu.be and Twitch clips
  *youtube.com/watch* | *youtu.be/* | *clips.twitch.tv/*)
    "$VIDEO_CLIP" "$url" >/dev/null 2>&1 &
    ;;

  # Twitch channels / streams
  *twitch.tv/*)
    "$VIDEO_CLIP" "$url" >/dev/null 2>&1 &
    ;;

  # Imgur video-like content
  *i.imgur.com/*.gifv | *i.imgur.com/*.mp4 | *i.imgur.com/*.webm | *i.imgur.com/*.gif )
    "$VIDEO_CLIP" "$url" >/dev/null 2>&1 &
    ;;

  # Imgur static images
  *i.imgur.com/* | *imgur.com/*.*)
    wget -qO /tmp/web.img -- "$url" && sxiv /tmp/web.img &
    ;;

  # mailto: links – open in neomutt inside kitty
  mailto:*)
    kitty e neomutt -- "$url" &
    ;;

  # Playlists (audio/video)
  *.pls | *.m3u)
    "$VIDEO_CLIP" "$url" >/dev/null 2>&1 &
    ;;

  # Torrents / magnet links
  magnet:* | *.torrent)
    $TORRENTCLI "$url"
    ;;

  # Direct image URLs (+ Twitter :large variant)
  *.jpg | *.jpeg | *.png | *:large)
    current_time=$(date +%s%N)
    tmp="/tmp/web-${current_time}.img"
    wget -qO "$tmp" -- "$url" && sxiv "$tmp" &
    ;;

  # PDFs – download then open with okular
  *.pdf)
    wget -qO /tmp/web.pdf -- "$url" && okular /tmp/web.pdf &
    ;;

  # GIFs – treat as video
  *.gif)
    "$VIDEO_CLIP" "$url" >/dev/null 2>&1 &
    ;;

  # Video files
  *.mp4 | *.mkv | *.avi | *.wmv | *.m4v | *.mpg | *.mpeg | *.flv | *.ogm | *.ogv | *.gifv)
    nohup "$VIDEO_CLIP" "$url" >/dev/null 2>&1 &
    ;;

  # Audio files
  *.mp3 | *.m4a | *.wav | *.ogg | *.oga | *.flac)
    "$VIDEO_CLIP" "$url" >/dev/null 2>&1 &
    ;;

  # HTML – open in DEFAULT browser/editor
  *.html)
    nohup "$DEFAULT" "$url" >/dev/null 2>&1 &
    ;;

  # Fallback – anything else goes to DEFAULT
  *)
    nohup "$DEFAULT" "$url" >/dev/null 2>&1 &
    ;;
esac
