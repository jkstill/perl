#!/usr/bin/env perl

use strict;
use warnings;

use ExtUtils::Installed;
my $inst    = ExtUtils::Installed->new();
my @modules = $inst->modules();

foreach my $module ( sort { lc($a) cmp lc($b) } @modules){
	print "$module\n";
}
