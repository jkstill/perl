#!/usr/bin/env perl

print somefunc(),"\n";

sub somefunc { 
	my $f= (caller(0))[3];
	print "func: $f\n";
	return 1 ;
}
