# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s checkhash						# Build hash of commands run, check hash before PATH
shopt -s checkjobs						# Require confirmation to exit with jobs running
shopt -s checkwinsize					# Check window size after commands, update if necessary

# Globbing settings
export GLOBIGNORE='.:*/.:*/..'			# Ignore . and .. when globbing
shopt -u dotglob						# Bash turns dotglob on when GLOBIGNORE is non-null
shopt -s globstar						# ** globs to all files and zero+ dirs and subdirs

# History settings
shopt -s histappend						# Append to the history file, don't overwrite it
shopt -s histreedit						# Retry failed history substitutions
export HISTSIZE=						# Store unlimited history entries in memory
export HISTFILESIZE=25000				# Store 25000 lines of history in $HISTFILE
export HISTCONTROL=ignoreboth			# Ignore duplicate lines and lines starting with a space
export HISTTIMEFORMAT='%Y%m%d-%H%M%S%t'	# Nice timestamps for the history file
[ -d "$HOME/.bash_history.d" ] &&		# Use host-specific files if we have the dir for them
	export HISTFILE="$HOME/.bash_history.d/$HOSTNAME"

# coreutils 8.25 introduced insane defaults for ls
export QUOTING_STYLE=literal

# Custom prompt for sudo
export SUDO_PROMPT='[sudo] Password for %u@%h: '

# Enable programmable completion features
if [ -r /etc/bash_completion ] && ! shopt -oq posix; then
	source /etc/bash_completion
fi
bind Space:magic-space

# Automagical preprocessing of arguments to less
[ -x /usr/bin/lesspipe ] && LESSOPEN="| lesspipe %s" && export LESSOPEN

# Set PS1
setaf()
{
    tput setaf "$1" || tput AF "$1"
}

# Pretty colors
red='\['"$(setaf 1)"'\]'
orange='\['"$(setaf 202)"'\]'
yellow='\['"$(setaf 11)"'\]'
green='\['"$(setaf 2)"'\]'
blue='\['"$(setaf 4)"'\]'
violet='\['"$(setaf 5)"'\]'
white='\['"$(setaf 7)"'\]'
norm='\['"$(tput sgr0 || tput me)"'\]'
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

# Make Vim the default editor if it exists
[ -x /usr/bin/vim ] && export EDITOR=/usr/bin/vim

# Source function definitions
if [ -d "$HOME/.bash_func.d" ] ; then
	for func in "$HOME/.bash_func.d"/* ; do
		[ -r "$func" ] && source "$func"
	done
fi

# Source bash completion plugins
if [ -d "$HOME/.bash_completion.d" ] ; then
    for comp in "$HOME/.bash_completion.d"/* ; do
        [ -r "$comp" ] && source "$comp"
    done
fi

# Put my bin on the front of PATH
pathctl push -f "$HOME/bin"

# Source alias definitions
[ -r "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"

# Source any local options that may exist
[ -r "$HOME/.bashrc.local" ] && source "$HOME/.bashrc.local"
