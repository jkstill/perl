#!/usr/bin/perl

my $secs = 0;
my $period = 5;

while (1) {
	sleep $period;
	$secs += $period;
	print "$secs\n";
}

