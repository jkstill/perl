#!/usr/bin/perl -w

use Data::Dumper;

# inline subroutines

=head1 dispatch tables - inline subs
=cut

#my %var_actions = (
#ok => sub{print "OK\n"; exit 0},
#warn => sub{print "Warning\n"; exit 1},
#error => sub{print "Error\n"; exit 2},
#);

#$var_actions{ok}();
#$var_actions{warn}();
#$var_actions{error}();



# subroutine refs

#=head1 dispatch tables - sub refs

%ref_actions = (
	ok => \&ok,
	warn => \&warn,
	error => \&error
);

#$ref_actions{ok}();
#$ref_actions{warn}();
$ref_actions{error}();

sub ok {print "OK\n"; exit 0};
sub warn {print "Warning\n"; exit 1};
sub error{print "Error\n"; exit 2};

#=cut

