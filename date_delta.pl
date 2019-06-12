#!/usr/bin/perl

use Getopt::Long;
use File::Basename;
use Date::Manip;

my $basename = basename($0);

my %optctl = ();

Getopt::Long::GetOptions(
	\%optctl, 
	"start_date=s",
	"end_date=s"
);


unless ( $optctl{start_date} && $optctl{end_date}) { 
print qq{
ex. $basename -start_date '01/01/2001' -end_date 'Oct 20 2003'
};
die "Try Again\n";
}

my $date1=&ParseDate($optctl{start_date});
my $date2=&ParseDate($optctl{end_date});

# 0:0:WK:DD:HH:MM:SS   the weeks, days, hours, minutes, and seconds between the two
my $delta=&DateCalc($date1,$date2,\$err,0); 
print "Delta 1: $delta\n";

my $days = &Delta_Format($delta,0,qw{%dh});
print "Days: $days\n";

