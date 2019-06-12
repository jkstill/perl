#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;

# given 2 arrays, determine if there are any elements in common
#

sub arrayCommon($$);
sub arrayMinus($$);

my @a = qw[ one three five];
my @b = qw[ two three four six];

my @disabledNotRunning = @{arrayCommon(\@a,\@b)};

print "disabledNotRunning: ", Dumper(\@disabledNotRunning);

my @notRunningEnabled = @{arrayMinus(\@a,\@b)};

print "notRunningEnabled:	", Dumper(\@notRunningEnabled);

sub arrayCommon($$) {
	my ($aryRef1, $aryRef2) = @_;

	my %h1;
	map { $h1{$_}++ } ( @{$aryRef1}, @{$aryRef2} );

	my $results=[];

	foreach my $key ( keys %h1 ) { push @{$results},$key if $h1{$key} > 1 }

	#print "arrayCommon()\n";
	#print '$aryRef1 ' , Dumper($aryRef1);
	#print '$aryRef2 ' , Dumper($aryRef2);
	#print '@t ' , Dumper(\@t);
	#print '%h1 ' , Dumper(\%h1);
	#print '@results: ' , Dumper(\@results);
	#
	return $results;
}

# return a list composed of the elements that are
# found in array 1, but not found in array 2
sub arrayMinus($$) {
	my ($aryRef1, $aryRef2) = @_;

	my (%h1,%h2);
	map { $h1{$_}++ } @{$aryRef1};
	map { $h2{$_}++ } @{$aryRef2};

	my $results=[];

	foreach my $key ( keys %h1 ) {
		 push @{$results},$key unless exists($h2{$key});
	}

	print "arrayMinus()\n";
	print '%h1 ' , Dumper(\%h1);
	print '%h2 ' , Dumper(\%h2);
	print '@results: ' , Dumper($results);
	return $results;
}

