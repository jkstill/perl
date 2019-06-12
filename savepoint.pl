#!/home/oracle/perl/bin/perl -w

use Data::Dumper;
use warnings;
use FileHandle;
use DBI;
use strict;

use Getopt::Long;

my %optctl = ();

Getopt::Long::GetOptions(
	\%optctl, 
	"database=s",
	"username=s",
	"password=s",
	"sysdba!",
	"sysoper!",
	"z","h","help");

my($db, $username, $password, $connectionMode);

$connectionMode = 0;
if ( $optctl{sysoper} ) { $connectionMode = 4 }
if ( $optctl{sysdba} ) { $connectionMode = 2 }

if ( ! defined($optctl{database}) ) {
	usage(1);
}
$db=$optctl{database};

if ( ! defined($optctl{username}) ) {
	usage(2);
}

$username=$optctl{username};
$password = $optctl{password};

#print "USERNAME: $username\n";
#print "DATABASE: $db\n";
#print "PASSWORD: $password\n";
#exit;

my $dbh = DBI->connect(
	'dbi:Oracle:' . $db, 
	$username, $password, 
	{ 
		RaiseError => 1, 
		AutoCommit => 0,
		ora_session_mode => $connectionMode
	} 
	);

die "Connect to  $db failed \n" unless $dbh;

$dbh->{RowCacheSize} = 100;

eval { 
	local $dbh->{RaiseError} = 0;
	$dbh->do(q{drop table savepoint_test});
};

$dbh->do(q{create table savepoint_test(c1 integer)});

my $selectSQL=q{select c1 from savepoint_test};
my $insertSQL=q{insert into savepoint_test(c1) values(?)};
my $updateSQL=q{update savepoint_test set c1=c1+1};

# insert row
my $sth = $dbh->prepare($insertSQL,{ora_check_sql => 0});
$sth->execute(1);

# select initial value
$sth = $dbh->prepare($selectSQL,{ora_check_sql => 0});
$sth->execute;
my $retval = ($sth->fetchall_arrayref)->[0][0];
print "initial value: $retval\n";

# create savepoint
printf "create savepoint 'savepoint_t1'\n";
$dbh->do(q{savepoint savepoint_t1});

# update the row
$sth = $dbh->prepare($updateSQL);
$sth->execute;

# select updated value
$sth = $dbh->prepare($selectSQL,{ora_check_sql => 0});
$sth->execute;
$retval = ($sth->fetchall_arrayref)->[0][0];
print "updated value: $retval\n";

# rollback to savepoint
$dbh->do(q{rollback to savepoint savepoint_t1});

# select rolled back value
$sth = $dbh->prepare($selectSQL,{ora_check_sql => 0});
$sth->execute;
$retval = ($sth->fetchall_arrayref)->[0][0];
print "rolled back value: $retval\n";


$dbh->commit;
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
  -password      target instance account password
  -sysdba        logon as sysdba
  -sysoper       logon as sysoper

  example:

  $basename -database dv07 -username scott -password tiger -sysdba 
/;
   exit $exitVal;
};



