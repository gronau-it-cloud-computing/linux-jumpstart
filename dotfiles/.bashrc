# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto -F'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Add any local options that may exist
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Set PS1
# Pretty colors
red='\[\e[0;31m\]'
cyan='\[\e[0;36m\]'
blue='\[\e[0;34m\]'
green='\[\e[0;32m\]'
norm='\[\e[m\]'

# Colour $ red if in an ssh session
if [ -n "$SSH_CLIENT" ]; then
	ps="$red\\\$$norm"
else
	ps='\$'
fi
if [ "$SHLVL" != "1" ]; then
	lb="$cyan[$norm"
	rb="$cyan]$norm"
else
	lb='['
	rb=']'
fi

export PS1="$lb$green\u@\h $blue\w$norm$rb$ps "

shopt -s extglob
set -o emacs

# make vim the default editor and man viewer if it exists
if [ -x /usr/bin/vim ]; then
	export EDITOR=/usr/bin/vim
	export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
		vim -R -c 'set ft=man fdm=indent fdn=1 fen nomod noma nolist nonu' \
		-c 'map q :q<CR>' -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
		-c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""
fi
