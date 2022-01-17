#.Bashrc

#############################################################################
##  _____                   _             _    ____      _                 ##
## |_   _|__ _ __ _ __ ___ (_)_ __   __ _| |  / ___|___ | | ___  _ __ ___  ##
##   | |/ _ \ '__| '_ ` _ \| | '_ \ / _` | | | |   / _ \| |/ _ \| '__/ __| ##
##   | |  __/ |  | | | | | | | | | | (_| | | | |__| (_) | | (_) | |  \__   ##
##   |_|\___|_|  |_| |_| |_|_|_| |_|\__,_|_|  \____\___/|_|\___/|_|  |___/ ##
##                                                                         ##
#############################################################################

if [[ $TERM == 'linux' ]]; then
    PS1="\[\033[1;37m\][\[\033[01;33m\]\u\[\033[1;31m\]@\[\033[01;34m\]\h \[\033[1;32m\]\W\[\033[1;37m\]]\[\033[1;33m\]\$\[\033[1;37m\] "
    paleofetch --recache
elif [[ $TERM == 'rxvt-unicode-256color' ]]; then
    PS1="\[\033[1;37m\][\[\033[01;33m\]\u\[\033[1;31m\]@\[\033[01;34m\]\h \[\033[1;32m\]\W\[\033[1;37m\]]\[\033[1;33m\]\$\[\033[1;36m\] "
    paleofetch --recache
elif [[ $TERM == 'screen-256color' ]]; then
    PS1="\[\033[1;37m\][\[\033[01;33m\]\u\[\033[1;31m\]@\[\033[01;34m\]\h \[\033[1;32m\]\W\[\033[1;37m\]]\[\033[1;33m\]\$\[\033[1;36m\] "
elif [[ $TERM == 'alacritty' ]]; then
    PS1="\[\033[1;37m\][\[\033[01;33m\]\u\[\033[1;31m\]@\[\033[01;34m\]\h \[\033[1;32m\]\W\[\033[1;37m\]]\[\033[1;33m\]\$\[\033[1;37m\] "
    paleofetch --recache 
else
    PS1="\[\033[0;30m\][\[\033[0;33m\]\u\[\033[1;31m\]@\[\033[01;34m\]\h \[\033[0;32m\]\W\[\033[0;30m\]]\[\033[0;33m\]\$\[\033[1;32m\] "
    paleofetch --recache 
fi

#Sourcing all files in .config/shellconfig/*
source /usr/share/autojump/autojump.bash
xrdb -merge "$HOME"/.Xresources &

source "$HOME"/.aliases/aliases
source "$HOME"/.aliases/functions

#echo -e "$($HOME/Downloads/archlogo.txt)"
source /usr/share/fzf/key-bindings.bash


# test -r ~/.dir_colors && eval $(dircolors ~/.dir_colors)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$("$HOME/Softwares/anaconda3/bin/conda" "shell.bash" "hook" 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/Softwares/anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/Softwares/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/Softwares/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# <<< conda initialize <<<
eval "$(starship init bash)"
