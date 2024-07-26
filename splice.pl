#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;


my @a=qw[a b c d e f g h];

print Dumper(\@a);

# remove d
# assigning to a list returns the values removed
my @b = splice(@a,3,1);

# just performing the splice removes the element(s)
#splice(@a,3,1);

print '@b contains the elements removed - ', Dumper(\@b);

print 'd is removed from @a - ', Dumper(\@a);

# now put it back

splice(@a,3,0,@b);

print 'd is added back to @a - ', Dumper(\@a);

print "\nnow remove multiple elements\n";

splice(@a,3,1);

print 'd is added back to @a - ', Dumper(\@a);
