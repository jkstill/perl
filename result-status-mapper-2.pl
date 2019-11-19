#!/usr/bin/env perl
#

# example code

use strict;
use warnings;

use IO::File;
use Data::Dumper;
use Data::TreeDumper qw(DumpTree);

my %actions = ( 
	Dumper => \&Dumper,
	DumpTree => \&DumpTree,
);


# choose dump format by uncommenting
my $dumper='Dumper';
 $dumper='DumpTree';

my $file = 'result-status-map.conf';

my $fh = IO::File->new($file,'r');

die "could not open $file - $!\n" unless $fh;

my %confData=();

my @fileData=grep(!/^\s*$|^#/,<$fh>);
chomp @fileData;

print '@fileData: ', $actions{$dumper}->(\@fileData),"\n";

map { my @a = split(/[\|,]/,$_); my $key = shift @a; $confData{$key} = \@a } @fileData;

print '%confData ', $actions{$dumper}->(\%confData),"\n";

# reverse with array elements as keys pointing to desired status name

my %transforms=();
my $el;
map {foreach $el ( 0 .. $#{$confData{$_}} ) { $transforms{$confData{$_}->[$el]} = $_ }  }  keys %confData;

print '%transforms - normalized status: ', $actions{$dumper}->(\%transforms), "\n";


