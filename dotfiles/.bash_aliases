# ~/.bash_aliases: used to add aliases in bash(1)

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ] ; then
	[ -r "$HOME/.dircolors" ] && eval "$(dircolors -b "$HOME/.dircolors")" || eval "$(dircolors -b)"
	alias ls='ls --color=auto -F'
	alias dir='dir --color=auto'
	alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
else
    # Show type-indicating characters following filenames
    alias ls='ls -F'
fi

# Pass aliases through sudo
alias sudo='sudo '

# Show all files in long format with type characters and human-readable units
alias ll='ls -alFh'
# List all files excepting ., ..
alias la='ls -A'

alias tree='tree -F'

# Show d[fu] with human-readable units
alias df='df -h'
alias du='du -h'

# Simulate sprintf VAR PATTERN [ARGS]
alias sprintf='printf -v'

# Have jobs print PIDs in addition to Job#
alias jobs='jobs -l'

# Source any local aliases that may exist
if [ -r "$HOME/.bash_aliases.local" ] ; then
	source "$HOME/.bash_aliases.local"
fi
