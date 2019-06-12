#!/usr/bin/env perl

# template for DBI programs

use DBI;
use strict;
use warnings;

my($db, $username, $password) = ('//ora122rac01/js1.jks.com ','jkstill','password');

$|++;
my $action=\&continueProgram;
my $dbh;


{
	$SIG{ALRM}=\&sigAlarm;
	alarm(5);
	$dbh = DBI->connect('dbi:Oracle:' . $db, $username, $password, { RaiseError => 1, AutoCommit => 0 } );
	&$action;
	alarm(0);
}

die "Connect to  $db failed \n" unless $dbh;

my $MySql="select \* from dual";

my $sth = $dbh->prepare($MySql);

my $rv = $sth->execute || die "error with statement $MySql \n";

while( my $ary = $sth->fetchrow_arrayref ) {
	print "\t\t$${ary[0]}\n";
}

$dbh->disconnect;

sub Usage {
	print "\n";
	print "usage:  DBI_template.pl\n";
	print "    DBI_template.pl -database dv07 -username scott\n";
	print "\n";
}


sub sigAlarm {
	print "Checking Alarm\n";
	$action = \&exitProgram;
	return 0;
}

sub exitProgram {
	print "\nexiting via exitProgram\n";
	exit;
}

sub continueProgram { print "\ncontinuing via continueProgram\n" }

