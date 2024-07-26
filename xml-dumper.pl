#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;
use XML::Dumper;
use XML::Twig;


=head1

print qq{

This script needs work, as it currently does not work properly

};

exit;

=cut


my $xmlFile=$ARGV[0];

die "which XML file?\n" unless defined $xmlFile;

-r $xmlFile || die "Could not read $xmlFile - $!\n";

my $twig= XML::Twig->new;
#my $xml = $twig->parsefile( $xmlFile )->simplify();
my $perl = $twig->parsefile( $xmlFile );

#print Dumper($perl);


$twig->print;


