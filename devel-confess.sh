#!/bin/bash

: << 'COMMENT'

From the Devel::Confess docs

# Make every warning and error include a full stack trace
perl -d:Confess script.pl
 
# Also usable as a module
perl -MDevel::Confess script.pl
 
# display warnings in yellow and errors in red
perl -d:Confess=color script.pl
 
# set options by environment
export DEVEL_CONFESS_OPTIONS='color dump'
perl -d:Confess script.pl

COMMENT

banner () {

	declare banner

	banner=$1

	echo "####################################################"
	echo "## $banner"
	echo "####################################################"
	echo

}

runTest () {
	
	declare CMD
	CMD=$*

	banner "CMD: $CMD"
	$CMD

	echo


}


runTest perl devel-confess.pl

runTest perl -d:Confess devel-confess.pl

# the color option does not seem to work
runTest perl -d:Confess=color devel-confess.pl

runTest perl -MDevel::Confess  devel-confess.pl

runTest perl -MDevel::Confess=color  devel-confess.pl



