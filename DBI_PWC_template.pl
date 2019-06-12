#!/home/oracle/perl/bin/perl

# template for DBI programs

use warnings;
use FileHandle;
use DBI;
use strict;
use PDBA::ConfigFile;
use PDBA::CM;

use Getopt::Long;

my %optctl = ();

Getopt::Long::GetOptions(
	\%optctl, 
	"database=s",
	"username=s",
	"password=s",
	"conf=s",
	"sysdba!",
	"sysoper!",
	"z","h","help");

my($db, $username, $password, $connectionMode);

# if you use a config file
if (defined $optctl{conf} ) {
	unless ( new PDBA::ConfigLoad( FILE => $optctl{conf} ) ) {
   	die "could not load config file  $optctl{conf}\n";
	}
}

for my $key ( keys %pwc::optctl ) {
	$optctl{$key} = $pwc::optctl{$key} unless exists $optctl{$key};
}

my $machine='all';
my $instance=$optctl{database};
my $myusername=$optctl{my_username};
my $mypassword=$optctl{my_password};
my $key=$optctl{key};

$connectionMode = '';
if ( $optctl{sysoper} ) { $connectionMode = 'SYSOPER' }
if ( $optctl{sysdba} ) { $connectionMode = 'SYSDBA' }

if ( ! defined($optctl{database}) ) {
	usage(1);
}
$db=$optctl{database};

if ( ! defined($optctl{username}) ) {
	usage(2);
}

$username=$optctl{username};

if ($optctl{password} ) {$password = $optctl{password} }
else {
	$password = getPasswordPWD(
		{
			HOST 				=> $optctl{host},
			PORT 				=> $optctl{port},
			PWD_USERNAME 	=> $optctl{my_username},
			PWD_PASSWORD	=> $optctl{my_password},
			PWD_KEY			=> $optctl{key},
			MACHINE			=> $machine,
			INSTANCE			=> $optctl{database},
			USERNAME			=> $optctl{username},
			DEBUG				=> defined($optctl{debug}) ? 1 : 0,
		}
	);
}

my $dbh = new PDBA::CM(
	DATABASE => $instance, 
	USERNAME => $username, 
	PASSWORD => $password, 
	MODE => $connectionMode,
	);

die "Connect to  $db failed \n" unless $dbh;

# apparently not a database handle attribute
# but IS a prepare handle attribute
#$dbh->{ora_check_sql} = 0;
$dbh->{RowCacheSize} = 100;

my $sql=q{select * from dual};

my $sth = $dbh->prepare($sql,{ora_check_sql => 0});

$sth->execute;

while( my $ary = $sth->fetchrow_arrayref ) {
	#print "\t\t$${ary[0]}\n";
	print "\t\t$ary->[0]\n";
}

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


sub getPasswordPWD {
	use PDBA::OPT;
	return PDBA::OPT->pwcOptions ( %{$_[0]} );
}
