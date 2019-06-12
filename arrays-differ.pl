#!/usr/bin/env perl

sub doArraysDiffer($$);

my @a=qw[one two three];
my @b=qw[ two three one];

if ( doArraysDiffer(\@a,\@b)) {
	print "Arrays are different\n";
} else {
	print "Arrays are the same\n";
}

sub doArraysDiffer($$) {
	my ($aryRef1, $aryRef2) = @_;

	my %h1 = map { $_ => 1 } @{$aryRef1};
	my %h2 = map { $_ => 1 } @{$aryRef2};

	my $h1,$h2;

	foreach my $key ( sort keys %h1 ){ $h1 .= $key }
	foreach my $key ( sort keys %h2 ){ $h2 .= $key }

	print "\nh1: $h1\n";
	print "\nh2: $h2\n";

	if ( $h1 eq $h2 ) {
		return 0;
	} else { return 1 }

}
