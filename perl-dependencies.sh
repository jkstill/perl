#!/usr/bin/env  bash

if [[ -z $1 ]]; then
	echo 
	echo "Please tell me the Perl script to check"
	echo
	exit 1
fi

perl -cw -I ~/perl/lib -MListDependencies "$1"




