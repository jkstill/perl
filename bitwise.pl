#!/usr/bin/env perl
#

my (
	$bit0Test,
	$bit1Test,
	$bit2Test,
	$bit3Test,
) = (
	1,
	2, 
	4, 
	8, 

);

my $flag = 10; # 1010 binary

print $flag & $bit0Test, "\n";
print $flag & $bit1Test, "\n";
print $flag & $bit2Test, "\n";
print $flag & $bit3Test, "\n";


