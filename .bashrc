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
    # paleofetch --recache
elif [[ $TERM == 'rxvt-unicode-256color' ]]; then
    PS1="\[\033[1;37m\][\[\033[01;33m\]\u\[\033[1;31m\]@\[\033[01;34m\]\h \[\033[1;32m\]\W\[\033[1;37m\]]\[\033[1;33m\]\$\[\033[1;36m\] "
    # paleofetch --recache
elif [[ $TERM == 'screen-256color' ]]; then
    PS1="\[\033[1;37m\][\[\033[01;33m\]\u\[\033[1;31m\]@\[\033[01;34m\]\h \[\033[1;32m\]\W\[\033[1;37m\]]\[\033[1;33m\]\$\[\033[1;36m\] "
elif [[ $TERM == 'alacritty' ]]; then
    PS1="\[\033[1;37m\][\[\033[01;33m\]\u\[\033[1;31m\]@\[\033[01;34m\]\h \[\033[1;32m\]\W\[\033[1;37m\]]\[\033[1;33m\]\$\[\033[1;37m\] "
    # paleofetch --recache 
else
    PS1="\[\033[0;30m\][\[\033[0;33m\]\u\[\033[1;31m\]@\[\033[01;34m\]\h \[\033[0;32m\]\W\[\033[0;30m\]]\[\033[0;33m\]\$\[\033[1;32m\] "
    # paleofetch --recache 
fi

#Sourcing all files in .config/shellconfig/*
[ -f /usr/share/autojump/autojump.bash ] && source /usr/share/autojump/autojump.bash
# xrdb -merge "$HOME"/.Xresources &

[ -f "$HOME"/.aliases/aliases ] && source "$HOME"/.aliases/aliases
[ -f "$HOME"/.aliases/functions ] && source "$HOME"/.aliases/functions

#echo -e "$($HOME/Downloads/archlogo.txt)"
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash

# Generate LS_COLORS with vivid if available (matches zsh behavior)
if command -v vivid >/dev/null 2>&1; then
    export LS_COLORS="$(vivid generate one-dark)"
fi

# test -r ~/.dir_colors && eval $(dircolors ~/.dir_colors)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# NOTE: Conda initialization is disabled to avoid slow bash startup.
# To enable conda in bash, uncomment the block below or run 'conda init bash'
# __conda_setup="$("$HOME/Softwares/anaconda3/bin/conda" "shell.bash" "hook" 2>/dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "$HOME/Softwares/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "$HOME/Softwares/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="$HOME/Softwares/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
#
# # <<< conda initialize <<<

# NOTE: Starship prompt is disabled in bash to use the custom PS1 prompt defined above.
# Zsh uses starship via fastfetch. To enable starship in bash, uncomment the line below:
# eval "$(starship init bash)"

# Lazy-load NVM for faster bash startup (matches zsh behavior)
export NVM_DIR="$HOME/.config/nvm"
nvm() {
  unset -f nvm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  nvm "$@"
}

