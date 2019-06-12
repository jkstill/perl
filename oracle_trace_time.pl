#!/usr/bin/perl

use Time::HiRes qw(gettimeofday);
use Data::Dumper;

# Seem to need a conversion factor of 976,562.5 is 1,000,000,000/1024
sub convert_tim {
	 my $factor;
	 #$factor = 1_000_000_000/1024; # red hat linux - BSF - oracle 10g
	 #$factor = 1_000_000/1; # red hat linux 5.8 x86-64 - Linux 11.2.0.2 - straight microseconds
	 return $_[0]/$factor;
}


# excerpts from solaris 10046 trace
# *** ACTION NAME:(auto optimizer stats collection) 2013-03-28 18:25:47.426
# CLOSE #18446741324869165872:c=0,e=2,dep=2,type=0,tim=16533990311000


#*** 2013-03-28 21:22:20.488
#EXEC #18446741324853808120:c=10000,e=1073144,p=281,cr=617,cu=2,mis=1,r=0,dep=2,og=4,plh=3653753075,tim=16544582975529


my $sec;
#$sec = convert_tim(1364531752596038); # time from 11.2.0.2 linux 5.8 x86-64
# the problem with solaris times is that oracle records them from time of boot
#$sec = convert_tim(16533990311000); # time from 11.2.0.3 solaris 11 x86-64
#$sec = convert_tim(16544582975529); # time from 11.2.0.3 solaris 11 x86-64
printf "\n\n";
printf "Seconds since epoch (scalar): %d\n", $sec;
printf "Scalar: %s\n", scalar(localtime($sec));

my $startTime=0;
my $endTime=0;

print "\n\n";


$startTime=convert_tim(16533990312317);
$endTime=convert_tim(16544676015092);

$totalSecs=$totalMicroSecs / 1_000_000;

# these 2 times are in seconds
my $totalElapsedTime = $endTime - $startTime;

#printf "\nStart Time: %s\n", scalar(localtime($startTime));
#printf "  End Time: %s\n", scalar(localtime($endTime));
#printf "Elapsed Time in Seconds: %6.2f\n",$totalElapsedTime;



