#!/usr/bin/perl

# set hash and array references (refs) in a subroutine.
# this script is just a reminder to me for when I forget how to do this.

use strict;
use Data::Dumper;

my %h=();
my @a=();


sub setHash {
	my $h2 = scalar shift;
	%{$h2} = (
		'one' => 1,
		'two' => 2,
		'three' => 3,
	);
}

sub setArray {
	my $a2 = scalar shift;
	@{$a2} = (1..5);
}

setHash(\%h);

print "\nHash :\n", Dumper(\%h);


setArray(\@a);

print "\nArray :\n", Dumper(\@a);

