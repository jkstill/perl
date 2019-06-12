#!/usr/bin/env perl

use strict;
use warnings;

sub setRetVal($);
sub getRetVal();

my $debug=0;

print "Start of Code\n";
print 'val: ', getRetVal(),"\n";
print "====================\n";

print "Set to Warning\n";
setRetVal(getExitWarningCode());
print 'val: ', getRetVal(),"\n";

print "====================\n";

print "Set to Error\n";
setRetVal(getExitErrorCode());
print 'val: ', getRetVal(),"\n";

print "====================\n";

print "Set to Warning - will not reset as Error already set\n";
setRetVal(getExitWarningCode());
print 'val: ', getRetVal(),"\n";


## subs

# these must be in a code block to preserve the _retVal between calls
# and placed within BEGIN{} so they are made available without the need
# to place at the top of the file
# without the BEGIN a sub would need to be used to initialize the return value before other calls were made

BEGIN {

{

	sub getExitOKCode { 250 }
	sub getExitWarningCode { 1 }
	sub getExitErrorCode { 2 }

   # using the code block {} allows setting a value that is local to the block
   # initialize the return value
	my $_retVal = getExitOKCode();

	#print "BEGIN code block\n";

	# set the global return value
	# EXIT_WARNING overrides EXIT_OK
	# EXIT_ERROR overrides EXIT_WARNING
	sub setRetVal($) {
   	my $newValue = shift;
	
		print "newValue $newValue\n" if $debug;

		# order of urgency
   	# 250=ok, 1=warning, 2=error
		#$i = $newValue;
		#if ( $newValue+0 < $_retVal ) { $_retVal = $newValue }

		# set the code only if more urgent than the current setting
		if ( $newValue == getRetVal() ) {} # nothing to do
		elsif ( $newValue == getExitErrorCode() ) { 
			# always set Error when requested
			$_retVal = getExitErrorCode() 
		} 
		elsif ( $newValue == getExitWarningCode() ) { 
			# set code to warning only if not already set to error
			$_retVal = getExitWarningCode() if getRetVal() != getExitErrorCode;
		} elsif ( $newValue == getExitOKCode() ) {
			# this should never be requested, as the value is initialized to OK at the beginning
			# print a warning here
			# not using the printing subroutines here as this code is compiled and executed via BEGIN{},
			# making the print subroutines unavailable here.
			print "<font color=orange>[WARNING]</font> Warning!\n";
			print "setRetVal() should not be called with getExitOKCode(): ",  getExitOKCode(), "\n";
		}
		else {
			# called with invalid code
			print "<font color=orange>[WARNING]</font> Warning!\n";
			print "setRetVal() called with invalid Value: $newValue\n";
		}


		print "_local: $_retVal\n" if $debug;
		print "_set_val: $newValue\n" if $debug;

	}

	sub getRetVal() {
		print "__val: $_retVal\n" if $debug;
   	return $_retVal;
	}

}

}


