#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;
use Data::TreeDumper;
use Getopt::Long;
use IO::File;
 
binmode STDOUT, ":utf8";
use utf8;
 
use JSON::Parse ':all';

my $dumpJSON=0;
my $help=0;

GetOptions (
		"dump-json!" => \$dumpJSON,
		"h|help!" => \$help,
) or die usage(1);

usage() if $help;

sub usage {

	my $exitVal = shift;
	use File::Basename;
	my $basename = basename($0);
	print qq{
$basename

usage: $basename - validate and optionally dump JSON

   $basename < my.json

--dump-json Dump JSON in readable format
--help     help

examples here:

   $basename --dump-json < my.json

};

	exit eval { defined($exitVal) ? $exitVal : 0 };
}
my @jsonTXT = (<>);

my $jsonTXT = join('',@jsonTXT);

my $perl = parse_json($jsonTXT);

print "JSON Text OK\n";

if ($dumpJSON) {
	print "\n===== DumpTree ==========\n\n";
	print DumpTree($perl);
	print "\n=====  Dumper  ==========\n\n";
	print Dumper($perl);
}



