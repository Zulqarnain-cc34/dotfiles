# vim: set ft=fish :

# Activate vi mode
fish_vi_key_bindings
set fish_greeting

# Accelerate key bindings
set -U SXHKD_SHELL sh

# Default programs:
set -x EDITOR "nvim"
set -x TERMINAL "kitty"
set -x BROWSER "qutebrowser"

## Fuzzy finder
set -x FZF_DEFAULT_OPTS '--preview "~/.config/kitty/preview {}" --preview-window left:40%'
set -x FZF_EXCLUDE_GLOB '--glob "!.git/*" --glob "!.steam/*" --glob "!.local/share/Steam/*" --glob "!.void-packages/*"'
set -x FZF_DEFAULT_COMMAND "rg --files --hidden --follow $FZF_EXCLUDE_GLOB"
set -x FZF_FIND_FILE_COMMAND "rg --files --hidden --follow $FZF_EXCLUDE_GLOB"

# ~/ Clean-up:
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_DATA_HOME "$HOME/.local/share"
set -x XDG_CACHE_HOME "$HOME/.cache"
#set -x XAUTHORITY "$XDG_RUNTIME_DIR/Xauthority" # This line will break some DMs.
set -x NOTMUCH_CONFIG "$XDG_CONFIG_HOME/notmuch-config"
set -x GTK2_RC_FILES "$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
set -x LESSHISTFILE "-"
set -x WGETRC "$XDG_CONFIG_HOME/wget/wgetrc"
set -x INPUTRC "$XDG_CONFIG_HOME/inputrc"
set -x ZDOTDIR "$XDG_CONFIG_HOME/zsh"
#set -x GNUPGHOME "$XDG_DATA_HOME/gnupg"
set -x WINEPREFIX "$XDG_DATA_HOME/wineprefixes/default"
set -x PASSWORD_STORE_DIR "$XDG_DATA_HOME/password-store"
set -x TMUX_TMPDIR "$XDG_RUNTIME_DIR"
set -x ANDROID_SDK_HOME "$XDG_CONFIG_HOME/android"
set -x CARGO_HOME "$XDG_DATA_HOME/cargo"
set -x GOPATH "$XDG_DATA_HOME/go"
set -x ANSIBLE_CONFIG "$XDG_CONFIG_HOME/ansible/ansible.cfg"
set -x UNISON "$XDG_DATA_HOME/unison"
set -x HISTFILE "$XDG_DATA_HOME/history"

## PATH
set -x PATH "$PATH:$HOME/.gem/ruby/2.7.0/bin"
set -x PATH "$PATH:$HOME/.local/bin"
set -x PATH "$PATH:$HOME/.emacs.d/bin"
set -x PATH "$PATH:$HOME/bin"
set -x PATH "$PATH:$GOPATH/bin"

## Packages
set -x XBPS_DISTDIR "$HOME/.void-packages"

abbr v "xbpsui"

## Games
set -x SDL_AUDIODRIVER alsa

## Aliases

alias imv 'imv -c "exec _wid=\$(xdo id);xprop -f WM_CLIENT_MACHINE 8s -set WM_CLIENT_MACHINE \$(hostname) -id \$_wid;xprop -f _NET_WM_PID 32c -set _NET_WM_PID \$imv_pid -id \$_wid;pidswallow -gt \$_wid"'
alias wal 'wal -o bspwmrc'
alias powa 'sudo poweroff'
alias play 'env SOX_OPTS="--buffer 20000 --play-rate-arg -hs" play'
abbr - 'ssh'

## Utilities
abbr icat 'kitty +kitten icat'
abbr d "kitty +kitten diff"
abbr mpv 'mpv --no-input-default-bindings'
abbr music 'mpc -q play; ~/.config/ncmpcpp/art.sh; sleep 1; ~/.config/ncmpcpp/kitty.sh &; ncmpcpp'
abbr bars '~/.config/ncmpcpp/kitty.sh &; cava'
abbr weather 'curl wttr.in'
abbr rcp 'rsync -ah --progress'

## Web
abbr nico 'youtube-dl'
abbr yt 'youtube-dl -f bestvideo+bestaudio'                              # Youtube videos

## Torrent
abbr seed 'aria2c --check-integrity=true --seed-ratio=0.0 --bt-save-metadata=true'
abbr seed_today "aria2c --check-integrity=true --seed-ratio=0.0 (find . -maxdepth 1 -name '*.torrent' -mtime -1)"
abbr torrent 'aria2c --bt-metadata-only=true --bt-save-metadata=true'

## Navigation
abbr ls 'exa'   # ls with colors
abbr r 'vifm'

## Git
abbr g:a 'git add -A'
abbr g:c 'git commit -a'
abbr g:d 'git difftool --no-symlinks --dir-diff'
abbr g:i 'git init'
abbr g:l 'git pull'
abbr g:p 'git push'
abbr g:s 'git status'

## Functions
function git-replicate --description 'Copy git repository to new origin'
     git push origin +refs/remotes/origin/\*:refs/heads/\*
     git push origin --tags
end
function song --description 'Play current music'
    mpc insert $argv; mpc next
end

# Start X at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty &> ~/.cache/xorg.log
    end
end

if test -n "$DISPLAY"
    command -v xdo >/dev/null 2>&1
    xdo id > /tmp/term-wid-"$fish_pid"
end
trap "rm -f /tmp/term-wid-"$fish_pid"" EXIT HUP
