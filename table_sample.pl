#!/home/oracle/perl/bin/perl -w

eval 'exec /export/home/oracle/perl/bin/perl -w -S $0 ${1+"$@"}'
    if 0; # not running under some shell

use warnings;
use strict;
no strict 'vars';
use PDBA::CM;
use PDBA::GQ;
use PDBA::OPT;
use Getopt::Long;
use Data::Dumper;

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

#print "Password: $password\n";

my $dbh = new PDBA::CM(
	DATABASE => $optctl{database},
	USERNAME => $optctl{username},
	PASSWORD => $password,
);

my $gq = new PDBA::GQ ( $dbh, $optctl{table}, { WHERE => 'rownum < 2' } );

my $colHash = $gq->getColumns;
my @colNames = sort { $colHash->{$a} cmp $colHash->{$b} } keys %{$colHash};

#print Dumper($colHash);

$gq->finish;

$dbh->do(q{alter session set nls_date_format = 'mm/dd/yyyy hh24:mi'});

$gq = new PDBA::GQ (
	$dbh, $optctl{table},
	{
		COLUMNS => \@colNames
	}
);

my %colData=();

my $maxSampleElement = 9;

print "\n";
my $counter=0;

$|++;

$SIG{INT} = \&dumpit;

while ( my $row = $gq->next ) {
	#print "\t$row->{$column}\n";

	print STDERR '.' unless $counter++ % 100;

	my $maxSampleReached = 1;
	foreach my $column ( @colNames ) {

		if ( $row->{$column} ) {
			# if number of elements for column is less than the 
			# maximum required number of elements, push it onto
			# the array
			if ( $#{$colData{$column}} < $maxSampleElement ) {
				push @{$colData{$column}}, $row->{$column};
			}
		}

		if ( $#{$colData{$column}} < $maxSampleElement ) {
			$maxSampleReached = 0;
		}
	}

	last if $maxSampleReached;
}

$gq->finish;
$dbh->disconnect;

#print Dumper(\%colData);
foreach my $column ( sort keys %colData ) {
	print "$column:\n";
	print "\t", join("\n\t",@{$colData{$column}}),"\n";
}


sub usage {
	my $exitVal = shift;
	use File::Basename;
	$basename = basename($0);
	print qq/
$basename

usage: $basename -machine database_server -database instance -username account 

/;
	exit $exitVal;
};

sub dumpit {
	print Dumper(\%colData);
	$gq->finish;
	$dbh->disconnect;
	exit;
}
