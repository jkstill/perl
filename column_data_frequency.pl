#!/home/oracle/perl/bin/perl -w

use warnings;
use strict;
no strict 'vars';
use PDBA::CM;
use PDBA::GQ;
use PDBA::OPT;
use Getopt::Long;
use Data::Dumper;
use Benchmark;

my %optctl=();

# passthrough allows additional command line options
# to be passed to PDBA::OPT if needed
Getopt::Long::Configure(qw{pass_through});

GetOptions( \%optctl,
	"help!",
	"machine=s",
	"database=s",
	"username=s",
	"password=s",
	"skip_columns=s@",
	"table=s",
);

if ( $optctl{help} ) { usage(1) }

usage(1) unless $optctl{table};

# lookup the password if not on the command line
my $password = '';
if ( defined( $optctl{password} ) ) {
	$password = $optctl{password};
} else {

	if (
		! defined($optctl{database})
		|| ! defined($optctl{username})
	) { usage(1) }

	$password = PDBA::OPT->pwcOptions (
		INSTANCE => $optctl{database},
		MACHINE => $optctl{machine},
		USERNAME => $optctl{username}
	);
}

my $dbh = new PDBA::CM(
	DATABASE => $optctl{database},
	USERNAME => $optctl{username},
	PASSWORD => $password,
);

my $gq = new PDBA::GQ ( $dbh, $optctl{table}, { WHERE => 'rownum < 2' } );

my $colHash = $gq->getColumns;

# remove skip columns from array
map { delete $colHash->{uc($_)} } @{$optctl{skip_columns}};

# the above map is functionally equivalent to this loop
#foreach $deleteColumn ( @{$optctl{skip_columns}} ) {
	#delete $colHash->{uc($deleteColumn)};
#}

my @colNames = sort { $colHash->{$a} <=> $colHash->{$b} } keys %{$colHash};

$dbh->do(q{alter session set nls_date_format = 'mm/dd/yyyy hh24:mi'});

$gq = new PDBA::GQ (
	$dbh, $optctl{table},
	{
		COLUMNS => \@colNames
	}
);

my %colData=();

print "\n";

$|++;

$SIG{INT} = \&dumpit;

my $counter = 0;

my $t0 = new Benchmark;

while ( my $row = $gq->next ) {
	print STDERR '.' unless $counter++ % 100;
	map {$colData{$_}{$row->{$_}}++ if $row->{$_}} @colNames;
}

print STDERR "\n";

my $t1 = new Benchmark;
my $td = timediff($t1, $t0);

$gq->finish;
$dbh->disconnect;

#print Dumper(\%colData);

foreach my $column ( sort keys %colData ) {
	print "$column:\n";
	foreach $colval ( sort { $colData{$column}{$a} <=> $colData{$column}{$b} } keys %{$colData{$column}} ) {
		printf("\t%10d %-30s\n", $colData{$column}{$colval}, $colval);
	}
}

print STDERR "\nTime to run: ", timestr($td), "\n";

## end of main

sub usage {
	my $exitVal = shift;
	use File::Basename;
	$basename = basename($0);
	print qq/
$basename

usage: $basename -machine database_server -database instance -username account -table

/;
	exit $exitVal;
};

sub dumpit {
	print Dumper(\%colData);
	$gq->finish;
	$dbh->disconnect;
	exit;
}
