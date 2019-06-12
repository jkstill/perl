

use Data::Dumper;

# get max length of hash key

my %h = (
	'hashkey' => 1,
	'testing-key' => 2,
	'the-longest-key' => 3,
	'short' => 4
);


my @l = map { length($_) } keys %h;
my $x = (sort { $b <=> $a } @l)[0];

print "Longest: $x\n";


