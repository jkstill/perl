
package Tie::RPT;

use Data::Dumper;

use strict;
use vars qw(@ISA $VERSION $debug);
use Tie::RPT::Break;
$VERSION = '0.01';
@ISA = qw(Tie::StdHash);

use FileHandle;

$debug = 0;

my @breakCols = ();
my %computeCols = ();
my ($lineFormat, $hdrFormat, %subTotalFormats) = ('','',());
@Tie::RPT::outputArray = ();


sub new {
	my $pkg = shift;
	my $class = ref($pkg) || $pkg;

	my (%args) = @_;

	if ($debug) {
		print "REF: ", ref($args{HASHREF}), "\n";
	}

	# internalize arguments
	my $hrargs = {
		_hashref		=> $args{HASHREF},
		_sth			=> $args{STH},
		_columns		=> $args{COLUMNS},
		_break_columns		=> $args{BREAK_COLUMNS},
		_column_order		=> $args{COLUMN_ORDER},
		_compute_columns		=> $args{COMPUTE_COLUMNS},
		_pagesize	=> $args{PAGESIZE},
		_linesize	=> $args{LINESIZE},
	};

	@breakCols = @{$hrargs->{_break_columns}} 
		if defined @{$hrargs->{_break_columns}};

	# put the break column data in an easier to use form
	if (defined %{$hrargs->{_compute_columns}}) {
		foreach my $breakCol ( keys %{$hrargs->{_compute_columns}}) {
			push @{$computeCols{$hrargs->{_compute_columns}{$breakCol}}}, $breakCol;
		}	
	}

	print Dumper(\%computeCols);

	if ( defined $args{BREAK_DETECTOR} ) {
		$hrargs->{_break_detector} = $args{BREAK_DETECTOR};
	} else {
		$hrargs->{_break_detector} = 'Tie::RPT::BreakDetector';
	}

	if ( defined $args{COMPUTE_HANDLER} ) {
		$hrargs->{_compute_handler} = $args{COMPUTE_HANDLER};
	} else {
		$hrargs->{_compute_handler} = 'Tie::RPT::ComputeHandler';
	}

	formatLine($hrargs);

	# setup break detection
	tie %{$hrargs->{_hashref}}, "Tie::RPT::Break", %{$hrargs};

	bless $hrargs, $class;

}

sub breakStatus {
	my ($self, $column) = @_;
	#print "BreakStatus\n";
	#print "Column: $column\n";
	#print "Value: $self->{_hashref}{_break_detected}{$column}\n";
	#print "Dumper: ", Dumper($self->{_hashref}{_break_detected}), "\n";
	#print "Dumper: ", Dumper($self), "\n";
	$self->{_hashref}{_break_detected}{$column};
}

sub formatLine {
	my ($formats, $debug) = @_;
	$lineFormat = "format Tie::RPT::formatBody =\n";
	foreach my $col ( @{$formats->{_column_order}} ) {
		print "FORMAT:  $formats->{_columns}{$col}\n" if $debug;
		$lineFormat .= $formats->{_columns}{$col} . ' ' ;
	}
	$lineFormat .= "\n" . '@Tie::RPT::outputArray';
	$lineFormat .= "\n" . '.' . "\n";
	print "line format: $lineFormat" if $debug;
	eval $lineFormat;
}

sub output {
	my ($self, $hashData) = @_;
	@Tie::RPT::outputArray=();

	foreach my $col( @{$self->{_hashref}{_column_order}} ) {

		# need to force a FETCH for the hash element
		# for break detection
		my $val = $hashData->{$col};
		
		if ( grep(/$col/, @breakCols)) {

			if ( $self->breakStatus($col)) {
				push @Tie::RPT::outputArray, $val;
			} else {
				push @Tie::RPT::outputArray, '';
			}
		} else {
			push @Tie::RPT::outputArray, $val;
		}
	}
	#print "output Dumper: ", Dumper($self), "\n";
	#print "DATA: ", join(':',@Tie::RPT::outputArray), "\n";

	STDOUT->format_name('Tie::RPT::formatBody');
	write;

}


1;


