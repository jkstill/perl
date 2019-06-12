#!/usr/bin/env perl

# print the time for yesterday

use POSIX;
use strict;
use Time::Local;

my $df='%m%d%Y';
my $time=time;
$time -= 24*60*60;
print strftime $df, localtime($time);
print "\n";

my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);

my $prev_day = timelocal(0, 0, 0, $mday-1, $mon, $year);

print strftime $df, localtime($prev_day);
print "\n";
