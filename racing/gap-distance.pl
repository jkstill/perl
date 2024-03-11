#!/usr/bin/env perl

use strict;
use warnings;

use Getopt::Long;

use constant FEET_PER_MILE => 5280;
use constant CAR_LENGTH => 17.1; # feet

my $traceFile='- no file specified';
my $opLineLen=80;
my $number=12.34;
my $help=0;
my @multOpts=();

my ($timeGap,$trackLength,$avgSpeed,$lapTime,$timeChart,$unitTest);

# speed and distance are in miles

GetOptions (
	"g|time-gap=f" => \$timeGap,
	"l|track-length=f" => \$trackLength,
	"a|avg-speed=f"  => \$avgSpeed,
	"t|lap-time=f"  => \$lapTime,
	"c|time-chart!" => \$timeChart,
	"u|test!" => \$unitTest,
	"z|h|help!" => \$help,
) or die usage(1);

usage() if $help;

$timeGap ||= 0;
$trackLength ||= 0;
$avgSpeed ||= 0;
$lapTime ||= 0;
$timeChart ||= 0;
$help ||= 0;
$unitTest ||= 0;

my $mode='';  # CHART or GAP(distance)

print qq{
     time-gap: $timeGap
 track-length: $trackLength
    avg-speed: $avgSpeed
     lap-time: $lapTime
   time-chart: $timeChart
         help: $help 
} if 0;

$mode = ($unitTest) ? "TEST" : "";
if (!$mode) {  $mode = ($timeGap+0 && $avgSpeed+0) ? "GAP" : ""; }
if (!$mode) {  $mode = ($timeGap+0 && $lapTime+0 && $trackLength+0) ? "GAP" : ""; }
if (!$mode) {  $mode = ($timeChart+0 && $avgSpeed+0) ? "CHART" : ""; }
if (!$mode) {  $mode = ($timeChart+0 && $lapTime+0 && $trackLength+0) ? "CHART" : ""; }

die usage(1) unless $mode;

if ( $mode eq 'TEST' ) {
	print "testing...\n";

	my $exitStatus = test();

	exit $exitStatus;

} elsif ( $mode eq 'GAP' ) {

	my $feetPerSecond = getDistancePerSecond($trackLength, $lapTime, $avgSpeed);
	my $gapDistance = $feetPerSecond * $timeGap;

	if ($trackLength and $lapTime) {
		$avgSpeed = getAvgSpeed($trackLength, $lapTime);
	}

	printf("        gap: %6.3f feet\n",$gapDistance);
	printf("  avg speed: %3.2f\n", $avgSpeed);
	printf("car lengths: %5.1f\n" , $gapDistance / CAR_LENGTH);
	exit;

} elsif ( $mode eq 'CHART' ) {

	my $feetPerSecond = getDistancePerSecond($trackLength, $lapTime, $avgSpeed);
	my ($d0001, $d0010, $d0100, $d1000) = (
		$feetPerSecond * 0.001,
		$feetPerSecond * 0.010,
		$feetPerSecond * 0.100,
		$feetPerSecond * 1.000
	);

	# avoid 'printf (...) interpreted as function at ./gap-distance.pl '
	# it does not make sense - the first printf generates this warning
	# the second printf does not generate a warning
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

  printf("avg speed: %-3.2f\n\n", $avgSpeed ? $avgSpeed : getAvgSpeed($trackLength,$lapTime));

} else {
	die "something bad happened\n";
}

sub getAvgSpeed {
	my ($trackLength, $lapTime) = @_;

	# lap times are in seconds
	return (($trackLength )  / $lapTime ) * 3600 ;
}

sub getDistancePerSecond {
	my ($trackLength, $lapTime, $avgSpeed) = @_;
	# average speed should be MPH

	my $feetPerSecond;

	if ($avgSpeed) {
		$feetPerSecond = ($avgSpeed * FEET_PER_MILE) / 3600;
	} else {
		my $trackLengthInFeet = $trackLength * FEET_PER_MILE;
		$feetPerSecond = ($trackLengthInFeet / $lapTime ) ;
	}

	return $feetPerSecond;
}

sub test {

	my $exitStatus=0;

	my $avgSpeed = getAvgSpeed(1,36);

	if ( $avgSpeed == 100) {
		print "avgSpeed of $avgSpeed ok\n";
	} else {
		warn "avgSpeed of $avgSpeed should be 100\n";
		$exitStatus = $exitStatus ? $exitStatus : 1;
	}

	my $feetPerSecond = sprintf('%3.2f', getDistancePerSecond(1, 36, 0));

	if ($feetPerSecond == 146.67) {
		print "feetPerSecond of $feetPerSecond OK\n";
	} else {
		warn "feetPerSecond of $feetPerSecond should be 146.67\n";
		$exitStatus = $exitStatus ? $exitStatus : 1;
	}

	return $exitStatus;
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
  
examples:

$  ./gap-distance.pl --track-length 1 --lap-time 36.0 --time-chart

  distance covered per time duration in seconds:

  0.001: 0.15
  0.010: 1.47
  0.100: 14.67
  1.000: 146.67

avg speed: 100.00

==================================================================

$  ./gap-distance.pl --avg-speed 100 --time-chart

  distance covered per time duration in seconds:

  0.001: 0.15
  0.010: 1.47
  0.100: 14.67
  1.000: 146.67

avg speed: 100.00

$  ./gap-distance.pl --track-length 1 --lap-time 36.0 --time-gap 0.375
gap: 55.000 feet
  3.2 car lengths


==================================================================

$  ./gap-distance.pl --track-length 1 --lap-time 36.0 --time-gap 0.375
        gap: 55.000 feet
  avg speed: 100.00
car lengths:   3.2


==================================================================

$  ./gap-distance.pl --avg-speed 100 --time-gap 0.375
        gap: 55.000 feet
  avg speed: 100.00
car lengths:   3.2

 
};

	exit eval { defined($exitVal) ? $exitVal : 0 };
}

