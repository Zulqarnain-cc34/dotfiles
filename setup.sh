#! /usr/bin/bash

###################################################
##  _____  ___   _      ____   _____  ____   ____
## |  ___|/ _ \ | |    |  _ \ | ____||  _ \ / ___|
## | |_  | | | || |    | | | ||  _|  | |_) |\___ \
## |  _| | |_| || |___ | |_| || |___ |  _ <  ___) |
## |_|    \___/ |_____||____/ |_____||_| \_\|____/
##
###################################################

[ ! -d $HOME/.config/polybar ] && ln -s $PWD/polybar $HOME/.config/polybar
[ ! -d $HOME/.newsboat ] && ln -s $PWD/newsboat $HOME/.newsboat
[ ! -d $HOME/.config/transmission-daemon ] && ln -s $PWD/transmission-daemon $HOME/.config/transmission-daemon
[ ! -d $HOME/.config/rofi ] && ln -s $PWD/rofi $HOME/.config/rofi
[ ! -d $HOME/.config/urlscan ] && ln -s $PWD/urlscan $HOME/.config/urlscan
[ ! -d $HOME/.config/urlview ] && ln -s $PWD/urlview $HOME/.config/urlview
[ ! -d $HOME/.config/surfraw ] && ln -s $PWD/surfraw $HOME/.config/surfraw
[ ! -d $HOME/.config/ytfzf ] && ln -s $PWD/ytfzf $HOME/.config/ytfzf
[ ! -d $HOME/.w3m ] && ln -s $PWD/.w3m $HOME/.w3m
[ ! -d $HOME/.vim_runtime ] && ln -s $PWD/.vim_runtime $HOME/.vim_runtime
[ ! -d $HOME/.config/ranger ] && ln -s $PWD/ranger $HOME/.config/ranger
[ ! -d $HOME/.config/rofi-twitch ] && ln -s $PWD/rofi-twitch $HOME/.config/rofi-twitch
[ ! -d $HOME/.config/mutt ] && ln -s $PWD/mutt $HOME/.config/mutt
[ ! -d $HOME/.config/Kvantum ] && ln -s $PWD/Kvantum $HOME/.config/Kvantum
[ ! -d $HOME/.config/lf ] && ln -s $PWD/lf $HOME/.config/lf
[ ! -d $HOME/.local/share/sddm ] && ln -s $PWD/sddm $HOME/.local/share/sddm
[ ! -d $HOME/.local/share/themes ] && ln -s $PWD/themes $HOME/.local/share/themes
[ ! -d $HOME/.config/mpv ] && ln -s $PWD/mpv $HOME/.config/mpv
[ ! -d $HOME/.mutt ] && ln -s $PWD/.mutt $HOME/.mutt
[ ! -d $HOME/.config/dunst ] && ln -s $PWD/dunst $HOME/.config/dunst
[ ! -d $HOME/.config/alacritty ] && ln -s $PWD/alacritty $HOME/.config/alacritty

##################################
## _____  ___  _      _____  ____
## |  ___||_ _|| |    | ____|/ ___|
## | |_    | | | |    |  _|  \___ \
## |  _|   | | | |___ | |___  ___) |
## |_|    |___||_____||_____||____/
##
###################################

[ ! -f $HOME/.config/mimeapps.list ] && ln -s $PWD/mimeapps.list $HOME/.config/mimeapps.list
[ ! -f $HOME/.config/starship.toml ] && ln -s $PWD/starship.toml $HOME/.config/starship.toml
[ ! -f $HOME/.config/twitchnotifier.cfg ] && ln -s $PWD/twitchnotifier.cfg $HOME/.config/twitchnotifier.cfg
[ ! -f $HOME/.bashrc ] && ln -s $PWD/.bashrc $HOME/.bashrc
[ ! -f $HOME/.bash_profile ] && ln -s $PWD/.bash_profile $HOME/.bash_profile
[ ! -f $HOME/.gitconfig ] && ln -s $PWD/.gitconfig $HOME/.gitconfig
[ ! -f $HOME/.Xresources ] && ln -s $PWD/.Xresources $HOME/.Xresources
[ ! -f $HOME/.tmux.conf ] && ln -s $PWD/.tmux.conf $HOME/.tmux.conf
[ ! -f $HOME/.Xmodmap ] && ln -s $PWD/.Xmodmap $HOME/.Xmodmap
[ ! -f $HOME/.vimrc ] && ln -s $PWD/.vimrc $HOME/.vimrc
[ ! -f $HOME/.profile ] && ln -s $PWD/.profile $HOME/.profile
[ ! -f $HOME/.inputrc ] && ln -s $PWD/.inputrc $HOME/.inputrc
[ ! -f $HOME/.config/picom.conf ] && ln -s $PWD/picom.conf $HOME/.config/picom.conf
[ ! -f $HOME/.xprofile ] && ln -s $PWD/.xprofile $HOME/.xprofile
