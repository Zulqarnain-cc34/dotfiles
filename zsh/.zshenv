typeset -U PATH path

export NPM_CONFIG_PREFIX="$HOME/.local"
export PATH="$HOME/.local/bin:$PATH"

# NOTE: XDG variables and GDK_DPI_SCALE are defined in .profile and inherited. 
# This avoids duplication and ensures consistency across shells

export JAVA_HOME="/usr/lib/jvm/java-8-openjdk"
case ":$PATH:" in
  *":$JAVA_HOME/bin:"*) ;;
  *) PATH="$JAVA_HOME/bin:$PATH" ;;
esac 

export EDITOR="nvim"
export READER="zathura"
export VISUAL="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"
export VIDEO="mpv"
export IMAGE="sxiv"
export COLORTERM="truecolor"
export OPENER="xdg-open"
export PAGER="less"
export WM="bspwm"

export WGETRC="$HOME/.wgetrc"
export NEWSBOAT_BOOKMARKS="$HOME/bin/bash_scripts/newsboat/dangerzone/bookmark.sh"
export MUSIC="$HOME/Videos/Audios/*"
export CONFIG_BACKUP="$HOME/etc/linuxConfig/dotfiles_v2/"
export IMAGES_DIR="$HOME/Pictures/Pictures/"
export VIDEOS_DIR="$HOME/Videos/videos/"
export BOOKDIR="$HOME/Documents/Books/"
export ALIASDIR="$HOME/.aliases/aliases"
export RTV_BROWSER="$HOME/bin/bash_scripts/urlportal.sh"

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

# NOTE: Commented out - uncomment and update paths if using Hadoop/Spark

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

export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;33m'
export LESS_TERMCAP_so=$'\e[01;44;37m'
export LESS_TERMCAP_us=$'\e[01;37m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'
export GROFF_NO_SGR=1
