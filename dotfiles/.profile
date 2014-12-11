# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

platform=$(uname -s)

case $platform in
	OpenBSD)
		version=$(uname -r)
		machine=$(uname -m)
		PKG_PATH="ftp://mirror.planetunix.net/pub/OpenBSD/$version/packages/$machine/"
		PKG_PATH="$PKG_PATH:ftp://mirror.team-cymru.org/pub/OpenBSD/$version/packages/$machine/"
		export PKG_PATH
		unset version
		unset machine
		;;
esac
unset platform

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
	PATH="$PATH:$HOME/bin"
fi

# If running bash
if [ -n "$BASH_VERSION" ]; then
	# Source .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi
