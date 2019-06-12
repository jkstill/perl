
package Tie::RPT::ComputeHandler;

use Data::Dumper;

use strict;
use vars qw($VERSION $debug);
$VERSION = '0.01';

{

my (%subTotals, %runningTotals)=( (), () );
my $debug = 0;
my %args=();

sub add {
	my($self, $colArray , $key, $val) = @_;

	if ( $debug ) {
		print "COLS: ", join(":", @{$colArray}), "\n";
		print "KEY: $key\n";
		print "VAL: $val\n";
	}

	foreach my $col( @{$colArray}) {
		$subTotals{$col}{$key} += $val;
		$runningTotals{$col}{$key} += $val;
	}

	if ( $debug ) {
		print "add!\n";
		print "Sub Totals: ", Dumper(\%subTotals), "\n";
		print "Run Totals: ", Dumper(\%runningTotals), "\n";
	}

}

# clear a subtotal for a computable column for a break column
sub clearSub {
	my($self, $breakCol, $computeCol ) = @_;
	$subTotals{$breakCol}{$computeCol} = 0;
}

}

1;

