#!/home/oracle/perl/bin/perl -w

use Config;
use strict;

my %sig_num;
my @sig_name;

unless($Config{sig_name} && $Config{sig_num}) {
	die "No sigs?";
} else {
	my @names = split ' ', $Config{sig_name};
	@sig_num{@names} = split ' ', $Config{sig_num};
	foreach (@names) {
		$sig_name[$sig_num{$_}] ||= $_;
	}   
}

use Data::Dumper;

for my $key ( sort keys %sig_num ) {
	printf("Signal Name: %-10s %i\n", $key, $sig_num{$key});
}

for my $i ( 0 .. $#sig_name ) {
	printf("Signal Number: %4i  %s\n", $i, $sig_name[$i]);
}

