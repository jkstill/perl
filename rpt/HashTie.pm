
##--------------------------------

package HashTie1;

use Data::Dumper;

use strict;
use vars qw(@ISA $VERSION $debug);
use Tie::Hash;
$VERSION = '0.01';
@ISA = qw(Tie::StdHash);

$debug = 1;

sub TIEHASH {
	my ($class) = @_;

	#if ($debug) {
		print "HashTie1!\n" ;
	#}

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
	print "HashTie1 Fetch\n";
	return $impl->{$key};
}

##-----------------------------------------------------

package HashTie2;

use Data::Dumper;

use strict;
use vars qw(@ISA $VERSION $debug);
use Tie::Hash;
$VERSION = '0.01';
@ISA = qw(Tie::StdHash);

$debug = 1;

sub TIEHASH {
	my ($class) = @_;

	#if ($debug) {
		print "HashTie2!\n" ;
	#}

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
	print "HashTie2 Fetch\n";
	return $impl->{$key};
}

1;

