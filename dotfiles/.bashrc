# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s checkhash		# Build hash of commands run, check hash before PATH
shopt -s checkjobs		# Require confirmation to exit with jobs running
shopt -s checkwinsize	# Check window size after commands, update if necessary
shopt -s globstar		# ** globs to all files and zero+ dirs and subdirs
shopt -s histappend		# append to the history file, don't overwrite it
HISTSIZE=				# Store 1000 history entries in memory
HISTFILESIZE=25000		# Store 25000 lines of history in $HISTFILE
HISTCONTROL=ignoreboth	# Ignore duplicate lines and lines starting with a space

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	[ -r ~/.dircolors ] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto -F'
	alias dir='dir --color=auto'
	alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# enable programmable completion features
if [ -r /etc/bash_completion ] && ! shopt -oq posix; then
	source /etc/bash_completion
fi

# Automagical preprocessing of arguments to less
if [ -x /usr/bin/lesspipe ] ; then
	LESSOPEN="| lesspipe %s" && export LESSOPEN
fi

# Set PS1
# Pretty colors
red='\[\e[0;31m\]'
cyan='\[\e[0;36m\]'
blue='\[\e[0;34m\]'
green='\[\e[0;32m\]'
norm='\[\e[m\]'

# Username
un="${green}\\u${norm}"

# At
at="${green}@${norm}"

# Hostname
hn="${green}\\h${norm}"

# Present directory
pd="${blue}\\w${norm}"

# Colour $ red if in an ssh session
if [ -n "$SSH_CLIENT" -o -n "$SSH2_CLIENT" ]; then
	ps="$red\\\$$norm"
else
	ps='\$'
fi

# If we are in a "subshell" for this host, colour the brackets cyan
if [[ $SHLVL -lt 2 || $0 =~ -.+ ]] ; then
	lb='['
	rb=']'
else
	lb="$cyan[$norm"
	rb="$cyan]$norm"
fi

# Prompt of the form [user@host pwd]$
export PS1="${lb}${un}${at}${hn} ${pd}${rb}${ps} "

# Get rid of all of the garbage we just defined
unset red cyan blue green norm un hn pd ps lb rb

# make Vim the default editor and man viewer if it exists
if [ -x /usr/bin/vim ]; then
	export EDITOR=/usr/bin/vim

	# Alias man to a script that detects pipes to set MANPAGER appropriately
	if [ -x ~/bin/man.sh ] ; then
		alias man=~/bin/man.sh
	fi
fi

# Source any local options that may exist
if [ -r ~/.bashrc.local ]; then
	source ~/.bashrc.local
fi

# Source alias definitions
if [ -r ~/.bash_aliases ]; then
	source ~/.bash_aliases
fi
