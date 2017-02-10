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

# Make Vim the default editor if it exists
[ -x /usr/bin/vim ] && export EDITOR=/usr/bin/vim

if [ -d "${HOME}/.config/bash" ] ; then
	for conf in "${HOME}/.config/bash"/* ; do
		[ -f "${conf}" ] && source "${conf}"
	done
fi
