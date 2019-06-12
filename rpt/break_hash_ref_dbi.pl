#!/usr/bin/perl -w

# template for DBI programs

use lib q{./};

use Tie::RPT;
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
	Usage();
	die "database required\n";
}
$db=$optctl{database};

if ( ! defined($optctl{username}) ) {
	Usage();
	die "username required\n";
}

$username=$optctl{username};
$password = $optctl{password};

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

my $sql=q{select owner, table_name, column_name
from all_tab_columns
where owner not in ( 'SYS', 'ORADES' )
order by owner, table_name, column_name};

my $sth = $dbh->prepare($sql);
my @columns = @{$sth->{NAME_uc}};
my %data = map{ $_, undef } @columns;

my($owner, $tableName, $columnName)=('a','a','a');

my $hr = {};

my $r = new Tie::RPT(
	HASHREF => $hr, # data container
	STH => $sth, # undef if not using DBI
	# COLUMNS args override $sth if present
	# column names and format field
	COLUMNS => {
		OWNER => '@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<',
		TABLE_NAME => '@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<',
		COLUMN_NAME => '@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<',
	},
	# columns to BREAK on
	BREAKS => [qw{OWNER TABLE_NAME}],
	PAGESIZE => 60,
	LINESIZE => 100,

);


#print q{$r: }, Dumper($r), "\n";
#print q{$hr: }, Dumper($hr), "\n";
#exit;


# this doesn't work, as the last row is undef,
# and causes a fatal error in %{}
#while( $hr = %{$sth->fetchrow_hashref} ) {

$sth->execute;
#while( my $href = $sth->fetchrow_hashref) {
while( %{$hr} = %{$sth->fetchrow_hashref} ) {

	#%{$hr} = %{$href};

	printf "%15s %30s %30s\n"
		, $hr->{OWNER}
		, $hr->{TABLE_NAME}
		, $hr->{COLUMN_NAME}
	;

}


$sth->finish;
$dbh->disconnect;

sub Usage {
	print "\n";
	print "usage:  DBI_template.pl\n";
	print "    DBI_template.pl -database dv07 -username scott -password tiger [-sysdba || -sysoper]\n";
	print "\n";
}



