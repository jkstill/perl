#!/usr/local/bin/perl -w

# DBI_template_colsize.pl
# use fetchall_arrayref and get max length of each column

use warnings;
use FileHandle;
use DBI;
use strict;
use Data::Dumper;

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

$dbh->do(q{alter session set nls_date_format='yyyy-mm-dd hh24:mi:ss'});
$dbh->do(q{alter session set nls_timestamp_format='yyyy-mm-dd hh24:mi:ss.ff'});
$dbh->do(q{alter session set nls_timestamp_tz_format='yyyy-mm-dd hh24:mi:ss.ff tzr'});

my $sql=q{select 
	object_name
	, subobject_name
	, object_id
	, data_object_id
	, object_type
	, created
	, last_ddl_time
	, timestamp
	, status
	, temporary
	, generated
	, secondary
	, namespace
	, edition_name
from user_objects};

my $sth = $dbh->prepare($sql,{ora_check_sql => 0});

$sth->execute;

my $aryref = $sth->fetchall_arrayref;

# get max length per column
# get column list into array
my @cols=@{$sth->{NAME_lc}};
my %cLengths = map{ $_ =>  1} @cols;

# column positions
my %cPos = map { $cols[$_] => $_ } 0..$#cols;

#print "cLengths: ", Dumper(\%cLengths), "\n";
#print "cPos: ", Dumper(\%cPos), "\n";
#print "cols: ", Dumper(\@cols), "\n";

foreach my $rowRef ( @{$aryref} ) {
	my @row=@{$rowRef};
	#print "ROW: ", Dumper(\@row),"\n";
	foreach my $col ( @cols ) {
		if (defined($row[$cPos{$col}])) {
			#print "COL: $col\n";
			if (length($row[$cPos{$col}]) > $cLengths{$col}) {
				$cLengths{$col} = length($row[$cPos{$col}]) ;
			}
		}
	}	
}

print "cLengths: ", Dumper(\%cLengths), "\n";
print "cPos: ", Dumper(\%cPos), "\n";

#foreach my $rowref ( @{$aryref} ) {
	#{
		#no warnings 'uninitialized';
		#print join(':',@{$rowref}),"\n";
	#}	
#}

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



