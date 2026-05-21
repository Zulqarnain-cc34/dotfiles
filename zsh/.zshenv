typeset -U PATH path

# Fcitx
# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
# export SDL_IM_MODULE=fcitx
# export XMODIFIERS='@im=fcitx'
#
export NPM_CONFIG_PREFIX="$HOME/.local"
export PATH="$HOME/.local/bin:$PATH"

# NOTE: XDG variables and GDK_DPI_SCALE are defined in .profile and inherited
# This avoids duplication and ensures consistency across shells

# Scaling
# export QT_AUTO_SCREEN_SCALE_FACTOR=0
# export QT_SCALE_FACTOR=1
# export QT_SCREEN_SCALE_FACTORS="1;1;1"
# export GDK_SCALE=1
# export GDK_DPI_SCALE=1

# Fixing Paths
# export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
# export XSERVERRC="$XDG_CONFIG_HOME"/X11/xserverrc
# export ZDOTDIR=$HOME/.config/zsh


# java for sdkmanager flutter
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk"
case ":$PATH:" in
  *":$JAVA_HOME/bin:"*) ;;
  *) PATH="$JAVA_HOME/bin:$PATH" ;;
esac 

# Default Apps
export EDITOR="nvim"
export READER="zathura"
export VISUAL="nvim"
export TERMINAL="kitty"  # Consistent with .profile
export BROWSER="firefox"
export VIDEO="mpv"
export IMAGE="sxiv"
export COLORTERM="truecolor"
export OPENER="xdg-open"
export PAGER="less"
export WM="bspwm"

# Others aliases
export WGETRC="$HOME/.wgetrc"
export NEWSBOAT_BOOKMARKS="$HOME/bin/bash_scripts/newsboat/dangerzone/bookmark.sh"
export MUSIC="$HOME/Videos/Audios/*"
export CONFIG_BACKUP="$HOME/etc/linuxConfig/dotfiles_v2/"
export IMAGES_DIR="$HOME/Pictures/Pictures/"
export VIDEOS_DIR="$HOME/Videos/videos/"
export BOOKDIR="$HOME/Documents/Books/"
export ALIASDIR="$HOME/.aliases/aliases"
export RTV_BROWSER="$HOME/bin/bash_scripts/urlportal.sh"

# export MANPATH
# MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
# export QT_QPA_PLATFORMTHEME="qt5ct"

# Fzf COLORS
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --layout=reverse
    --inline-info
    --color=dark
    --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
    --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
'
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

if command -v vivid >/dev/null 2>&1; then
    export LS_COLORS="$(vivid generate one-dark)"
fi

#Hadoop Related Options
# NOTE: Commented out - uncomment and update paths if using Hadoop/Spark

# export HADOOP_HOME=$HOME/program_files/binaries/Hadoop_Stack/hadoop-3.3.4
# export HADOOP_INSTALL=$HADOOP_HOME
# export HADOOP_MAPRED_HOME=$HADOOP_HOME
# export HADOOP_COMMON_HOME=$HADOOP_HOME
# export HADOOP_HDFS_HOME=$HADOOP_HOME
# export YARN_HOME=$HADOOP_HOME
# export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
# export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
# export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/nativ"
#
# export HIVE_HOME="$HOME/program_files/binaries/Hadoop_Stack/apache-hive-3.1.3-bin"
# export PATH=$PATH:$HIVE_HOME/bin
#
# export SPARK_HOME="$HOME/program_files/binaries/Hadoop_Stack/spark-3.3.1-bin-hadoop"
# export PATH=$PATH:$SPARK_HOME/bin
# export PYTHONPATH=${SPARK_HOME}/python/:$(echo ${SPARK_HOME}/python/lib/py4j-*-src.zip):${PYTHONPATH}
#
#Path
# Idempotent PATH additions (won't duplicate on nested shells)
case ":$PATH:" in
  *":$HOME/bin:"*) ;;
  *) [ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH" ;;
esac

case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) [ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH" ;;
esac

case ":$PATH:" in
  *":$HOME/bin/binaries:"*) ;;
  *) [ -d "$HOME/bin/binaries" ] && PATH="$PATH:$HOME/bin/binaries" ;;
esac

case ":$PATH:" in
  *":$HOME/bin/bash_scripts:"*) ;;
  *) [ -d "$HOME/bin/bash_scripts" ] && PATH="$PATH:$HOME/bin/bash_scripts" ;;
esac

export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
case ":$PATH:" in
  *":$GOBIN:"*) ;;
  *) PATH="$GOBIN:$PATH" ;;
esac

# LESS COLORS
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
export LESS_TERMCAP_us=$'\e[01;37m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal
