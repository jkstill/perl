#!/usr/bin/env perl

use POSIX;
use Time::Local;

my $time=time;
#print "\$time: $time\n";
my $df='%m%d%Y';

my @a=localtime($time);

my $timestamp = strftime $df, @a;
print "Time: $timestamp\n";


# yesterday
$time -= 24*60*60;
my @a=localtime($time);
$timestamp = strftime $df, @a;
print "Time: $timestamp\n";




