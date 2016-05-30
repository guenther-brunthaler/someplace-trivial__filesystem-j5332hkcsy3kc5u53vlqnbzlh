# "42", "42 B", "42 kB", "42 kiB", "42MB, "42GiB", "42TB", "42 PiB", ...
parse_bytecount() {
	local num tx unit mult
	num=`expr x"$1" : x'\(0\|[1-9][0-9]*\)'`
	tx=${1#"$num"}
	if test -n "$tx"
	then
		unit=`expr x"$tx" : x'[[:space:]]*\(\([kMGTPEZY]i\?\)\?B\)$'`
		unit=${unit%?}
		case $unit in
			"") unit=B;;
			*i) unit=${unit%?}; mult=1024;;
			*) mult=1000
		esac
		unit=`echo $unit | tr BkMGTPEZY 012345678`
		while test $unit != 0
		do
			tx=`expr $num '*' $mult`
			test $tx -gt $num
			num=$tx
			unit=`expr $unit - 1 || :`
		done
	fi
	echo $num
}
