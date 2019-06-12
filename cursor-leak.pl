#!/usr/bin/env perl

# template for DBI programs

use warnings;
use FileHandle;
use strict;
use Time::HiRes qw ( usleep );

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

With older versions of DBD::Oracle you will need to either
save/restore the signal handlers, or install your own.

=cut

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

use DBI;

my $connectAttr = getConnectAttributes();
my $SIGPreserve = getSigPreserve();

use Getopt::Long;

my $db = '';
my $username = '';
my $password = '';
my $connectionMode = 0;
my $sysdba = 0;
my $sysoper = 0;
#
my $initialCursors=20; # number of cursors to initially start with - simulate an app
my $maxIterations = 2000; # default number of cursors to attempt
my $intervalSeconds = 1; # default seconds between cursor executions
# 1 in 7 cursors leaked by default ( unless --noleak option )
#cursor 0 always leaked for int(rand(7))
my $leakRate = 7;
my $leakCursors=1;  # leak cursors by default - disable with --noleak
my $seed=42;  # for predictable results - this is a testing script
srand $seed;

Getopt::Long::GetOptions(
	"database=s" => \$db,
	"username=s" => \$username,
	"password=s" => \$password,
	"interval-seconds=f" => \$intervalSeconds,
	"iterations=i" => \$maxIterations,
	"leak-rate=i" => \$leakRate,
	"cursor-leak!" => \$leakCursors,
	"sysdba!" => \$sysdba,
	"sysoper!" => \$sysoper,
	"z","h","help");

if ( $sysoper ) { $connectionMode = 4 }
if ( $sysdba ) { $connectionMode = 2 }

$connectAttr->{ora_session_mode} = $connectionMode;

if ( ! $db ) {
	usage(1);
}

if ( ! $username ) {
	usage(2);
}

#print 'Connect Attributes: ', Dumper($connectAttr),"\n";
#print "USERNAME: $username\n";
#print "DATABASE: $db\n";
#print "PASSWORD: $password\n";
#exit;


my $dbh = DBI->connect(
	'dbi:Oracle:' . $db, 
	$username, $password, 
	$connectAttr
);

die "Connect to  $db failed \n" unless $dbh;
$dbh->{RowCacheSize} = 100;

#restore signal handlers following the connect
if ($SIGPreserve eq 'manual') {
	print "Resetting Signal Handlers\n";
	%SIG=%SIG;
} else {
	undef %SIG;
}
	
# handle CTL-C/signals and cleanup
$SIG{INT}  = \&sigint;
$SIG{QUIT} = \&sigint;
$SIG{TERM} = \&sigint;

# this script will just keep leaking cursors until it crashes

my $sql=q{select user,systimestamp from dual};
my %sth=();
my $cursorsOpen=1;

# open a set number of cursors to simulate an app

print "Opening initial set of $initialCursors application cursors to simulate normal application usage\n";

foreach my $i ( 1 .. $initialCursors ) {
	$cursorsOpen++;
	$sth{$i} = $dbh->prepare($sql,{ora_check_sql => 0});
	$sth{$i}->execute;
	my $ary = $sth{$i}->fetchrow_arrayref;
}
$cursorsOpen++;

#my $dummy= <>;

# set to 'forever' if 0
$maxIterations = $maxIterations ? $maxIterations : 1e10;

print "Iterations To Run: $cursorsOpen .. $maxIterations\n";

foreach my $i ( $cursorsOpen .. $maxIterations ) {

	$sth{$i} = $dbh->prepare($sql,{ora_check_sql => 0});
	$sth{$i}->execute;
	my $ary = $sth{$i}->fetchrow_arrayref;
	
	if ( $leakCursors ) {
		# always leak the cursor when int(rand()) returns 0
		if ( int(rand($leakRate)) ) {
			delete $sth{$i};
		} else { # rand returned 0
			$cursorsOpen++;
		}
	} else {  ## --noleak
		# always remove cursor handle from hash if --noleak
		# DBD::Oracle undefs and closes the statement handle
		delete $sth{$i};
	}

	print "i: $i - c: $cursorsOpen - ", join(' ==>> ', @{$ary}),"\n";

	# usleep take microseconds as an argument
	usleep 1e6 * $intervalSeconds;

}

cleanup();

sub usage {
	my $exitVal = shift;
	$exitVal = 0 unless defined $exitVal;
	use File::Basename;
	my $basename = basename($0);
	print qq/

usage: $basename

  --database                target instance
  --username                target instance account name
  --password                target instance account password
  --sysdba                  logon as sysdba
  --sysoper                 logon as sysoper
  --interval-seconds        seconds between cursors. ie 1.5
  --iterations              max number of iterations
                            set to 0 to run forever
  --cursor-leak             default is to leak cursors. use --nocursor-leak to not leak cursors
  --leak-rate               how frequently to leak a cursor - default is 7
                            when int(rand(leakRate)) == 0 the cursor will be leaked.
                            as this is using rand() it does not mean every Nth cursor will be leaked

  example:

  $basename -database dv07 -username scott -password tiger -sysdba --interval-seconds 2 --iterations 4000
/;
   exit $exitVal;
};

sub cleanup {
	# closes all statement handles
	undef %sth;
	$dbh->disconnect;
}

sub sigint {
	print "Caught INT/QUIT/TERM...\n";
	cleanup();
	exit 42;
}


