#!/usr/bin/env perl
#

print qq{

Use exponents to do roots

For instance:

3*3*3*3*3 = 243

If given the value 243, calculate the 5th root:

243 ** (1/5) = 3

Now calculated in this script

};


my $v=243;
my $root5 = $v ** (1/5);

print "\n5th root of 243 is $root5\n\n";

print "now do 5*5*5*5*5*5*5*5*5*5 (10)\n";

$v=5*5*5*5*5*5*5*5*5*5;

print qq{
value: $v

now get the 10th root with \$v ** (1/10)

};

my $root10 = $v ** (1/10);

print "\n10th root of $v is $root10\n\n";



