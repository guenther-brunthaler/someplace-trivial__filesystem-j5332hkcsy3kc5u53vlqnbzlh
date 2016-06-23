#! /bin/false
have_pgxdf9uct7ch4pzf5e2b4bn9f=true

# "42", "42 B", "42 kB", "42 kiB", "42MB, "42GiB", "42TB", "42 PiB", ...
parse_bytecount() {
	local num tx unit mult
	num=`
		LC_COLLATE=C expr x"$1" : '\(x0\)' \
			\| x"$1" : '\(x[1-9][0-9]*\)' \
			\| x
	`
	num=${num#x}; test -n "$num" || return
	tx=${1#"$num"}
	if test -n "$tx"
	then
		unit=`
			rx='[[:space:]]*\(\([kKMGTPEZY]i\{0,1\}\)\{0,1\}B\)$'
			LC_COLLATE=C expr x"$tx" : x"$rx"
		`
		unit=`
			rx1='\(\([MGTPEZY]i\{0,1\}\)\{0,1\}B\)$'
			rx2='\(KiB\)$'
			rx3='\(kB\)$'
			LC_COLLATE=C expr x"$unit" : x"$rx1" \
				\| x"$unit" : x"$rx2" \
				\| x"$unit" : x"$rx3"
		`
		unit=${unit%?}
		case $unit in
			"") unit=B;;
			*i) unit=${unit%?}; mult=1024;;
			*) mult=1000
		esac
		unit=`echo $unit | LC_COLLATE=C tr BkKMGTPEZY 0112345678`
		while test $unit != 0
		do
			tx=`expr $num '*' $mult || :`
			test $tx -ge $num
			num=$tx
			unit=`expr $unit - 1 || :`
		done
	fi
	echo $num
}
