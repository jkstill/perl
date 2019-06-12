#!/usr/bin/env perl


=head1 devel-confess.pl

A demo of the Devel::Confess module.

This script is designed to be called from a shell script.

The purpose is do show how a stack trace can be generated without modifying the program.

See devel-confess.sh

=cut

use strict;
use warnings;

main();

sub main {

	my $x = sub1(10);

}


sub sub1 {
	my $arg = shift;
	my $x = sub2($arg);
	return $x
}


sub sub2 {
	my $arg = shift;
	warn "This is a warning!\n";
	my $x = sub3($arg);
	return $x
}

sub sub3 {
	my $arg = shift;
	warn "Die!\n";
	return $arg;
}



