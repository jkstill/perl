#!/home/oracle/perl/bin/perl -w

# art.pl ( average response time )
# pull the average response time from Oracle tkprof output
# for each statement
# weight is elapsed time * executions
# results are sorted by weight, or other sort option
# the last two results will be the totals
# from the end of the tkprof file

use warnings;
use Getopt::Long;
use Math::Round;
use Data::Dumper;

my %opt = ();

GetOptions (\%opt,
	"file=s",
	"sortfield=s",
	"help!"
);

usage(0) if $opt{help};
usage(1) unless $opt{file};


my @validSortFields = qw{weight elapsedTime exeCount avgResponseTime};

my $sortField;
if ( ! defined $opt{sortfield} or ! grep(/$opt{sortfield}/, @validSortFields)  ) {
	$sortField = $validSortFields[0];
} else { $sortField = $opt{sortfield} }

open(FILE, "$opt{file}") || die "cannot open $opt{file} - $!\n";

my $beginMarker='call';
my $endMarker='total';
my $beginMarkerFound = 0;
my $endMarkerFound = 0;

my $exeCount = 0;
my $elapsedTime = 0;

my $line = 0;

print "FILE: $opt{file}\n";

my %art=();

while(<FILE>) {
	$line++;
	$beginMarkerFound = /^$beginMarker/ unless $beginMarkerFound;
	next unless $beginMarkerFound;

	my @data=split(/\s+/);
	if ( defined $data[0] and $data[0] eq 'Execute' ) { $exeCount += $data[1] }
	if ( defined $data[0] and $data[0] eq 'total' ) { $elapsedTime += $data[3] }

	$endMarkerFound = /^$endMarker/ unless $endMarkerFound;

	if ( $endMarkerFound and $beginMarkerFound ) {
		$beginMarkerFound = 0;
		$endMarkerFound = 0;
		# avoid / by 0
		#$exeCount += 0.0001 unless $exeCount;

		# avoid errors when elapsedTime is uninitialized
		$elapsedTime += 0 unless defined $elapsedTime;

		my $avgResponseTime = 0;
		if ( $exeCount ) {
			$avgResponseTime = nearest(.01,$elapsedTime / $exeCount);
		}

		$elapsedTime = nearest(.01,$elapsedTime);

		my $weight = nearest(1, $exeCount * $elapsedTime);

		$art{$line} = {
			elapsedTime => $elapsedTime,
			exeCount => $exeCount,
			avgResponseTime => $avgResponseTime,
			weight => $weight
		};

		$exeCount = 0;
		$elapsedTime = 0;
	}
	
}

# get keys sorted by weight
my @keys =();
for my $line ( keys %art ) {
	#push @keys, [$line, $art{$line}->{weight}];
	push @keys, [$line, $art{$line}->{$sortField}];
}
my @sortByWeight = sort { $a->[1] <=> $b->[1] } @keys;
#print Dumper(\@sortByWeight);

for my $ary ( @sortByWeight ) {
	#print "ary: $ary->[1]\n" ; # - $sortByWeight[$el]->[0]\n";
	print qq{
weight           : $art{$ary->[0]}->{weight}
line  \#          : $ary->[0]
elapsed time     : $art{$ary->[0]}->{elapsedTime}
avg response time: $art{$ary->[0]}->{avgResponseTime}
exe   count      : $art{$ary->[0]}->{exeCount}
};
}

sub usage {

	my $exitVal = shift;
	use File::Basename;
	my $basename = basename($0);
	print qq{
$basename

usage: $basename - Sort tkprof output file by one of several fields

   $basename -file <tkprof output file> -sortfield <field to sort by>

-file        tkprof output file
-sortfield   one of: elapsedTime exeCount avgResponseTime weight
             defaults to weight ( case counts in spelling )
-help        display help

example:

   $basename -file ora02348.prof -sortfield avgResponseTime
};

	exit $exitVal ? $exitVal : 0;
}

