cd()
{
	local dir=''

	case "$*" in
		'')		dir="$realhome"
				;;
		'~')	dir="$realhome"
				;;
		'-')	builtin pushd > /dev/null
				return $?
				;;
		*)		dir="$*"
				;;
	esac


	if [ "$PWD" == "$realhome" -o "$PWD" == "$HOME" ] ; then
		builtin cd "$dir"
	else
		builtin pushd "$dir" > /dev/null
	fi

	return $?
}

if [ -r "$realhome/.bash_functions.local" ] ; then
	source "$realhome/.bash_functions.local" 
fi
