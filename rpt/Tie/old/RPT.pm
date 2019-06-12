
package Tie::RPT;

use Data::Dumper;

use strict;
use vars qw(@ISA $VERSION $debug);
use Tie::RPT::Break;
$VERSION = '0.01';
@ISA = qw(Tie::StdHash);

$debug = 0;

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
		_breaks		=> $args{BREAKS},
		_pagesize	=> $args{PAGESIZE},
		_linesize	=> $args{LINESIZE},
	};

	# setup break detection
	#tie %{$hrargs->{_hashref}}, "Tie::RPT::Break", @{$hrargs->{_breaks}};
	tie %{$hrargs->{_hashref}}, "Tie::RPT::Break", %{$hrargs};

	bless $hrargs, $class;

}


#-----------------------------



1;


