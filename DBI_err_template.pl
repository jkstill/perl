#!/usr/bin/env perl

# template for DBI programs

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

# apparently not a database handle attribute
# but IS a prepare handle attribute
#$dbh->{ora_check_sql} = 0;
$dbh->{RowCacheSize} = 100;

my $sql=q{select user from mydual};

my $sth = $dbh->prepare($sql,{ora_check_sql => 0});

eval {
	local $dbh->{RaiseError} = 1;
	local $dbh->{PrintError} = 0;
	$sth->execute;
};

if ($@) {
	my($err,$errStr) = ($dbh->err, $dbh->errstr);
	$dbh->disconnect;
	if ($err == 942) {
		die qq{This script is attempting to access the table "mydual" which does not exist or is inaccessible\n};
	} else {
		die qq{query died - $err - $errStr\n};
	}
}


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
  -password      target instance account password
  -sysdba        logon as sysdba
  -sysoper       logon as sysoper

  example:

  $basename -database dv07 -username scott -password tiger -sysdba 
/;
   exit $exitVal;
};



