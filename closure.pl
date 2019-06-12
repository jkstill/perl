#!/usr/bin/env perl
#

mysub();
mysub();
mysub();
mysub();


{

	my $i=0;

sub mysub {
	print "testing: ", $i++, "\n";
}

}
