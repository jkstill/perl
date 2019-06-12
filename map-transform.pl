#!/usr/bin/eval perl

use strict;
use warnings;
use Data::Dumper;

my %h = (
	flintstone => [ qw( fred wilma pebbles dino ) ],
	rubble => [ qw( barney betty bambam )],
	test => [ qw( barney betty bambam )],
);

print '%h: ' , Dumper (\%h), "\n";

#foreach my $key ( keys %h ) { print "key: $key\n" }
#print "keys: ", join(' - ', keys %h ), "\n";

my $el;
my %t;

map {foreach $el ( 0 .. $#{$h{$_}} ) { $t{$h{$_}->[$el]} = $_ }  }  keys %h;

print '%t: ' , Dumper (\%t), "\n";

