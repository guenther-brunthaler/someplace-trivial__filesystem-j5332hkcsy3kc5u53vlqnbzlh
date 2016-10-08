#! /bin/false
have_37yusympssv3vb63uavsipr7u=true
if test x"$have_71aayy1k5ekga7g1956ij9wg4" != x'true'
then
	. "$libdir"/rlist-71aayy1k5ekga7g1956ij9wg4.sh
fi

cleanup() {
	rc=$?
	release
	test $rc = 0 || echo "$0 failed!" >& 2
}

die() {
	echo "$*" >& 2; false || exit
}

trap cleanup 0
trap 'exit $?' INT TERM QUIT HUP
