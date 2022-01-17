export NPM_PACKAGES="$HOME/.npm-packages"

# Default Apps
export BROWSERCLI="w3m"
export BROWSER="firefox"
export TERMINAL="urxvt"
export EDITOR=nvim
export RTV_BROWSER=~/.scripts/urlportal.sh
export TERM="alacritty"

export PATH="$PATH:/usr/local/opt/coreutils/libexec/gnubin"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

# GTk scaling
export GDK_DPI_SCALE=0.7

# Fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export SDL_IM_MODULE=fcitx
export XMODIFIERS='@im=fcitx'

# Aliases
export WGETRC="$HOME/.config/wget/wgetrc"
export NEWSBOAT_BOOKMARKS="$HOME/bin/bash_scripts/newsboat/dangerzone/bookmark.sh"
export MUSIC="$HOME/Videos/Audios/*"
export CONFIG_BACKUP="$HOME/etc/linuxConfig/dotfiles/"
export IMAGES_DIR="$HOME/Pictures/Pictures/"
export VIDEOS_DIR="$HOME/Videos/videos/"
export BOOKDIR="$HOME/Documents/Books/*"
export ALIASDIR="$HOME/.aliases/aliases"

# XDG
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"

# Man
unset MANPATH # delete if you already modified MANPATH elsewhere in your configuration
export MANPATH
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
export QT_QPA_PLATFORMTHEME="qt5ct"


# LESS COLORS
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --layout=reverse
    --inline-info
    --color=dark
    --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
    --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
'
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export PATH="$HOME/etc/Programs/paleofetch:$PATH"

# Sourcing paths
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/bin/binaries" ]; then
    PATH="$PATH:$HOME/bin/binaries"
fi

if [ -d "$HOME/bin/bash_scripts" ]; then
    PATH="$PATH:$HOME/bin/bash_scripts"
fi

if [ -d "$NPM_PACKAGES/bin" ]; then
    PATH="$NPM_PACKAGES/bin:$PATH"
fi

export GOBIN="$HOME/.local/go"
export PATH="$PATH:$HOME/.local/go"
# export PATH= "$PATH:$HOME/.cargo/env"


export LF_ICONS="di=:fi=:ln=:or=:ex=:*.vimrc=:*.viminfo=:*.gitignore=:*.c=:*.cc=:*.clj=:*.coffee=:*.cpp=:*.css=:*.d=:*.dart=:*.erl=:*.exs=:*.fs=:*.go=:*.h=:*.hh=:*.hpp=:*.hs=:*.html=:*.java=:*.jl=:*.js=:*.json=:*.lua=:*.md=:*.php=:*.pl=:*.pro=:*.py=:*.rb=:*.rs=:*.scala=:*.ts=:*.vim=:*.cmd=:*.ps2=:*.sh=:*.bash=:*.zsh=:*.fish=:*.tar=:*.tgz=:*.arc=:*.arj=:*.taz=:*.lha=:*.lz4=:*.lzh=:*.lzma=:*.tlz=:*.txz=:*.tzo=:*.t7z=:*.zip=:*.z=:*.dz=:*.gz=:*.lrz=:*.lz=:*.lzo=:*.xz=:*.zst=:*.tzst=:*.bz2=:*.bz=:*.tbz=:*.tbz2=:*.tz=:*.deb=:*.rpm=:*.jar=:*.war=:*.ear=:*.sar=:*.rar=:*.alz=:*.ace=:*.zoo=:*.cpio=:*.7z=:*.rz=:*.cab=:*.wim=:*.swm=:*.dwm=:*.esd=:*.jpg=:*.jpeg=:*.mjpg=:*.mjpeg=:*.gif=:*.bmp=:*.pbm=:*.pgm=:*.ppm=:*.tga=:*.xb=:*.xpm=:*.tif=:*.tiff=:*.png=:*.svg=:*.svgz=:*.mng=:*.pcx=:*.mov=:*.mpg=:*.mpeg=:*.m2v=:*.mkv=:*.webm=:*.ogm=:*.mp4=:*.m4v=:*.mp4v=:*.vob=:*.qt=:*.nuv=:*.wmv=:*.asf=:*.rm=:*.rmvb=:*.flc=:*.avi=:*.fli=:*.flv=:*.gl=:*.dl=:*.xcf=:*.xwd=:*.yuv=:*.cgm=:*.emf=:*.ogv=:*.ogx=:*.aac=:*.au=:*.flac=:*.m4a=:*.mid=:*.midi=:*.mka=:*.mp3=:*.mpc=:*.ogg=:*.ra=:*.wav=:*.oga=:*.opus=:*.spx=:*.xspf=:*.pdf=:*.nix=:m"



#######################################################################
#                                 Man Colors
#######################################################################

# Default Man colors

#export LESS_TERMCAP_mb=$'\e[1;32m'
#export LESS_TERMCAP_md=$'\e[1;32m'
#export LESS_TERMCAP_me=$'\e[0m'
#export LESS_TERMCAP_se=$'\e[0m'
#export LESS_TERMCAP_so=$'\e[01;33m'
#export LESS_TERMCAP_ue=$'\e[0m'
#export LESS_TERMCAP_us=$'\e[1;4;31m'

# Man Red Colors

