# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s checkhash		# Build hash of commands run, check hash before PATH
shopt -s checkjobs		# Require confirmation to exit with jobs running
shopt -s checkwinsize	# Check window size after commands, update if necessary
shopt -s globstar		# ** globs to all files and zero+ dirs and subdirs
shopt -s histappend		# append to the history file, don't overwrite it
shopt -s histreedit		# Retry failed history substitutions
HISTSIZE=				# Store unlimited history entries in memory
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
black='\[\e[15\]'
red='\[\e[31m\]'
orange='\[\e[38;5;208m\]'
yellow='\[\e[93m\]'
green='\[\e[32m\]'
blue='\[\e[34m\]'
violet='\[\e[35m\]'
white='\[\e[97m\]'
norm='\[\e[39m\]'
colors=([0]="$red" "$orange" "$yellow" "$green" "$blue" "$violet")

# Username
un="${green}\\u${norm}"

# At
at="${green}@${norm}"

# Hostname
hn="${green}\\h${norm}"

# Present directory
pd="${blue}\\w${norm}"

# Colour $ red if in an ssh session
if [ -n "$SSH_CLIENT" -o -n "$SSH2_CLIENT" ] ; then
	ps="$red\\\$$norm"
else
	ps="$white\\\$$norm"
fi

# If we are in a "subshell" for this host, colour the brackets
if [[ $SHLVL -lt 2 || $0 =~ -.+ ]] ; then
	lb="$white[$norm"
	rb="$white]$norm"
else
	# The colour chosen will be one of ROYGBV
	# Red is for the first subshell, orange for the second, etc.
	color="${colors[($SHLVL - 2) % 6]}"
	lb="$color[$norm"
	rb="$color]$norm"
fi

# Prompt of the form [user@host pwd]$
export PS1="${lb}${un}${at}${hn} ${pd}${rb}${ps} "

# Get rid of all of the garbage we just defined
unset red orange yellow green blue violet white color colors norm un hn pd ps lb rb

# make Vim the default editor and man viewer if it exists
if [ -x /usr/bin/vim ]; then
	export EDITOR=/usr/bin/vim

	# Alias man to a script that detects pipes to set MANPAGER appropriately
	# Will use vim if stdout is connected to a TTY, less elsewise
	if [ -x ~/bin/man.sh ] ; then
		alias man=~/bin/man.sh
	fi
fi

# Source any local options that may exist
if [ -r ~/.bashrc.local ] ; then
	source ~/.bashrc.local
fi

# Source function definitions
if [ -r ~/.bash_functions ] ; then
	source ~/.bash_functions
fi

# Source alias definitions
if [ -r ~/.bash_aliases ]; then
	source ~/.bash_aliases
fi
