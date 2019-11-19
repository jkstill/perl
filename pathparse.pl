#!/usr/bin/env perl

use strict;
use warnings;

die "usage: pathparse.pl <path_variable> - delimiter is ':' \n" unless defined($ARGV[0]);

print join(qq{\n},split(q{:},$ARGV[0]));

print "\n";

