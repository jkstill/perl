
package Tie::RPT::Break;

use Data::Dumper;
use Carp;

use strict;
use vars qw(@ISA $VERSION $debug);
use Tie::Hash;
$VERSION = '0.01';
@ISA = qw(Tie::StdHash);

#{

my $debug = 0;
my %args=();
my $breakRoutine='break';
my $breakDetector='';
my $computeHandler='';
my @breakCols;
my @computeBreakCols;
my @computeCols;
my %computableColRef;

sub TIEHASH {
	my $class = shift;
	%args = @_;

	@breakCols = @{$args{_break_columns}};
	foreach my $key ( keys %{$args{_compute_columns}}) { push @computeBreakCols, $key }


=head1 Reverse lookup for computable columns

build a hash with the computable columns as keys, and the
hash value an array reference to the computeBreakColumns
used for the computeHandler to know which columns to keep
totals for

e.g.

 {
   MONTH => SALES,
   QUARTER => SALES,
   MONTH => COMMISSIONS,
   QUARTER => COMMISSIONS,
 }

 becomes

 {
   COMMISSIONS => ['MONTH','QUARTER'],
   SALES => ['MONTH','QUARTER'],
 } 

=cut

	#reverse lookup for computable columns
	foreach my $key ( keys %{$args{_compute_columns}}) { 
		push @{$computableColRef{$args{_compute_columns}{$key}}}, $key;
	}

	# array of computable columns
	foreach my $key ( keys %computableColRef ) { push @computeCols, $key};

	if ($debug) {
		print "TIEHASH!\n" ;
		print "Breaks: ", Dumper(\@breakCols), "\n";
		print "Computes: ", Dumper(\@computeBreakCols), "\n";
		print "computableColRef: ", Dumper(\%computableColRef), "\n";
		print "args: ", Dumper(\%args), "\n";
	}

	$breakDetector = $args{_break_detector};
	$computeHandler = $args{_compute_handler};


	eval qq{use $breakDetector};
	if ($@) { die "Unable to load Break Detector: $breakDetector\n" }
	eval qq{use $computeHandler};
	if ($@) { die "Unable to load Compute Handler: $computeHandler\n" }

	# print "TIEHASH! ", Dumper(\%oldBreakVals), "\n";
	#bless {},  $class;
	bless \%args, $class;
}

sub STORE {
	my($hash, $key, $newval) = @_;
	if ($debug) {
		print "STORE!\n" if $debug;
		print "STORE REF:", ref($hash), "\n";
	}

	# assuming for the moment that only compute operation is summing
	if ( grep(/$key/, @computeCols)) {
		$computeHandler->add($computableColRef{$key}, $key, $hash->{$key} );
	}

	$hash->{$key} = $newval;
}

sub FETCH {
	my($hash, $key) = @_;

	my $val = $hash->{$key};

	if ( $debug ) {
		print "FETCH!\n";
		print "FETCH key: $key\n";
		print "FETCH keys: ", join(':',@breakCols), "\n";
	}

	if ( grep(/$key/, @breakCols)) {
		#$breakDetector->$breakRoutine($key, $hash->{$key});
		$breakDetector->$breakRoutine($key, $val);
		if ($breakDetector->breakDetected($key) ) { 
			print "\tBreak Detected\n" if $debug;
			setBreakDetected($key, 1);
		} else {
			setBreakDetected($key, 0);
			#$val = '';
		}

	}
	$val;
}

=head1  I don't think this is used

sub breakDetected {
	my($key) = @_;
	$args{_break_detected}{$key};
}

=cut


sub setBreakDetected {
	my($key, $breakBoolean) = @_;
	$args{_break_detected}{$key} = $breakBoolean;
	#print "BreakBoolean: $breakBoolean\n";

	if ( $debug ) {
		foreach my $key ( sort keys %args) {
			# don't process the _hashref key here, as 
			# it will never complete the loop in debug mode
			next if $key eq '_hashref';

			my $refType = ref $args{$key};
			print "Ref Type: $refType\n";
			if ( $refType eq 'HASH' ) {
				print "HASH Key: $key\n";
				foreach my $rkey ( keys %{$args{$key}} ) {
					print "\trkey: $rkey - $args{$key}->{$rkey} \n";
				}
			} elsif($refType eq 'ARRAY' ) {
				print "\tr_element: ", join(':', @{$args{$key}}), "\n";
			} else {
				print "Key: $key  - $args{$key} \n";
			}
		}
	}
}


#}

1;

