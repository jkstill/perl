#!/usr/bin/env perl
#

use strict;
use warnings;
use JSON;
use IO::File;


my ($file)=@ARGV;
my $fh = IO::File->new;

unless ( $fh->open($file, 'r') ) {
	die "cannot open $file - $!\n"
}

undef $/; # slurp mode for file read

my $jsonTxt=<$fh>;

my $jsonOut;

my $ppJSON = JSON->new;
$jsonOut = $ppJSON->pretty->encode($ppJSON->decode($jsonTxt));

print $jsonOut;

