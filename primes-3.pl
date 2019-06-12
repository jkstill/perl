#!/usr/bin/env perl

# http://www.perlmonks.org/?node_id=156601

use strict;

sub primes {
    my @n = (2..shift);
    my @p;
    while (@n && (push @p, shift @n)) {
        @n = grep { $_ % $p[-1] } @n;
    }
    return @p
}

# find all primes through 100
print join "\n",primes(100000);
