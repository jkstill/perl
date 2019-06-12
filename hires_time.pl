#!/usr/bin/perl -w

use Time::HiRes( qw{tv_interval gettimeofday});
use Data::Dumper;

my ($startTime) = [gettimeofday];

print "$startTime->[0].$startTime->[1]\n";
