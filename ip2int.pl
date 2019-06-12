#!/usr/bin/perl -w

use Data::Dumper;

use strict;

my $IP=$ARGV[0];

print "$IP\n";

my @ip;

foreach my $o ( split(/\./,$IP) ) {
	unshift @ip, $o;
}

print Dumper(\@ip);

my $ipInt;
foreach my $i ( 0 .. $#ip ) {
	print "octet: $ip[$i]\n";
	$ipInt += $ip[$i] * 256**$i;
}

print "$ipInt\n";

	



