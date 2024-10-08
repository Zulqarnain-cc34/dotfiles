#! /usr/bin/bash

###################################################
##  _____  ___   _      ____   _____  ____   ____
## |  ___|/ _ \ | |    |  _ \ | ____||  _ \ / ___|
## | |_  | | | || |    | | | ||  _|  | |_) |\___ \
## |  _| | |_| || |___ | |_| || |___ |  _ <  ___) |
## |_|    \___/ |_____||____/ |_____||_| \_\|____/
##
###################################################

[ ! -d "$HOME"/.config/polybar ] && ln -s "$PWD"/polybar "$HOME"/.config/polybar
[ ! -d "$HOME"/.newsboat ] && ln -s "$PWD"/newsboat "$HOME"/.newsboat
[ ! -d "$HOME"/.config/transmission-daemon ] && ln -s "$PWD"/transmission-daemon "$HOME"/.config/transmission-daemon
[ ! -d "$HOME"/.config/rofi ] && ln -s "$PWD"/rofi "$HOME"/.config/rofi
[ ! -d "$HOME"/.config/urlscan ] && ln -s "$PWD"/urlscan "$HOME"/.config/urlscan
[ ! -d "$HOME"/.config/urlview ] && ln -s "$PWD"/urlview "$HOME"/.config/urlview
[ ! -d "$HOME"/.config/surfraw ] && ln -s "$PWD"/surfraw "$HOME"/.config/surfraw
[ ! -d "$HOME"/.config/ytfzf ] && ln -s "$PWD"/ytfzf "$HOME"/.config/ytfzf
[ ! -d "$HOME"/.w3m ] && ln -s "$PWD"/.w3m "$HOME"/.w3m
[ ! -d "$HOME"/.config/ranger ] && ln -s "$PWD"/ranger "$HOME"/.config/ranger
[ ! -d "$HOME"/.config/rofi-twitch ] && ln -s "$PWD"/rofi-twitch "$HOME"/.config/rofi-twitch
[ ! -d "$HOME"/.config/mutt ] && ln -s "$PWD"/mutt "$HOME"/.config/mutt
[ ! -d "$HOME"/.config/Kvantum ] && ln -s "$PWD"/Kvantum "$HOME"/.config/Kvantum
[ ! -d "$HOME"/.config/lf ] && ln -s "$PWD"/lf "$HOME"/.config/lf
[ ! -d "$HOME"/.config/mpv ] && ln -s "$PWD"/mpv "$HOME"/.config/mpv
[ ! -d "$HOME"/.mutt ] && ln -s "$PWD"/.mutt "$HOME"/.mutt
[ ! -d "$HOME"/.config/dunst ] && ln -s "$PWD"/dunst "$HOME"/.config/dunst
[ ! -d "$HOME"/.config/alacritty ] && ln -s "$PWD"/alacritty "$HOME"/.config/alacritty
[ ! -d "$HOME"/.config/nvim ] && ln -s "$PWD"/nvim "$HOME"/.config/nvim
[ ! -d "$HOME"/.config/zsh ] && ln -s "$PWD"/zsh "$HOME"/.config/zsh
[ ! -d "$HOME"/.config/conky ] && ln -s "$PWD"/conky "$HOME"/.config/conky
[ ! -d "$HOME"/.config/bspwm ] && ln -s "$PWD"/bspwm "$HOME"/.config/bspwm
[ ! -d "$HOME"/.config/sxhkd ] && ln -s "$PWD"/sxhkd "$HOME"/.config/sxhkd
[ ! -d "$HOME"/.config/eww ] && ln -s "$PWD"/eww "$HOME"/.config/eww
[ ! -d "$HOME"/.config/qutebrowser ] && ln -s "$PWD"/qutebrowser "$HOME"/.config/qutebrowser
[ ! -d "$HOME"/.config/zathura ] && ln -s "$PWD"/zathura "$HOME"/.config/zathura
[ ! -d "$HOME"/.config/mpd ] && ln -s "$PWD"/mpd "$HOME"/.config/mpd
[ ! -d "$HOME"/.config/ncmpcpp ] && ln -s "$PWD"/ncmpcpp "$HOME"/.config/ncmpcpp
[ ! -d "$HOME"/.config/vivid ] && ln -s "$PWD"/vivid "$HOME"/.config/vivid
[ ! -d "$HOME"/.config/fish ] && ln -s "$PWD"/fish "$HOME"/.config/fish
[ ! -d "$HOME"/.config/imv ] && ln -s "$PWD"/imv "$HOME"/.config/imv
[ ! -d "$HOME"/.config/kitty ] && ln -s "$PWD"/kitty "$HOME"/.config/kitty

##################################
## _____  ___  _      _____  ____
## |  ___||_ _|| |    | ____|/ ___|
## | |_    | | | |    |  _|  \___ \
## |  _|   | | | |___ | |___  ___) |
## |_|    |___||_____||_____||____/
##
###################################

[ ! -f "$HOME"/.config/mimeapps.list ] && ln -s "$PWD"/mimeapps.list "$HOME"/.config/mimeapps.list
[ ! -f "$HOME"/.config/starship.toml ] && ln -s "$PWD"/starship.toml "$HOME"/.config/starship.toml
[ ! -f "$HOME"/.config/twitchnotifier.cfg ] && ln -s "$PWD"/twitchnotifier.cfg "$HOME"/.config/twitchnotifier.cfg
[ ! -f "$HOME"/.bashrc ] && ln -s "$PWD"/.bashrc "$HOME"/.bashrc
[ ! -f "$HOME"/.bash_profile ] && ln -s "$PWD"/.bash_profile "$HOME"/.bash_profile
[ ! -f "$HOME"/.gitconfig ] && ln -s "$PWD"/.gitconfig "$HOME"/.gitconfig
[ ! -f "$HOME"/.Xresources ] && ln -s "$PWD"/.Xresources "$HOME"/.Xresources
[ ! -f "$HOME"/.tmux.conf ] && ln -s "$PWD"/.tmux.conf "$HOME"/.tmux.conf
[ ! -f "$HOME"/.Xmodmap ] && ln -s "$PWD"/.Xmodmap "$HOME"/.Xmodmap
[ ! -f "$HOME"/.profile ] && ln -s "$PWD"/.profile "$HOME"/.profile
[ ! -f "$HOME"/.inputrc ] && ln -s "$PWD"/.inputrc "$HOME"/.inputrc
[ ! -f "$HOME"/.config/picom.conf ] && ln -s "$PWD"/picom.conf "$HOME"/.config/picom.conf
[ ! -f "$HOME"/.xprofile ] && ln -s "$PWD"/.xprofile "$HOME"/.xprofile
[ ! -f "$HOME"/.zprofile ] && ln -s "$PWD"/.zprofile "$HOME"/.zprofile
[ ! -f "$HOME"/.dir_colors ] && ln -s "$PWD"/.dir_colors "$HOME"/.dir_colors
