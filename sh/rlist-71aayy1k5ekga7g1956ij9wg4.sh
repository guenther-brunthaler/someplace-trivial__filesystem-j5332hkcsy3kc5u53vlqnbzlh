#! /bin/false
# Simple resource list framework.

# This global variable contains the current resource list. It is initially
# empty. This is a private variable of the framework. Application code does
# not need to meddle with it, although it might be helpful to display its
# contents when debugging, for showing which resources are currently active.
rlist=

# Add resources to the end of the global resource list. Resources are shell
# commands without arguments which will be executed (in reverse list order)
# when the resource list is released. It is also possible to add labels using
# the syntax '=label", where "label" is the name of the label. The current
# position where the next resource will be inserted into the resource list can
# be changed by specifying arguments '<label' or 'label>' where "label" is an
# already existing label in the list. This will change the insertion position
# before or after the label entry, respectively. Label names should be unique
# although this is not required: When searching for a label, only the last
# entry of the whole list with a matching name will be found. An empty string
# is also a valid label name.
alloc() {
	local head tail cmd
	head=$rlist${rlist:+' '}; tail=
	for cmd
	do
		case $cmd in
			'<'*)
				cmd="=${cmd#?} "
				tail=$head$tail
				head=${tail%"$cmd"*}
				tail=${tail#"$head"}
				;;
			*'>')
				cmd="=${cmd%?} "
				head=$head$tail
				tail=${head##*"$cmd"}
				head=${head%"$tail"}
				;;
			*) head=$head$cmd' '
		esac
	done
	head=$head$tail
	rlist=${head%' '}
}

# Deallocate resources of the global resource list by executing the
# parameterless commands in the list in reverse list order. Label entries
# start with "=" and act as no-ops. Every command will be removed from the
# list immediately before it is executed. Without any argument, all resources
# are freed. With argument 'label>', deallocation stops when a label with name
# "label" is the last entry of the resource list. With argument '=label',
# deallocation stops once the entry for a label with name "label" has been
# removed from the list. Note that the empty string is also a valid label
# name.
release() {
	local stop entry
	case $1 in
		'') stop=;;
		*'>') stop="=${1%?}";;
		'='*) stop=$1;;
		*) exit 99
	esac
	while test -n "$rlist"
	do
		entry=${rlist##*' '}
		# Strange dash bug (?): Change below to x"${1%'>'}" and it
		# won't work any more! No idea why...
		if test x"$entry" = x"$stop" && test x"${1%">"}" != x"$1"
		then
			return
		fi
		if test x"$entry" != x"$rlist"
		then
			rlist=${rlist%" $entry"}
		else
			rlist=
		fi
		case $entry in
			'='*) test x"$entry" = x"$stop" && return;;
			*) "$entry" # Must be a command to be executed.
		esac
	done
}
