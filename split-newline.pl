#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;

my $txt = qq{This is a 
test of 
multiline data.

This is the last line.
};

print "txt: $txt\n";


my @s = split(/\n/,$txt);
print Dumper(\@s);

my $x = '"' . join(qq{\",\n"},@s) . '"';

print Dumper(\$x);

print $x;
