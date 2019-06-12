
package Tie::RPT::BreakDetector;

use Data::Dumper;

use strict;
use vars qw(@ISA $VERSION $debug);
$VERSION = '0.01';

{

my (%newBreakVals, %oldBreakVals)=( (), () );
my $debug = 0;
my %args=();
my %breakDetected=();

sub break {
	my($self, $key, $val) = @_;

	$newBreakVals{$key} = $val;

	$oldBreakVals{$key} = ''
		unless defined($oldBreakVals{$key});
		
	if ( $debug ) {
		print "BREAK!\n";
		print "BREAK key: $key\n";
		print "BREAK val: $val\n";
		print "NEW: $newBreakVals{$key}\n";
		print "OLD: $oldBreakVals{$key}\n";
	}

	if ( $newBreakVals{$key} eq $oldBreakVals{$key} ) {
		print "\tBREAK EQ\n" if $debug;
		$self->breakReset($key);
	} else {
		print "\tBREAK NEQ\n" if $debug;
		$self->breakSet($key);
		$oldBreakVals{$key} = $val;
	}

	# return value not being used in Break.pm
	#return $val;
}

sub breakDetected { 
	my($self, $key)=@_;
	#print "BreakDetector: ", Dumper(\%breakDetected), "\n";
	#print "BreakDetector: $key: $breakDetected{$key}\n";
	return $breakDetected{$key};
}

sub breakReset {
	my($self, $key)=@_;
	$breakDetected{$key} = 0;
}

sub breakSet {
	my($self, $key)=@_;
	$breakDetected{$key} = 1;
}

}

1;

