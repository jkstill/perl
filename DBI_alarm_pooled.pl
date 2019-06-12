#!/home/oracle/perl -w

# template for DBI programs

use DBI;
use strict;
no strict qw{vars refs};
use POSIX qw(:signal_h);

$|++;

my $dbh;

eval {
	my $mask = POSIX::SigSet->new( SIGALRM );
	my $action = POSIX::SigAction->new(
		sub { die "drcp-timeout: pool may be at 100% capacity\n" },        # the handler code ref
		$mask
	);
	my $oldaction = POSIX::SigAction->new();
	sigaction( SIGALRM, $action, $oldaction );

	eval {
		alarm(2);
		$dbh = DBI->connect(
			'dbi:Oracle://oravm-scan/oravm.jks.com:pooled' , 'jkstill', 'grok', 
			{ 
				ora_connect_with_default_signals => [ SIGALRM,SIGINT ],
				#RaiseError => 1, 
				#AutoCommit => 0,
			}
		);
		alarm(0);
	};
	alarm(0);
	sigaction( SIGALRM, $oldaction );  # restore original signal handler
	die "$@\n" if $@;
};

if ($@) {
	print "Error: $@\n";
}

die "Connect  failed \n" unless $dbh;

$MySql="select \* from dual";

$sth = $dbh->prepare($MySql);

my $rv = $sth->execute || die "error with statement $MySql \n";

while( $ary = $sth->fetchrow_arrayref ) {
	print "\t\t$${ary[0]}\n";
}

$dbh->disconnect;

sub Usage {
	print "\n";
	print "usage:  DBI_template.pl\n";
	print "    DBI_template.pl -database dv07 -username scott\n";
	print "\n";
}



