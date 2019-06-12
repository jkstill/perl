#!/usr/bin/env perl
#

use strict;
use warnings;
use JSON;


undef $/; # slurp mode for file read

my $jsonTxt=<>;

my $jsonOut;

my $ppJSON = JSON->new;
$jsonOut = $ppJSON->pretty->encode($ppJSON->decode($jsonTxt));

print $jsonOut;

