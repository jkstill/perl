#!/home/oracle/perl/bin/perl -w

# artt.pl ( average response time total )
# pull the average response time from Oracle tkprof output
#
# 
# jkstill - 03/13/03 - changed name from art.pl to artt.pl

use warnings;
use Getopt::Long;
use Math::Round;

my %opt = ();

GetOptions (\%opt,
	"file=s"
);

open(FILE, "$opt{file}") || die "cannot open $opt{file} - $!\n";

my $marker='OVERALL TOTALS FOR ALL NON';
my $markerFound = 0;

my $exeCount;
my $elapsedTime;

while(<FILE>) {
	$markerFound = /^$marker/ unless $markerFound;
	next unless $markerFound;

	my @data=split(/\s+/);
	if ( defined $data[0] and $data[0] eq 'Execute' ) { $exeCount += $data[1] }
	if ( defined $data[0] and $data[0] eq 'total' ) { $elapsedTime += $data[3] }
}

# avoid / by 0
$exeCount += 0.0001;

# avoid errors when elapsedTime is uninitialized
$elapsedTime += 0 unless defined $elapsedTime;

my $avgResponseTime = nearest(.01,$elapsedTime / $exeCount);
print qq{
FILE: $opt{file}
elapsed time      : $elapsedTime
exec  count       : $exeCount
avg response time : $avgResponseTime seconds

};



