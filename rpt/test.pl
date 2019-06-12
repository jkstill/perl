#!/usr/bin/perl


use Data::Dumper;

my $t1 = new TEST;
my $t2 = new TEST;

#print "t1: " , Dumper(\$t1), "\n";
#print "t2: " , Dumper(\$t2), "\n";

my $x=1;
my $y=1;

print "X: $x\n";
print "Y: $y\n";

$t1->add(\$x);
$t1->add(\$x);

$t2->add(\$y);
$t2->add(\$y);
$t2->add(\$y);

print "X: $x\n";
print "Y: $y\n";

#--------------------------

package TEST;

use strict;
no strict 'refs';
use warnings;

sub new {
	my ($pkg, $objname) = @_;
	my $class = ref($pkg) || $pkg;

	bless \$pkg, $class;
	return $pkg;

}

# scalars only for now
{

my $num = 0;

sub add {

	my ($self, $value ) = @_;

	$num = $$value+1;

	print "NUM: $num\n";

	$$value = $num;

	# return value not used
	#return $num;
	
}

}


