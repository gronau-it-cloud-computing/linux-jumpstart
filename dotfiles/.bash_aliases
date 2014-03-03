# ~/.bash_aliases: used to add aliases in bash(1)
alias sudo='sudo '
# Show all files in long format with type characters and human-readable units
alias ll='ls -alFh'
# List all files with type characters
alias la='ls -A'
# Show df with human-readable units
alias df='df -h'

# Source any local aliases that may exist
if [ -r ~/.bash_aliases.local ] ; then
	. ~/.bash_aliases.local
fi
