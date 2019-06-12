#!/usr/bin/perl


# article on boost/hp calcs
# http://www.rx7club.com/showthread.php?t=478915

my $boost=14;
my $bar=14.7;

# pressure ratio
my $PR = ($bar+$boost)/$bar;
print "PR: $PR\n";

# volumetric efficiency
# article specified 90
# using 95 matches actual HP on my car (250 RWHP)
# at 6 lbs of boost
#my $VE=90;
my $VE=95;
my $RPM=7800;
my $displacement=2.6;

my $CFM = $displacement * $RPM * $VE * $PR / 5660;
my $lbPerMinute = $CFM/$bar;
print "CFM: $CFM\n";
print "LB: $lbPerMinute\n";

my $hpPerLb=7.69;

my $whp=$lbPerMinute * $hpPerLb;

print "$whp\n";


