#!/usr/bin/env perl


use strict;
use warnings;
use Data::Dumper;

my %columns = (
	c1 => 'D',
	c2 => 'X',
	c3 => 'B',
	c4 => 'J',
);

print '%columns ', Dumper(\%columns),"\n";

# print 

print "\ncolumn names sorted\n\n";

print join(':', sort  keys %columns),"\n";

print q{
data in column name order
Code for both methods used:

  my @a =  map{ $columns{$_}} (sort keys %columns);
  print join(':',@a),"\n";

  or

  print join(':', map{ $columns{$_}} (sort keys %columns)),"\n";

};

my @a =  map{ $columns{$_}} (sort keys %columns);
print join(':',@a),"\n";

print join(':', map{ $columns{$_}} (sort keys %columns)),"\n";

print q{

now mapped in an AoA (array of arrays)

  @a = map { [$_,$columns{$_}]}  (sort keys %columns);

};

@a = map { [$_,$columns{$_}]}  (sort keys %columns);

print Dumper(\@a),"\n";

print "Walk through the array\n";

foreach my $el ( 0 .. $#a ) {
	my ($col,$val) = @{$a[$el]};

	print "col: $col  val: $val\n";
}


