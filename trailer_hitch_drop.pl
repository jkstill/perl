#!/home/oracle/perl/bin/perl

# total trailer length of 21 feet
# from hitch to midway point between axles is 14 feet
# calculate how much a drop of N inches in the front
# will raise the back of the trailer

$N=6;

# in inches

$pi = 3.14159;
$f = ( 14 * 12);
$b = ( 7  * 12);
print "f: $f\n";
print "b: $b\n";
print "fd: " . $f * $pi * 2 . "\n";
print "bd: " . $b * $pi * 2 . "\n";

# degrees per inch
$fdpi = 360 / ( $f * $pi * 2);
$bdpi = 360 / ( $b * $pi * 2);

print "fdpi: $fdpi\n";
print "bdpi: $bdpi\n";

# a N inch drop in front will result
# in a drop of N inches at the back
# degrees of drop
$fd = $fdpi * $N ;

print "fd: $fd\n";

# inches of drop at back
# degrees 
$bi = $fd / $bdpi;

print "bi: $bi\n";

