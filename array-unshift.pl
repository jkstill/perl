
use Data::Dumper;

my @a=qw{ c d e};

print Dumper(\@a);

unshift @a,'a','b';

print Dumper(\@a);

