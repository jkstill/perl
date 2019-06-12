#!/usr/bin/perl


my $duration = $ARGV[0];

unless ($duration) {
	print "Please enter a duration in seconds\n";
	die "example:  countdown.pl 100\n";
}

print "counting down from $duration seconds\n";

my $time;
foreach  (my $i=$duration;$i>=1; $i--){
	sleep 1;
	my $minutes=int($i/60);
	my $seconds=$i%60;
	$time = sprintf("%02.0f:%02.0f \n",$minutes,$seconds);
	#print $time;
	print $time;
}
