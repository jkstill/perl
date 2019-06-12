#!/usr/bin/env perl

use warnings;
use strict;
use Data::Dumper;

# see the effects of deleting from a hash

my %h=();

foreach my $i ( 65..(65+25) ) {
	$h{chr($i)} = $i;
}

printData();

print "Delete X and get the scalar results\n";

my $scalar = delete $h{X};

print "\$scalar: $scalar\n";
print "\n";

print "Delete C,D and E,F separately and get the results - show both scalar and list context results\n";
print "Scalar will return the last element deleted\n";
print "\n";

$scalar = delete @h{qw(C D)};
my @list = delete @h{qw(E F)};

print "\$scalar: $scalar\n";
print "\@list : ", join(' - ',@list), "\n";

print "\n";

print "Or if you don't care about the return value, just run delete - deleting R\n";

delete $h{R};

printData();

print "undef returned when key does not exist - deleting 'notfound'\n";

$scalar = defined(delete $h{notfound}) ? undef : 'key-not-found';

print "\$scalar: $scalar\n";

print "\n";

print "now just delete a non-existant key without getting a return value - deleting 'notfound'\n";

delete $h{notfound};

printData();


sub printData {
	print "\nTest Data\n";
	foreach my $letter ( sort keys %h ) {
		print "   $letter -> $h{$letter}\n";
	}
	print "\n";
}
