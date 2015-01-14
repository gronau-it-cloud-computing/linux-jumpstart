# ~/.bash_aliases: used to add aliases in bash(1)
# Pass aliases through sudo
alias sudo='sudo '

# Show all files in long format with type characters and human-readable units
alias ll='ls -alFh'
# List (almost) all files with type characters
alias la='ls -A'

# Show d[fu] with human-readable units
alias df='df -h'
alias du='du -h'

# Simulate sprintf VAR PATTERN [ARGS]
alias sprintf='printf -v'

# Source any local aliases that may exist
if [ -r "$HOME/.bash_aliases.local" ] ; then
	source "$HOME/.bash_aliases.local"
fi
