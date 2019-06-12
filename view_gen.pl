#!/home/oracle/perl/bin/perl

# view_gen.pl
# generate a view for each table in a schema
# jared still 8/9/2007
# jkstill@gmail.com

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
	"table_owner=s",
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

if ( ! defined($optctl{table_owner}) ) {
	usage(3);
}

my $tabOwner = $optctl{table_owner};

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

my %a=();

my $colsql=q{select column_id, column_name from dba_tab_columns where owner = upper(?) and table_name = upper(?)};
my $sth=$dbh->prepare($colsql,{ora_check_sql => 0});
my $tabary = $dbh->selectall_arrayref(q{select owner,table_name from dba_tables where owner = upper(?)}, \%a,($tabOwner));


foreach my $tab ( @${tabary} ) {
	my ($owner,$tableName) = @${tab};
	$sth->execute(@{$tab});
	my $colhash = $sth->fetchall_hashref(q{COLUMN_ID});
	#print "$owner.$tableName\n";
	#print Dumper($colhash);
	# use form of sort to force numeric sort on column_id
	my @ary=map { $colhash->{$_}{COLUMN_NAME} } sort {$a <=> $b} keys %{$colhash};
	#print Dumper(\@ary);

	print "create or replace view ${tableName}_v as\n";
	print "select\n\t";
	print join(", \n\t",@ary), "\n";
	print "from $tableName\n";
	print qq{/\n};
	print qq{--===============================\n\n};


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
  -password      target instance account password
  -table_owner   owner of tables to create views from
  -sysdba        logon as sysdba
  -sysoper       logon as sysoper

  example:

  $basename -database orcl -username scott -password tiger -sysdba 
/;
   exit $exitVal;
};



