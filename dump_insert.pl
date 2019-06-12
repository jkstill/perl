#!/home/oracle/perl/bin/perl

# template for DBI programs

use warnings;
use FileHandle;
use DBI;
use strict;
use PDBA::CM;
use PDBA::PWC;
use PDBA::ConfigFile;
use Data::Dumper;

use Getopt::Long;

my %optctl = ();
$optctl{conf} = 'pwc.conf';

Getopt::Long::GetOptions(
	\%optctl, 
	"database=s",
	"username=s",
	"password=s",
	"table=s",
	"conf=s",
	"sysdba!",
	"sysoper!",
	"z","h","help");

my($db, $username, $password, $connectionMode, $table);

unless ( new PDBA::ConfigLoad( FILE => $optctl{conf} ) ) {
   die "could not load config file  $optctl{conf}\n";
}

for my $key ( keys %pwc::optctl ) {
	$optctl{$key} = $pwc::optctl{$key} unless exists $optctl{$key};
}

my $remote_host=$optctl{host};
my $remote_port=$optctl{port};
my $machine='all';
my $instance=$optctl{database};
my $myusername=$optctl{my_username};
my $mypassword=$optctl{my_password};
my $key=$optctl{key};


$connectionMode = 0;
if ( $optctl{sysoper} ) { $connectionMode = 4 }
if ( $optctl{sysdba} ) { $connectionMode = 2 }

if ( ! defined($optctl{table}) ) {
	usage(1);
	die "table required\n";
}
$table=$optctl{table};

if ( ! defined($optctl{database}) ) {
	usage(2);
	die "database required\n";
}
$db=$optctl{database};

if ( ! defined($optctl{username}) ) {
	usage(3);
	die "username required\n";
}

$username=$optctl{username};

if ($optctl{password} ) {$password = $optctl{password} }
else {

	my $client = new PDBA::PWC(
		host => $remote_host,
		port => $remote_port
	);

	$client->authenticate(
		username => $myusername,
		password => $mypassword,
		key => $key,
		debug => $optctl{debug}
	);

	# get response
	$password = $client->getPassword(
		machine => $machine,
		instance => $instance,
		username => $username,
		key => $key,
		debug => $optctl{debug}
	);

}

my $dbh = new PDBA::CM(
	DATABASE => $instance,
	USERNAME => $username,
	PASSWORD => $password 
);


die "Connect to  $db failed \n" unless $dbh;

$dbh->{RowCacheSize} = 100;

my $sth = new PDBA::GQ ( $dbh, $table);

$sth->execute;
my $colNames = $sth->getColumns;
#print Dumper($colNames);

my @columns=();
foreach my $col ( keys %$colNames ){
	$columns[$colNames->{$col}] = $col;
}

# remove the PK key for generating inserts
if (exists $colNames->{PK}) {
	#print Dumper(\@columns);
	splice(@columns, $colNames->{PK},1);
	# recreate the handle with a list of columns
	$sth = new PDBA::GQ ( $dbh, $table, { COLUMNS => \@columns } );
}

while( my $ary = $sth->next([]) ) {
	my @data = map { defined($_) ? $_ : '' } @$ary;
	print qq{insert into $table(} . join(',', @columns) . q{) values(} .
		qq{'} . join(q{','},@data) . qq{');\n} ;
}

$sth->finish;
$dbh->disconnect;

sub usage {
	my $exitVal = shift;
	$exitVal = 0 unless defined $exitVal;
	use File::Basename;
	my $basename = basename($0);
	print qq/

usage: $basename

  -database      target instance
  -username      target instance account name
  -password      target instance account password (optional)
  -sysdba        logon as sysdba
  -sysoper       logon as sysoper

  passwords are optional only if the PWD password server is in use

  example:

  $basename -database dv07 -username scott -sysoper
/;
   exit $exitVal;
};


