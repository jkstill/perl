

-- transform contents of array in oneliner

my @a=();

push @a, "1,2,3,4,5";
push @a, "this is a test";
push @a, 'this is also, a test';

print join("\n", @a),"\n";

print "\n";

# oneliner - replace all commas with a space
$_ =~ s/,/ /g for @a;

print join("\n", @a),"\n";

