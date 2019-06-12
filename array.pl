#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;
$Data::Dumper::Terse=1;

# show an array

print "\n== Array \n";

my @array=('zero','one', 'two', 'three', 'four');

print 'First element of @array is $array[0]: ', $array[0], "\n";

print Dumper(\@array);

print "\n== Array Ref (reference - address of) \n";

my $arrayRef=\@array;

print 'First element of $arrayRef is $arrayRef->[0]: ', $arrayRef->[0], "\n";

print Dumper($arrayRef);

print "\n== Determine if an array is empty\n";

my @empty=();

print 'Using print @array will generate an error if the array is empty', "\n";

my (@a) = @empty;
print $a[0], "\n";

print "You could check with defined{\$a[0])\n";

my $test = defined($a[0]) ? 1 : 0;

print "test: $test\n";

print q{
But there is an easier method - force a scalar return 
Doing this will cause Perl to return the number of elements

 $test = @empty;

};

$test = @empty;
print "test: $test\n";

print q{

Now add some elements

push @empty, 'one';
push @empty, 'two';

};

push @empty, 'one';
push @empty, 'two';

$test = @empty;
print "test: $test\n";


print "\n== get the last element of the array with negative index\n";

@array=('zero','one', 'two', 'three', 'four');

print Dumper(\@array);

print "\n $array[-1] \n";


