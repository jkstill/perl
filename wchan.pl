#!/usr/bin/perl

use Time::HiRes qw( usleep );

my $uSleep=10000;

my $PID=$ARGV[0] || die "Please supply the pid\n";

my $WCHAN=qq{/proc/${PID}/wchan};

-r $WCHAN || die "cannot read $WCHAN\n";

my $stallSeconds=0;

$|++; # do not buffer output

while (1) {
	open WCHAN, '<', $WCHAN || die "cannot open $WCHAN\n";
	my $wait = <WCHAN>;
	#print "$wait ";
	if ( $wait =~ /0/  ) {
		$stallSeconds += $uSleep;
	} else {
		printf "Stalled on %s for %3.2f\n", $wait, $stallSeconds/1e6;
		$stallSeconds = 0;
	}
	usleep($uSleep);
}
