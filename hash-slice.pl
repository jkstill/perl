#!/usr/bin/env perl

use Data::Dumper;

=head1 Hash Slice from Function

 Just a quick hack to show how to get an array slice from
 a function that returns an array.

 I can never remember the correct syntax.

=cut 


sub gethashref {

	return {
		zero	=> 0,
		one	=> 1,
		two	=> 2,
		three	=> 3,
		four	=> 4,
		five	=> 5,
		six	=> 6,
		seven	=> 7,
		eight	=> 8,
		nine	=> 9
	};

}

sub gethash {

	return (
		zero	=> 0,
		one	=> 1,
		two	=> 2,
		three	=> 3,
		four	=> 4,
		five	=> 5,
		six	=> 6,
		seven	=> 7,
		eight	=> 8,
		nine	=> 9
	);

}

my %a=gethash;

print "\n### Hash\n";
print Dumper(\%a);
my $v = {gethash}->{'two'};
print "2: $v\n";

print "\n### Hash Ref\n";
my $a = gethashref;
print Dumper($a);
$v = (gethashref)->{'two'};
print "2: $v\n";






