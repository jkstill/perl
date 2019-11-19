#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;
use XML::Dumper;
use XML::Twig;


print qq{

This script needs work, as it currently does not work properly

};

exit;


my $xmlFile=$ARGV[0];

die "which XML file?\n" unless defined $xmlFile;

-r $xmlFile || die "Could not read $xmlFile - $!\n";

my $twig= XML::Twig->new;
#my $xml = $twig->parsefile( $xmlFile )->simplify();
my $xml = $twig->parsefile( $xmlFile );

my $perl = xml2pl( $xml );
#print Dumper($perl);

#$twig->print;


