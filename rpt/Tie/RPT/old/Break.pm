
package Tie::RPT::Break;

use Data::Dumper;

use strict;
use vars qw(@ISA $VERSION $debug);
use Tie::Hash;
$VERSION = '0.01';
@ISA = qw(Tie::StdHash);

#$debug = 0;
#use vars(qw{%newBreakVals %oldBreakVals @breakCols});
#(%newBreakVals, %oldBreakVals, @breakCols)=( (), (), () );

{

my (%newBreakVals, %oldBreakVals, @breakCols)=( (), (), () );
my $debug = 0;
my %args=();

sub TIEHASH {
	#my ($class,@breaks) = @_;
	my $class = shift;
	%args = @_;

	@breakCols = @{$args{_breaks}};

	if ($debug) {
		print "TIEHASH!\n" ;
		print "Breaks: ", Dumper(\@breakCols), "\n";
		print "args: ", Dumper(\%args), "\n";
	}


	# print "TIEHASH! ", Dumper(\%oldBreakVals), "\n";
	bless {},  $class;
}

sub STORE {
	my($impl, $key, $newval) = @_;
	if ($debug) {
		print "STORE!\n" if $debug;
		print "STORE REF:", ref($impl), "\n";
	}
	$impl->{$key} = $newval;
}

sub FETCH {
	my($impl, $key) = @_;

	$newBreakVals{$key} = $impl->{$key};

	$oldBreakVals{$key} = ''
		unless defined($oldBreakVals{$key});
		

	if ( $debug ) {
		print "FETCH!\n";
		print "FETCH key: $key\n";
		print "FETCH keys: ", join(':',@breakCols), "\n";
		print "NEW: $newBreakVals{$key}\n";
		print "OLD: $oldBreakVals{$key}\n";
	}

	if ( grep(/$key/, @breakCols)) {
		if ( $newBreakVals{$key} eq $oldBreakVals{$key} ) {
			print "\tFETCH EQ\n" if $debug;
			$impl->{$key}='';
		} else {
			print "\tFETCH NEQ\n" if $debug;
			$oldBreakVals{$key} = $impl->{$key};
			#return $impl->{$key};
		}
	}
	return $impl->{$key};
}


}

1;

