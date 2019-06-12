#!/usr/bin/env perl

use Data::Dumper;

@a=(0,1,2);
@b=@a;
@c=([@a],[@a]);

#push @c,\@a;
print Dumper(\@c);
print "\n";

$c[1]->[1] = 'X';

print Dumper(\@c);
print "\n";




