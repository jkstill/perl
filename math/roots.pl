#!/usr/bin/env perl
#

# return the Nth root of any number
#

# value, root
sub root {
	my ($v,$r) = @_;

	return $v ** (1/$r);
}


my %roots = (
	4 => ['square',2],
	27 => ['cube',3],
	2 => ['12th',12],
);

foreach my $val ( sort { $a <=> $b } keys %roots ) {

	my ($n,$r) = @{$roots{$val}};

	print "$n root of $val: ", root($val,$r), "\n";

}


