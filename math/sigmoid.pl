#!/usr/bin/env perl
#
# demo the Sigmoid function
#
# for any value of x, create a number between 0 and 1, where larger number are closer to 1
#
# tags:
# zero
# one
# zero and one
# 

sub sigmoid {

	my ($input) = @_;

	# used if we do not want to activate anything less than 10 (at 0.5)
	# $input -= 10;

	#print "input: $input\n";
	return 1 / ( 1 + 2.718281828**(-$input));
}


foreach my $i ( -60 .. 60 ) {
	printf "sigmoid %6d: %6.5f\n" , $i, sigmoid($i);
}

	printf "sigmoid %6d: %6.5f\n" ,0.458 , sigmoid(0.458);

=head1 

foreach my $i ( -180 .. -35 ) {
	# not sure why I did the 10**52
	print "sigmoid $i: " , 10**52 * sigmoid($i), "\n";
	#print "sigmoid $i: " , sigmoid($i), "\n";
	#printf "sigmoid %6d: %6.5f\n" , $i, sigmoid($i);
}

=cut