#export LESS_TERMCAP_md=$'\e[01;31m'
#export LESS_TERMCAP_me=$'\e[0m'
#export LESS_TERMCAP_so=$'\e[01;44;33m'
#export LESS_TERMCAP_se=$'\e[0m'
#export LESS_TERMCAP_us=$'\e[01;32m'
#export LESS_TERMCAP_ue=$'\e[0m'
# Checking Path variables

# Man Yellow display colours
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
export LESS_TERMCAP_us=$'\e[01;37m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal


#export LS_COLORS="$(dircolors ~/.dircolors)"
#export LS_COLORS="\
#*.html=95:\
#*.php=1;32:\
#di=1;33:\
#no=00:\
#fi=1;255:\
#ln=01;36:\
#pi=40;33:\
#so=01;35:\
#do=01;35:\
#bd=40;33;01:\
#cd=40;33;01:\
#or=40;31;01:\
#su=37;41:\
#sg=30;43:\
#tw=30;42:\
#ow=1;00;94:\
#st=37;44:\
#ex=0;32:\
#*.tar=01;31:\
#*.tgz=01;31:\
#*.zip=01;31:\
#*.gz=01;31:\
#*.bz2=01;31:\
#*.jpg=01;35:\
#*.jpeg=01;35:\
#*.gif=01;35:\
#*.bmp=01;35:\
#*.png=01;35:\
#*.mp4=0;35;34:\
#*.iso=1;31:\
#*.pdf=0;34"


 #export LF_ICONS="\
#di=:\
#fi=:\
#ln=:\
#or=:\
#ex=:\
#*.vimrc=:\
#*.viminfo=:\
#*.gitignore=:\
#*.c=:\
#*.cc=:\
#*.clj=:\
#*.coffee=:\
#*.cpp=:\
#*.css=:\
#*.d=:\
#*.dart=:\
#*.erl=:\
#*.exs=:\
#*.fs=:\
#*.go=:\
#*.h=:\
#*.hh=:\
#*.hpp=:\
#*.hs=:\
#*.html=:\
#*.java=:\
#*.jl=:\
#*.js=:\
#*.json=:\
#*.lua=:\
#*.md=:\
#*.php=:\
#*.pl=:\
#*.pro=:\
#*.py=:\
#*.rb=:\
#*.rs=:\
#*.scala=:\
#*.ts=:\
#*.vim=:\
#*.cmd=:\
#*.ps1=:\
#*.sh=:\
#*.bash=:\
#*.zsh=:\
#*.fish=:\
#*.tar=:\
#*.tgz=:\
#*.arc=:\
#*.arj=:\
#*.taz=:\
#*.lha=:\
#*.lz4=:\
#*.lzh=:\
#*.lzma=:\
#*.tlz=:\
#*.txz=:\
#*.tzo=:\
#*.t7z=:\
#*.zip=:\
#*.z=:\
#*.dz=:\
#*.gz=:\
#*.lrz=:\
#*.lz=:\
#*.lzo=:\
#*.xz=:\
#*.zst=:\
#*.tzst=:\
#*.bz2=:\
#*.bz=:\
#*.tbz=:\
#*.tbz2=:\
#*.tz=:\
#*.deb=:\
#*.rpm=:\
#*.jar=:\
#*.war=:\
#*.ear=:\
#*.sar=:\
#*.rar=:\
#*.alz=:\
#*.ace=:\
#*.zoo=:\
#*.cpio=:\
#*.7z=:\
#*.rz=:\
#*.cab=:\
#*.wim=:\
#*.swm=:\
#*.dwm=:\
#*.esd=:\
#*.jpg=:\
#*.jpeg=:\
#*.mjpg=:\
#*.mjpeg=:\
#*.gif=:\
#*.bmp=:\
#*.pbm=:\
#*.pgm=:\
#*.ppm=:\
#*.tga=:\
#*.xbm=:\
#*.xpm=:\
#*.tif=:\
#*.tiff=:\
#*.png=:\
#*.svg=:\
#*.svgz=:\
#*.mng=:\
#*.pcx=:\
#*.mov=:\
#*.mpg=:\
#*.mpeg=:\
#*.m2v=:\
#*.mkv=:\
#*.webm=:\
#*.ogm=:\
#*.mp4=:\
#*.m4v=:\
#*.mp4v=:\
#*.vob=:\
#*.qt=:\
#*.nuv=:\
#*.wmv=:\
#*.asf=:\
#*.rm=:\
#*.rmvb=:\
#*.flc=:\
#*.avi=:\
#*.fli=:\
#*.flv=:\
#*.gl=:\
#*.dl=:\
#*.xcf=:\
#*.xwd=:\
#*.yuv=:\
#*.cgm=:\
#*.emf=:\
#*.ogv=:\
#*.ogx=:\
#*.aac=:\
#*.au=:\
#*.flac=:\
#*.m4a=:\
#*.mid=:\
#*.midi=:\
#*.mka=:\
#*.mp3=:\
#*.mpc=:\
#*.ogg=:\
#*.ra=:\
#*.wav=:\
#*.oga=:\
#*.opus=:\
#*.spx=:\
#*.xspf=:\
#*.pdf=:\
#*.nix=:\
#"

