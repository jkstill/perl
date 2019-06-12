#!/usr/bin/env perl
#
use strict;
use warnings;

use Getopt::Long;

# simpler method of assigning defaults with Getopt::Long

my $traceFile='- no file specified';
my $opLineLen=80;
my $number=12.34;
my $help=0;
my @multOpts=();


GetOptions (
		"file=s" => \$traceFile,
		"op-line-len=i" => \$opLineLen,
		"number=f" => \$number,
		"h|help!" => \$help,
		"mult-opts=s" => \@multOpts,
) or die usage(1);

usage() if $help;

print qq {

traceFile: $traceFile
opLineLen: $opLineLen
   number: $number

};

if (@multOpts) {
	foreach my $opt (@multOpts) {
		print "opt: $opt\n";
	}
}

sub usage {

	my $exitVal = shift;
	use File::Basename;
	my $basename = basename($0);
	print qq{
$basename

usage: $basename - format readable execution plans found in Oracle 10046 trace files

   $basename --file <filename> --op-line-len N

--file         10046 tracefile name
--op-line-len  Formatted length of operation lines - defaults to 80
--number       Some floating point number
--mult-opts    specify this multiple times

examples here:

   $basename --file DWDB_ora_63389.trc --op-line-len 120 --mult-opts A --mult-opts B
};

	exit eval { defined($exitVal) ? $exitVal : 0 };
}

