

use Data::Dumper;

my @a;

foreach my $n ( 1..5 ) {
	push @a,$n;
}

print Dumper(\@a);
