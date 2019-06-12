#!/usr/bin/env perl

# force several Perl::Critic violations
#

use warnings;
use strict;
use Readonly;
use Data::Dumper;
$Data::Dumper::terse = 1;
$Data::Dumper::terse = 1;

use version; our $VERSION = qv('1.0.3');

use vars %t;

# as per perl critic severity 2
# 9 is not one of the allowed literal values (0, 1, 2). 
# Use the Readonly or Const::Fast module or the "constant" pragma instead at line 12, column 13.  
# Unnamed numeric literals make code less maintainable
# enfofr
my @a=(0 .. 9);

# better performed with constant or Readonly
# Perl::Critic says use constant or Readonly
# PBP say do not use contant - go figure
Readonly my $minB => 0;
Readonly my $maxB => 9;
my @b=($minB .. $maxB);
 
print Dumper(\@a);

# Negative array index should be used at line 12, column 11. See page 88 of PBP.
my $b = $a[$#a];

# Subroutine prototypes used at line 15, column 1. See page 194 of PBP.
sub mysub($$);
sub mysub($$) {
	# Reused variable name in lexical scope: $b at line 18, column 2. Invent unique variable names.
	# see https://metacpan.org/pod/Perl::Critic::Policy::Variables::ProhibitReusedNames
	my ($a,$b) = @_;
	return $a * $b;
}

# better written in this manner with unique variable names
sub mysub2();
sub mysub2() {
	my ($oper1,$oper2) = @_;
	return $oper1 * $oper2;
}



