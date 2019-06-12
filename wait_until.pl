#!/u01/app/perl/bin/perl

use Date::Manip;
use Date::Format;
use File::Basename;
use PDBA::ConfigFile;
use warnings;
use Data::Dumper;

use Getopt::Long;

our %optctl=();

GetOptions( \%optctl,
	"until_date=s",
	"debug!",
	"h|z|help" 
);

my $DEBUG = $optctl{debug} ? 1 : 0;

usage(1) if ( $optctl{h} or $optctl{z} or $optctl{help});

unless ( exists $optctl{until_date} ) { usage(1) }

my $rawUntilDate  = ParseDate($optctl{until_date});
my $untilDate = UnixDate($rawUntilDate,'%Y/%m/%d-%H:%M:%S');
unless ( $rawUntilDate ) {
	die "invalid date for  -until_date\n";
}
	
my $localtime = localtime();
print "localtime: ", Dumper(\$localtime) if $DEBUG;
my $rawCurrDate = ParseDate($localtime);
my $currDate = UnixDate($rawCurrDate,'%Y/%m/%d-%H:%M:%S');

my $sleepSeconds=1;
print "Sleep interval: $sleepSeconds seconds\n";

while (Date_Cmp($rawCurrDate,$rawUntilDate) < 0 ) {
	sleep $sleepSeconds;
	$localtime = localtime();
	$rawCurrDate = ParseDate($localtime);
	print "CurrDate: ",$currDate = UnixDate($rawCurrDate,'%Y/%m/%d-%H:%M:%S'),"\n" if $DEBUG ;
}


sub usage {

	my $exitVal = shift;
	use File::Basename;
	my $basename = basename($0);
	print qq{
$basename

usage: $basename - this script is a timer of sorts
                   it will run, doing nothing, until 
                   the time specified is reached

   $basename -until_date <VALID DATE FORMAT>

  -debug       turns debuggin on - off by default
  -until_date  date to ignore database until
  -h           print usage and exit
  -z           print usage and exit
  -help        print usage and exit

example:

   $basename -until_date '02/25/2010 15:30'
};

	exit $exitVal ? $exitVal : 0;
}

