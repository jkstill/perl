#!/usr/bin/perl

use POSIX qw(strftime);

my $wallClockTime = strftime "%Y-%m-%d %H:%M:%S", localtime;

print "$wallClockTime\n";

my ($year,$month,$day,$hour,$minute,$second) = split(/:/,strftime "%Y:%m:%d:%H:%M:%S", localtime);

print qq{

Year:   $year
Month:  $month
Day:    $day
Hour:   $hour
Minute: $minute
Second: $second
};

