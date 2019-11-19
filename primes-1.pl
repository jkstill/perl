#!/usr/bin/perl

# http://www.perlmonks.org/?node_id=276103

# prints all prime numbers up to the value of the command line argumen +t, or 500 if no args;

use strict;
use warnings;

use POSIX; # for ceil()

my @primes = ( 1, 2 ); #  prime the list of primes :-)    

my $max = shift || 500; 
# initialise $max if no command line argument 

my $enough = ceil ( $max ** 0.5 );
# we only need to filter until we have >= the sqrt

sub sieve {

# create a new closure to act as a part of the sieve
# the number that this closure will filter out multiples of

    my $divisor = shift;
    my $sieve_ref;

    return sub {

        my $number = shift;

# Does $number divide by divisor? 
# If so, it's not prime, so bail out;
        return unless $number % $divisor;

# if we have already created a next sieve, 
# then let it deal with the number
# pass $number to it, and return;

         if ( $sieve_ref ){
             &$sieve_ref( $number );
             return
         }; 

#if we get this far, we have a new prime

# if we need to make a new sieve to filter,do so
        $sieve_ref = sieve( $number ) if $number < $enough;

# push the prime onto the array
        push @primes, $number;
    };
};

# the main program

my $sieve = sieve( 2 ); # initialise 
&$sieve( $_ ) for 3 .. $max; 

print "The primes less than or equal to $max are @primes\n";
