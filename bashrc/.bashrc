#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1="\[\033[38;5;46m\]\u\[$(tput sgr0)\]\[\033[38;5;128m\]@\[$(tput sgr0)\]\[\033[38;5;46m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \W\[$(tput sgr0)\]\[\033[38;5;128m\]]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

alias journalctl='sudo journalctl'
alias pacrepo='sudo reflector -l 20 -f 10 --save /etc/pacman.d/mirrorlist'
alias pacman='sudo pacman'
alias upgrade='sudo pacman -Syu'
alias install='sudo pacman -S'
alias delete='sudo pacman -Rs'
alias search='sudo pacman -Ss'
alias auru='yaourt -Syua --noconfirm'
alias systemctl='sudo systemctl'
alias se='ls /usr/bin | grep'
alias files='ranger'

export EDITOR=vim
export QT_STYLE_OVERRIDE=gtk
export QT_SELECT=qt5

if [[ $LANG = '' ]]; then
	export LANG=se_SE.UTF-8
fi

# Directory handling
alias d="dirs -v"
alias 1="pushd +1"
alias 2="pushd +2"
alias 3="pushd +3"
alias 4="pushd +4"
alias 5="pushd +5"
alias 6="pushd +6"
alias 7="pushd +7"
alias 8="pushd +8"
alias 9="pushd +9"
alias sd="pushd "$@""
alias ed="dirs -c"
function lcd {
  builtin cd "$@" && ls -l
}

function gf {
  if [[ -z "$@" ]] ; then
    git ls-files
  else
    if [[ "$#" -lt 2 ]] ; then
      git ls-files | grep "$1"
    else
      git ls-files "$2" | grep "$1"
    fi
  fi
}

function gg {
  if [[ -z "$@" ]] ; then
    # Display usage of function
    echo "Usage of gg <string> <path>"
  else
    if [[ "$#" -lt 2 ]] ; then
      git grep -i "$1" .
    else
      git grep -i "$1" "$2"
    fi
  fi
}


alias h="history"
alias j="jobs -l"
alias ll="ls -l"
alias ls='ls --color=auto'
if [ "x$TERM" = "xxterm" ]
then
    export TERM="xterm-256color"
fi
