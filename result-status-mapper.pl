#!/usr/bin/env perl
#
## example code
#
use strict;
use warnings;

use IO::File;
use Data::Dumper;

my $file = 'result-status-map.conf';

my $fh = IO::File->new($file,'r');

die "could not open $file - $!\n" unless $fh;

my %transforms=();

while ( my $line = <$fh> ) {
	chomp $line;
	next if $line =~ /^\s*$|^#/;
	my ($key,$data) = split(/\|/,$line);
	foreach my $transformSource ( split(/,/,$data) ) {
		$transforms{$transformSource} = $key;
	}
}

print Dumper(\%transforms);
