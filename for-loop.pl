

for ( my $i=0; $i < 10; $i++ ) {
	next if $i == 4;
	print "i: $i\n";
}


@a=qw(a b c d e f g h);

for ( my $i = 0; $i <= $#a; $i++ ) {
	next if $a[$i] eq 'd';
	print "i: $i  a: $a[$i]\n"
}
