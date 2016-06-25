#! /bin/false
have_r29t167e1xmvyk7trebvq0l9y=true

validate_uint() {
	expr x"$1" : x'[1-9][0-9]*$' \| x"$1" : x'0$' > /dev/null || false
}
