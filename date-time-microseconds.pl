#!/usr/bin/env perl

use strict;
use warnings;
use DateTime;
use POSIX qw( strftime );

my $date='2019-07-09T09:57:08.690155-07:00';

print "Date: $date\n";
print "getDate: ", getDate($date), "\n";

my ($year, $month, $day, $hour, $minute, $second, $microsecond) = parseDateStr($date);
my $dt = createDate($second,$minute,$hour,$day,$month,$year,$microsecond);
my $ds = getDate($dt);

print "DS: $ds\n";
$dt->add( nanoseconds => 200000 * 1000);
$ds = getDate($dt);
print "DS: $ds\n";

# pass DateTime type
# or dateStr of ISO8601 format
sub getDate {
	my $dt = shift;;
	my ($year, $month, $day, $hour, $minute, $second, $microsecond);

	if (ref($dt)) {
		($second,$minute,$hour,$day,$month,$year,$microsecond)
			= ($dt->second,$dt->minute,$dt->hour,$dt->day,$dt->month,$dt->year,$dt->nanosecond / 1000);
	} else {
		($year, $month, $day, $hour, $minute, $second, $microsecond) = parseDateStr($dt);
	}

	return formatDate($second,$minute,$hour,$day,$month,$year,$microsecond);
}

# oracle trace date string
sub parseDateStr {
	my $dateStr = shift;

	#my ($year, $month, $day, $hour, $minute, $second, $microsecond)
	#= ( $dateStr =~ /^\*{0,3}\s*([0-9]{4})-([0-9]{2})-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})\.([0-9]{6})/ );

	my @dateParts = ( $dateStr =~ /^\*{0,3}\s*([0-9]{4})-([0-9]{2})-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})\.([0-9]{6})/ );

	return @dateParts;
}

sub formatDate {
	my ($second,$minute,$hour,$day,$month,$year, $microsecond) = @_;
	return sprintf("%s.%06.0f", strftime("%Y-%m-%d %H:%M:%S", ($second,$minute,$hour,$day,$month-1,$year-1900) ), $microsecond);
}

sub createDate {
	my ($second,$minute,$hour,$day,$month,$year, $microsecond) = @_;

	return  DateTime->new(
		year      => $year,
		month     => $month,
		day       => $day,
		hour      => $hour,
		minute    => $minute,
		second    => $second,
		nanosecond => $microsecond * 1000
	);
}
