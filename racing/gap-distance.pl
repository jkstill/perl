#!/usr/bin/env perl

use strict;
use warnings;

use Getopt::Long;

# simpler method of assigning defaults with Getopt::Long

my $traceFile='- no file specified';
my $opLineLen=80;
my $number=12.34;
my $help=0;
my @multOpts=();

my ($timeGap,$trackLength,$avgSpeed,$lapTime,$timeChart);

# speed and distance are in miles

GetOptions (
	"time-gap=f" => \$timeGap,
	"track-length=f" => \$trackLength,
	"avg-speed=f"  => \$avgSpeed,
	"lap-time=f"  => \$lapTime,
	"time-chart!" => \$timeChart,
	"z|h|help!" => \$help,
) or die usage(1);

usage() if $help;

$timeGap ||= 0;
$trackLength ||= 0;
$avgSpeed ||= 0;
$lapTime ||= 0;
$timeChart ||= 0;
$help ||= 0;

my $mode='';  # CHART or GAP(distance)

print qq{
     time-gap: $timeGap
 track-length: $trackLength
    avg-speed: $avgSpeed
     lap-time: $lapTime
   time-chart: $timeChart
         help: $help 
} if 0;


$mode = ($timeGap+0 && $avgSpeed+0) ? "GAP" : "";
if (!$mode) {  $mode = ($timeGap+0 && $lapTime+0 && $trackLength+0) ? "GAP" : ""; }
if (!$mode) {  $mode = ($timeChart+0 && $avgSpeed+0) ? "CHART" : "";}
if (!$mode) {  $mode = ($timeChart+0 && $lapTime+0 && $trackLength+0) ? "CHART" : "";}

die usage(1) unless $mode;

my $feetPerSecond = getDistancePerSecond($trackLength, $lapTime, $avgSpeed);

#print "feetPerSecond: $feetPerSecond\n";

if ( $mode eq 'GAP' ) {

	my $carLength = 17.1; # feet
	my $gapDistance = $feetPerSecond * $timeGap;
	printf("gap: %6.3f feet\n",$gapDistance);
	printf("%5.1f car lengths\n" , $gapDistance / $carLength);
	exit;

} elsif ( $mode eq 'CHART' ) {

	my ($d0001, $d0010, $d0100, $d1000) = (
		$feetPerSecond * 0.001,
		$feetPerSecond * 0.010,
		$feetPerSecond * 0.100,
		$feetPerSecond * 1.000
	);

	no warnings 'syntax';

	printf (
qq{
  distance covered per time duration in seconds:

  0.001: %-3.2f
  0.010: %-3.2f
  0.100: %-3.2f
  1.000: %-3.2f 
  \n},
  $d0001, $d0010, $d0100, $d1000);

} else {
	die "something bad happened\n";
}


sub getDistancePerSecond {
	my ($trackLength, $lapTime, $avgSpeed) = @_;
	# average speed should be MPH

	my $feetPerMile = 5280;
	my $feetPerSecond;

	if ($avgSpeed) {
		$feetPerSecond = ($avgSpeed * $feetPerMile)	/ 3600;
	} else {
		my $trackLengthInFeet = $trackLength * $feetPerMile;
		$feetPerSecond = ($trackLengthInFeet / $lapTime ) ;
	}

	return $feetPerSecond;
}

sub usage {

	my $exitVal = shift;
	use File::Basename;
	my $basename = basename($0);
	print qq{
$basename

usage: $basename - show figures for the distance beween cars in a race
                   or a chart of distance covered for various amounts of time
                   given the track length and lap time, or the average speed
                   speed and distance are in miles

valid combinations of options:

this combination of options will show the distance between 2 cars

 --time-gap --avg-speed 
 --time-gap --lap-time --track-length

 
this combination of options print a chart of distance covered for 0.001, 0.01, 0.1, and 1 second

 --time-chart --avg-speed 
 --time-chart --lap-time --track-length

if other options are included, the precedence will be in the order shown


  $basename <options>

  --g|time-gap      time in seconds between 2 cars
  --l|track-length  length in miles of the tracl
  --a|avg-speed     avg lap speed in MPH
  --t|lap-time      lap time in seconds
  --c|time-chart    print a time chart
  --z|h|help!
  
examples here:

   $basename --file DWDB_ora_63389.trc --op-line-len 120 --mult-opts A --mult-opts B
};

	exit eval { defined($exitVal) ? $exitVal : 0 };
}

