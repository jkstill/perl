#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;

# push array of hash on to another array of hash


my $a = [
	{
		'A1' => 'array A 1',
		'A2' => 'array A 2',
		'A3' => 'array A 3',
	}
];

my $b = [
	{
		'B1' => 'array B 1',
		'B2' => 'array B 2',
		'B3' => 'array B 3',
	}
];


print '@{$a}: ', Dumper($a);
print '@{$b}: ', Dumper($b);

push @{$a}, @{$b};

print 'pushed $b -> $a : ', Dumper($a);


