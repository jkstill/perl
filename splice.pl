#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;


my @a=qw[a b c d e g f h];

print Dumper(\@a);

# remove d
# assigning to a list returns the values removed
my @b = splice(@a,3,1);

# just performing the splice removes the element(s)
#splice(@a,3,1);

print '@b contains the elements removed - ', Dumper(\@b);

print 'd is removed fomr @a - ', Dumper(\@a);

