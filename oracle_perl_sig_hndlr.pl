#!/usr/bin/env perl

=head1 Oracle 11gR2 INT Handler

CTL-C appears to be caught by Oracle
and then ignored.

This can be demonstrated by commenting out
the signal handler trap here, running the
script and hitting CTL-C.

You can see that it is being caught becuase
the next 'sleeping' line will appear immediately,
but the script continues.

If using DBD::Oracle 1.28 or later, the ora_connect_with_default_signals 
connection attribute can be used to correct this.

If using the Perl that is installed with Oracle, DBD::Oracle version 1.28 is installed with Oracle 12.1.0.2.

Oracle versions earlier than that will need to use the save and restore handles method.

With older versions of DBD::Oracle you will need to either
save/restore the signal handlers, or install your own.

=cut

use warnings;
use strict;
use Data::Dumper;

# get a copy of signal handlers to
# restore later, as Oracle catches CTL-C (INT)
local %SIG=%SIG;

BEGIN {
	our $SIGPreserve='manual';

	# ensure DBD::Oracle is available
	eval "require DBD::Oracle" or die "DBD::Oracle not found\n";

	my $DBDVersion = $DBD::Oracle::VERSION;
	our $connectAttr = {
		RaiseError => 1,
		AutoCommit => 0,
	};
	print "DBD::Oracle Version: $DBDVersion\n";
	if ($DBD::Oracle::VERSION + 0 >= 1.28) {
		print "Setting Signal Preserve to 'auto'\n";
		$SIGPreserve='auto';
		$connectAttr->{ora_connect_with_default_signals} =  [ 'INT' ] ;
	} else {
		print "Leaving Signal Preserve as $SIGPreserve\n";
	}

	sub getSigPreserve { return $SIGPreserve }
	sub getConnectAttributes { return $connectAttr }
}

my $connectAttr = getConnectAttributes();
my $SIGPreserve = getSigPreserve();

print 'Connect Attributes: ', Dumper($connectAttr),"\n";

use DBI;
use strict;

my $exit=0;

#my $dbh = DBI->connect(
	#'dbi:Oracle:' . 'vmdb01',
	#'scott', 'tiger',
	#$connectAttr
#);
my $dbh = DBI->connect(
	'dbi:Oracle:' . 'p1',
	'jkstill', 'grok',
	$connectAttr
);

die "Connect to database failed \n" unless $dbh;

#restore signal handlers following the connect
if ($SIGPreserve eq 'manual') {
	print "Resetting Signal Handlers\n";
	%SIG=%SIG;
} else {
	undef %SIG
}

while (1) {
	print "sleeping...\n";
	sleep 3;
	exit $exit if $exit;	
}


