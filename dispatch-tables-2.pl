#!/usr/bin/env perl 

use warnings;
use strict;
use Data::Dumper;
use Readonly;

use version; our $VERSION = qv('1.0.3');

Readonly my $PRINTERROR=>2;
Readonly my $PRINTWARN=>1;
Readonly my $PRINTOK=>0;

sub printerror();
sub printwarn();
sub printok();

# the dispatch table
my %t = (
	 $PRINTERROR => \&printerror,
	 $PRINTWARN => \&printwarn,
	 $PRINTOK => \&printok,
);

my @messages=qw[ four five six ];

$t{$PRINTOK}(
	[
		'this is line 1',
		'this is line 2',
		'this is line 3',
		@messages
	]
);


Readonly my $HDRLEN => 80;
print q{=} x $HDRLEN, qq{\n};

print "Printing with Dumper\n";

$t{$PRINTWARN}(
	[
		'this is line 1',
		'this is line 2',
		'this is line 3',
		Dumper(\@messages)
	]
);

print q{=} x $HDRLEN, qq{\n};

print "calling PRINTWARN\n";

$t{$PRINTWARN}(['This is your final warning']);

print Dumper(\%t);

# end of main

sub printerror() {
	my $d = shift;
	$Data::Dumper::Varname = 'Error-Msg-';
	print "This is an error\n";
	if ($d) {
		print join("\n", @{$d}), "\n";
	};
	print "$PRINTERROR\n";
	return;
}

sub printwarn() {
	my $d = shift;
	$Data::Dumper::Varname = 'Warning-Msg-';
	print "This is a warning\n";
	if ($d) {
		print join("\n", @{$d}), "\n";
	}
	print "$PRINTWARN\n";
	return;
}

sub printok() {
	my $d = shift;
	#$Data::Dumper::Terse = 1;
	$Data::Dumper::Varname = 'OK-Msg-';
	print "This is OK\n";
	if ($d) {
		print join("\n", @{$d}), "\n";
	}
	print "$PRINTOK\n";
	return;
}
