#!/usr/bin/perl

use Time::HiRes qw(gettimeofday);
use Data::Dumper;

my $traceFile = $ARGV[0];

open TRACEFILE, "<$traceFile" || die "cannot optn $traceFile - $!\n";

# Seem to need a conversion factor of 976,562.5 is 1,000,000,000/1024
sub convert_tim {
	 my $factor = 1_000_000_000/1024;
	 return $_[0]/$factor;
}

#my $sec = convert_tim(1330623405514072);
#printf "Seconds since epoch (scalar): %d\n", $sec;
#printf "Scalar: %s\n", scalar(localtime($sec));

my $COUNT;
my $totalMicroSecs=0;
my $totalSecs=0;
my $minWaitTime=0;
my $maxWaitTime=0;
my $minFetchTime=0;
my $maxFetchTime=0;
my $minExecTime=0;
my $maxExecTime=0;
my $minParsTime=0;
my $maxParsTime=0;
my $startTime=0;
my $endTime=0;

print "\n\n";

while (<TRACEFILE>) {

	if (/^ERROR/) {
		print;print "\n";
	}

	next unless /^(WAIT|EXEC|FETCH)/;

	#print;
	#next;

=head1 Line formats

EXEC #20:c=0,e=105,p=0,cr=0,cu=0,mis=0,r=0,dep=1,og=4,tim=1330623739641441
WAIT #19: nam='db file sequential read' ela= 1403 file#=420 block#=17125 blocks=1 obj#=378974 tim=1330623405569521
FETCH #20:c=0,e=8,p=0,cr=1,cu=0,mis=0,r=0,dep=1,og=4,tim=1330623481080625
PARSE #19:c=999,e=805,p=0,cr=0,cu=0,mis=1,r=0,dep=1,og=4,tim=1330629299607880

=cut

	$COUNT++;
	#print;
	chomp;

	my $tim;

	if ( /^WAIT/ ) {

		my @ary	= split(/ +/,$_);
		my $waitTime =  $ary[7];
		$minWaitTime = $waitTime unless $waitTime > $minWaitTime;
		$maxWaitTime = $waitTime unless $waitTime < $maxWaitTime;
		$totalMicroSecs += $waitTime;
		$tim=$ary[12];

	}

	if ( /^FETCH/ ) {
		my $dummy;
		my @ary	= split(/,/,$_);
		my $waitTime =  $ary[1];
		($dummy,$waitTime)=split(/=/,$waitTime);
		$minFetchTime = $waitTime unless $waitTime > $minFetchTime;
		$maxFetchTime = $waitTime unless $waitTime < $maxFetchTime;
		$totalMicroSecs += $waitTime;
		$tim=$ary[9];
	}

	if ( /^PARSE/ ) {
		my $dummy;
		my @ary	= split(/,/,$_);
		my $waitTime =  $ary[1];
		($dummy,$waitTime)=split(/=/,$waitTime);
		$minParsTime = $waitTime unless $waitTime > $minParsTime;
		$maxParsTime = $waitTime unless $waitTime < $maxParsTime;
		$totalMicroSecs += $waitTime;
		$tim=$ary[9];
	}

	if ( /^EXEC/ ) {
		my $dummy;
		my @ary	= split(/,/,$_);
		my $waitTime =  $ary[1];
		($dummy,$waitTime)=split(/=/,$waitTime);
		$minExecTime = $waitTime unless $waitTime > $minExecTime;
		$maxExecTime = $waitTime unless $waitTime < $maxExecTime;
		$totalMicroSecs += $waitTime;
		$tim=$ary[9];
	}

	my $dummy;
	($dummy,$tim)=split(/=/,$tim);
	
	$startTime = $tim if $startTime == 0;
	$endTime = $tim unless $tim < $endTime;
	
	#print Dumper(\@ary);
	#print "wait: $ary[7]\n";

}

#print "start time: $startTime\n";
#print "  end time: $endTime\n";

$startTime=convert_tim($startTime);
$endTime=convert_tim($endTime);

#print "start time: $startTime\n";
#print "  end time: $endTime\n";

print "Max Wait  Raw: $maxWaitTime\n";
print "Max Exec  Raw: $maxExecTime\n";
print "Max Fetch Raw: $maxFetchTime\n";

$totalSecs=$totalMicroSecs / 1_000_000;

# these 2 times are in seconds
my $totalElapsedTime = $endTime - $startTime;
my $unaccountedTime = ( $endTime - $startTime - $totalSecs);

printf "\nStart Time: %s\n", scalar(localtime($startTime));
printf "  End Time: %s\n", scalar(localtime($endTime));
printf "Elapsed Time in Seconds: %6.2f\n",$totalElapsedTime;

printf "\nWaits+Exec+Fetch

Wait Count	 : %10i
Microseconds : %10i
Total Seconds: %6.2f
Min Wait Sec : %2.6f
Max Wait Sec : %2.6f
Avg Wait Sec : %2.6f
Min Fetch Sec: %2.6f
Max Fetch Sec: %2.6f
Min Exec Sec : %2.6f
Max Exec Sec : %2.6f
Min Pares Sec: %2.6f
Max Pares Sec: %2.6f
Unaccounted  : %6.2f
", $COUNT, $totalMicroSecs, $totalSecs, 
	$minWaitTime/1_000_000, $maxWaitTime/1_000_000, $totalMicroSecs/$COUNT/1_000_000,
	$minFetchTime/1_000_000, $maxFetchTime/1_000_000,
	$minExecTime/1_000_000, $maxExecTime/1_000_000,
	$minParsTime/1_000_000, $maxParsTime/1_000_000,
	$unaccountedTime;


