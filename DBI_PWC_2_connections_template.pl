#!/home/oracle/perl/bin/perl

# template for DBI programs

use warnings;
use FileHandle;
use DBI;
use strict;
use PDBA::ConfigFile;

use Getopt::Long;

my %optctl = ();

Getopt::Long::GetOptions(
	\%optctl, 
	"database=s",
	"username=s",
	"password=s",
	"test_database=s",
	"test_username=s",
	"test_password=s",
	"conf=s",
	"sysdba!",
	"sysoper!",
	"z","h","help");

my($targetDb, $targetUsername, $targetPassword, $connectionMode);
my($testDb, $testUsername, $testPassword);

# if you use a config file
if ( defined($optctl{conf}) ) {
	unless ( new PDBA::ConfigLoad( FILE => $optctl{conf} ) ) {
   	die "could not load config file  $optctl{conf}\n";
	}
}

for my $key ( keys %pwc::optctl ) {
	$optctl{$key} = $pwc::optctl{$key} unless exists $optctl{$key};
}

my $machine='all';
my $myusername=$optctl{my_username};
my $mypassword=$optctl{my_password};
my $key=$optctl{key};
my $host=$optctl{host};
my $port=$optctl{port};
my $debug=$optctl{debug};

$connectionMode = '';
if ( $optctl{sysoper} ) { $connectionMode = 'SYSOPER' }
if ( $optctl{sysdba} ) { $connectionMode = 'SYSDBA' }

if ( ! defined($optctl{database}) ) {
	usage(1);
}
$targetDb=$optctl{database};

if ( ! defined($optctl{username}) ) {
	usage(2);
}
$targetUsername = $optctl{username};

if ( ! defined($optctl{test_database}) ) {
	usage(1);
}
$testDb=$optctl{test_database};

if ( ! defined($optctl{test_username}) ) {
	usage(2);
}
$testUsername=$optctl{test_username};

#print "myusername: $myusername\n";
#print "mypassword: $mypassword\n";
#print "key: $key\n";
#print "host: $host\n";
#print "port: $port\n";
#print "target db: $targetDb\n";
#print "target user: $targetUsername\n";

if ($optctl{password} ) {$targetPassword = $optctl{password} }
else {
	$targetPassword = getPasswordPWD(
		{
			HOST 				=> $host,
			PORT 				=> $port,
			PWD_USERNAME 	=> $myusername,
			PWD_PASSWORD	=> $mypassword,
			PWD_KEY			=> $key,
			MACHINE			=> $machine,
			INSTANCE			=> $targetDb,
			USERNAME			=> $targetUsername,
			DEBUG				=> defined($debug) ? 1 : 0,
		}
	);
}

if ($optctl{test_password} ) {$targetPassword = $optctl{test_password} }
else {
	$testPassword = getPasswordPWD(
		{
			HOST 				=> $host,
			PORT 				=> $port,
			PWD_USERNAME 	=> $myusername,
			PWD_PASSWORD	=> $mypassword,
			PWD_KEY			=> $key,
			MACHINE			=> $machine,
			INSTANCE			=> $testDb,
			USERNAME			=> $testUsername,
			DEBUG				=> defined($debug) ? 1 : 0,
		}
	);
}

my $targetDbh = DBI->connect(
	'dbi:Oracle:' . $targetDb, 
	$targetUsername, $targetPassword, 
	{ 
		RaiseError => 1, 
		AutoCommit => 0,
		ora_session_mode => $connectionMode
	} 
	);


die "Connect to  $targetDb failed \n" unless $targetDbh;

my $testDbh = DBI->connect(
	'dbi:Oracle:' . $testDb, 
	$testUsername, $testPassword, 
	{ 
		RaiseError => 1, 
		AutoCommit => 0,
		ora_session_mode => $connectionMode
	} 
	);

die "Connect to  $testDb failed \n" unless $testDbh;

# apparently not a database handle attribute
# but IS a prepare handle attribute
#$targetDbh->{ora_check_sql} = 0;
$targetDbh->{RowCacheSize} = 100;
#$testDbh->{ora_check_sql} = 0;
$testDbh->{RowCacheSize} = 100;

my $sql=q{select * from global_name};

my $targetSth = $targetDbh->prepare($sql,{ora_check_sql => 0});
my $testSth = $testDbh->prepare($sql,{ora_check_sql => 0});

$targetSth->execute;
$testSth->execute;

while( my $ary = $targetSth->fetchrow_arrayref ) {
	print "\t\t$ary->[0]\n";
}

while( my $ary = $testSth->fetchrow_arrayref ) {
	print "\t\t$ary->[0]\n";
}

$targetDbh->disconnect;
$testDbh->disconnect;

sub usage {
	my $exitVal = shift;
	$exitVal = 0 unless defined $exitVal;
	use File::Basename;
	my $basename = basename($0);
	print qq/

usage: $basename

  -database          target database
  -username          DBA account name for target database
  -password          DBA password for target database (optional)
  -test_database     database to create test user on
  -test_username     DBA logon username for test database
  -test_password     DBA password for test database
  -sysdba            logon as sysdba
  -sysoper           logon as sysoper

  passwords are optional only if the PWD password server is in use

  example:

  $basename -database dv07 -username system -test_database pr01 -test_username system
/;
   exit $exitVal;
};

sub getPasswordPWD {
	use PDBA::OPT;
	return PDBA::OPT->pwcOptions ( %{$_[0]} );
}


