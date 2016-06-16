#! /bin/false
# Simple resource list framework.

# $1: Name of a variable containing a (possibly empty) space-separated list of
# words. Any remaining arguments must be words which will be added to that
# list.
addL() {
	local n_71aayy1k5ekga7g1956ij9wg4 c_71aayy1k5ekga7g1956ij9wg4 \
		w_71aayy1k5ekga7g1956ij9wg4
	n_71aayy1k5ekga7g1956ij9wg4=$1; shift
	eval "c_71aayy1k5ekga7g1956ij9wg4=\$$n_71aayy1k5ekga7g1956ij9wg4"
	for w_71aayy1k5ekga7g1956ij9wg4
	do
		c_71aayy1k5ekga7g1956ij9wg4\
=$c_71aayy1k5ekga7g1956ij9wg4${c_71aayy1k5ekga7g1956ij9wg4:+ }\
$w_71aayy1k5ekga7g1956ij9wg4
	done
	eval "$n_71aayy1k5ekga7g1956ij9wg4=\$c_71aayy1k5ekga7g1956ij9wg4"
}

# $1: The name of a variable containing a space-separated list of words. The
# following steps will be repeated until the list becomes empty: If the last
# word of the list is the '$'-prefixed name of an empty variable, it will be
# removed from the list. Otherwise, if it is the '$'-prefixed name of a
# non-empty variable, the contents of the variable will be moved from that
# variable to the end of the list. Otherwise, the last word must be the name
# of a command, which will be removed from the list and then be executed.
release() {
	local c_71aayy1k5ekga7g1956ij9wg4 e_71aayy1k5ekga7g1956ij9wg4 \
		n_71aayy1k5ekga7g1956ij9wg4 v_71aayy1k5ekga7g1956ij9wg4
	while :
	do
		eval "c_71aayy1k5ekga7g1956ij9wg4=\$$1"
		test -z "$c_71aayy1k5ekga7g1956ij9wg4" && break
		e_71aayy1k5ekga7g1956ij9wg4\
=${c_71aayy1k5ekga7g1956ij9wg4##*' '}
		n_71aayy1k5ekga7g1956ij9wg4=${e_71aayy1k5ekga7g1956ij9wg4#'$'}
		if test x"$n_71aayy1k5ekga7g1956ij9wg4" \
			!= x"$e_71aayy1k5ekga7g1956ij9wg4"
		then
			eval v_71aayy1k5ekga7g1956ij9wg4=\
\$$n_71aayy1k5ekga7g1956ij9wg4
			if test -n "$v_71aayy1k5ekga7g1956ij9wg4"
			then
				eval $n_71aayy1k5ekga7g1956ij9wg4=
				eval "$1=\$$1"'" "$v_71aayy1k5ekga7g1956ij9wg4'
				continue
			fi
		else
			"$e_71aayy1k5ekga7g1956ij9wg4"
		fi
		if test x"$e_71aayy1k5ekga7g1956ij9wg4" \
			!= x"$c_71aayy1k5ekga7g1956ij9wg4"
		then
			eval $1\
='${c_71aayy1k5ekga7g1956ij9wg4%" $e_71aayy1k5ekga7g1956ij9wg4"}'
		else
			eval $1=
		fi
	done
}
