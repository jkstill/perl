#!/bin/sh

# default is show cmd first

function usage {
	echo $(basename $0)
	echo "-c show command then execute"
	echo "-n execute then show command"
}


while getopts cn arg
do
	case $arg in
		c) ORDER='CMDFIRST';;
		n) ORDER='NOCMDFIRST';;
		*) echo "invalid argument specified"; usage;exit 1;
	esac

done

# default to CMDFIRST
: ${ORDER:='CMDFIRST'}

echo "using $ORDER" >&2

for sleeptime in .5 .75 .25 .1 .9 1.2 .1 .2 .3
do
	if [ "$ORDER" == 'CMDFIRST' ]; then
		echo sleeping for $sleeptime seconds
		sleep $sleeptime
	else
		sleep $sleeptime
		echo sleeping for $sleeptime seconds
	fi
done


