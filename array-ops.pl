#!/usr/bin/env perl
#

use Data::Dumper;

my @a=qw[0 1 2 3 4];
my $x=shift @a;
print "shift: $x\n";

@a=qw[0 1 2 3 4];

print 'Max element ID in @a: ', $#a , "\n";

my $ref = \@a;


print 'Max element ID in $ref: ', $#{$ref} , "\n";

$x=pop @a;
print "pop $x\n";

@a=();

print 'first el of @a when @a empty: ' , $#a, "\n";

$a = [

	[0, 1, 2],
	['a', 'b','c' ],

];


print Dumper($a);

my $c = $#{$a};
print "Last element in \$a: $c\n";


my @w=qw{a b c d e f};

print "\nfind index of d in \@w\n";

print '@w: ', Dumper(\@w);

my $want = 'd';
my $index = 0;
++$index until ($w[$index] eq $want) or ($index > $#w);
print "f: index of d is $index\n";


