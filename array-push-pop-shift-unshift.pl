#!/usr/bin/env perl

use warnings;
use strict;
use Data::Dumper;

$Data::Dumper::Terse=1;

my @a=(0,1);

# push onto end of array
pout('initialize', \@a);
push @a, 2;
pout('push', \@a);

#pop off end of array
my $r = pop @a;
pout('pop', \@a);

# initialize
@a=(0,1);
pout('initialize', \@a);

# unshift onto beginning of array
unshift @a, 2;
pout('unshift', \@a);

# shift off beginning of array
$r = shift @a;
pout('shift', \@a);

# pass op name used and array ref

sub pout {

	my ($ops,$ary) = @_;

	print "==== $ops ======\n";
	print Dumper($ary);
	print "\n";
	return;
}

