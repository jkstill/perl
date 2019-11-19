#!/usr/bin/env perl

use warnings;
use strict;
use Data::Dumper;

print "\n#### f1() ##############\n";
print f1(),"\n";

print "\n#### f2() ##############\n";
print f2(),"\n";

sub getFname {
	#print "getFname:" . (caller(1))[3] . "\n";
	# 0 is the current funtion
	# 1 is the caller of this function
	return (caller(1))[3];
}

sub f1 { 
	my $f= (caller(0))[3];
	print "func: $f\n";
	return 1 ;
}

sub f2 { 

	my $f = getFname();
	print "func: $f\n";
	return 1 ;
}
