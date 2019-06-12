#!/home/oracle/perl/bin/perl -w


use strict;

sub gen_fib {
	my($curr, $next) = (0,1);
	return sub {
		my $fib = $curr;
		($curr, $next) = ($next, $curr + $next);
		return $fib;
	};
}

my $fib_stream1 = gen_fib();
my $fib_stream2 = gen_fib();

# print first 5 fibonacci numbers from stream 1
print "Stream One:";
for(1..5){
	print $fib_stream1->(), ' ';
}
print "\n";

# print first 10 from stream 2
print "Stream Two:";
for (1..10) {
	print $fib_stream2->(), ' ';
}
print "\n";

# print next 5 from stream 1
print "Stream One:";
for(1..5){
	print $fib_stream1->(), ' ';
}
print "\n";

