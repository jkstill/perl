#!/usr/local/bin/perl -w

use Date::Manip;

my $date = '3-Oct-03 19:41:23';

my $rawdate = ParseDate($date);

my $wdate = UnixDate($rawdate,'%Y-%m-%d %H:%M:%S');

print "wdate: $wdate\n";

my $mtime = (stat "$ENV{HOME}/perl/date_manip.pl")[9]; 

my($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($mtime);

$rawdate = ParseDate($date);

$wdate = UnixDate($rawdate,'%Y-%m-%d');

print "wdate: $wdate\n";

$epoch = UnixDate( ParseDate($date), "%s" );
print "epoch: $epoch\n";




