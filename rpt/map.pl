#!/usr/bin/perl

use Data::Dumper;

my %data;
my $data = {};

my @ary = qw{SCOTT EMP LAST_NAME};
#  = qw{OWNER TABLE_NAME COLUMN_NAME};

my @columns = qw{OWNER TABLE_NAME COLUMN_NAME};

# initialize
%data = map{ $_, undef } @columns;
print Dumper(\%data);

# data
%data = map{ $_, shift @ary } @columns;
print Dumper(\%data);


