#!/usr/bin/env perl

use Data::Dumper;

=head1 Array Slice from Function

 Just a quick hack to show how to get an array slice from
 a function that returns an array.

 I can never remember the correct syntax.

=cut 


sub getary {

	return qw[zero one two three four five six seven eight nine];

}

my @a=getary;

print Dumper(\@a);

my $v = (getary)[2];

print "2: $v\n";

@a = (getary)[4..6];
print Dumper(\@a);

@a = (getary)[0,4..6,8];
print Dumper(\@a);

print "3: remove first element only\n";

@a = (getary);
print Dumper(\@a);
#
shift @a;
# this also works
#@a = @a[1..$#a];
#
print Dumper(\@a);

