#!/usr/bin/perl

# set hash and array references (refs) in a subroutine.
# this script is just a reminder to me for when I forget how to do this.

use strict;
use Data::Dumper;

my %h=();
my @a=();


sub setHash {
	my $h2 = scalar shift;
	%{$h2} = (
		'one' => 1,
		'two' => 2,
		'three' => 3,
	);
}

sub setArray {
	my $a2 = scalar shift;
	@{$a2} = (1..5);
}

setHash(\%h);

print "\nHash :\n", Dumper(\%h);


setArray(\@a);

print "\nArray :\n", Dumper(\@a);

my $history = AddHash->new( 'params' => \%h );

$history->add_params( ( 'four' => 4, 'five' => 5, 'six' => 6 ));

print "\nHashOBJ :\n", Dumper($history);

package AddHash;

use strict;
use warnings;

use Carp;
use Data::Dumper;

sub new {
    my ( $class, %arg ) = @_;

    $arg{timestamp} = time;
    $arg{date}      = gmtime;

    my $self = bless \%arg, $class;

    return $self;
}

sub add_params {
    my ( $self, %params ) = @_;

	 # a clever method to insert a hash into another hash
	 @{ $self->{params} }{ keys %params } = values %params;
}

