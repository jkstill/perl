#!/home/oracle/perl/bin/perl

# template for DBI programs

use FileHandle;
use DBI;
use strict;
no strict 'vars';

use Getopt::Long;

my %optctl = ();

Getopt::Long::GetOptions(\%optctl, "database:s","username:s","password:s","z","h","help");

#setup environment - homegrown package

my($db, $username, $password);

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

if ( ! defined($optctl{password}) ) {
	Usage();
	die "password required\n";
}
$password=$optctl{password};

#print "USERNAME: $username\n";
#print "DATABASE: $db\n";
#print "PASSWORD: $password\n";
#exit;

# setup your Oracle environment before running this
# or ( less optimal ) set it up here
# $ENV{ORACLE_SID}='my_sid';
# $ENV{ORACLE_HOME}='/obase/product/8.1.5';
# $ENV{TNS_ADMIN}='/obase/product/8.1.5/network/admin/';

$dbh = DBI->connect('dbi:Oracle:' . $db, $username, $password, { RaiseError => 1, AutoCommit => 0 } );

die "Connect to  $db failed \n" unless $dbh;

$MySql="select \* from dual";

$sth = $dbh->prepare($MySql);

my $rv = $sth->execute;

while( $ary = $sth->fetchrow_arrayref ) {
	print "\t\t$${ary[0]}\n";
}

$sth->finish;
$dbh->disconnect;

sub Usage {
	print "\n";
	print "usage:  connect.pl\n";
	print "    connect.pl -database dv07 -username scott -password tiger\n";
	print "\n";
}



