#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;

my $search=defined $ARGV[0] ? $ARGV[0] : 'dog';

my @a=qw[the quick brown fox jumped over the lazy dog];

print '@a: ', Dumper(\@a);

my ($r)=grep /lazy/, @a;

print '$r: ',"$r\n";

print "\n";

my ($r2) = grep /$search/, @a;

# $r2 is undefined if not found - an error will appear is search term not found

if ($r2) { print "search found: $r2\n" }
else { 
	print "$search not found\n";
}

print "\n";

print "Now use a scalar check - returns number of times search was matched\n";
print "This avoids the possibility of \$r2 being undef if you just need to know success/failure\n";

$r2 = grep /$search/, @a;

print "\n";
if ($r2) { print "search found $r2 times\n" }
else { 
	print "$search not found - matches was $r2\n";
}

print "\n";

print "Now use a scalar check - no values found - result should be 0\n";
print "This avoids the possibility of \$r2 being undef if you just need to know success/failure\n";

$r2 = grep /willnotbefound/, @a;

print "\n";
if ($r2) { print "willnotbefound found $r2 times\n" }
else { 
	print "willnotbefound not found - matches was $r2\n";
}

print "\n";

# now grep for a partial word
print "\nnow grep for partial word of 'azy'\n";
($r)=grep /azy/, @a;
print '$r: ',"$r\n";
print "\n";

# grep for exact match
print "\nnow grep for exact match of '^azy\$ - should not be found'\n";
($r)=grep /^azy$/, @a;
$r = defined($r) ? $r : '';
print '$r: ',"$r\n";
print "\n";

# grep for exact match
print "\nnow grep for exact match of '^lazy\$ - should be found'\n";
($r)=grep /^lazy$/, @a;
print '$r: ',"$r\n";
print "\n";

