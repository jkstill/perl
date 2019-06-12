
package RPT;

use strict;
no strict 'refs';
use warnings;

$RPT::debug = 0;

use Data::Dumper;

sub new {
	my ($pkg, $objname) = @_;
	my $class = ref($pkg) || $pkg;

	if ( $RPT::debug ) {
		print "OBJ: $objname\n";
	}

	my $objhash = { OBJECT => $objname };

	bless $objhash, $class;
	return $objhash;

}

# scalars only for now
sub break {

	my ($self, $breakvar) = @_;
	#if ( ! defined( $$breakvar) ) { $$breakvar = '' }

	print "REF: ", ref($breakvar), "\n" if $RPT::debug;

	return tie $$breakvar, 'RPT::Break', $self, $breakvar;
}


#-------------------------------------------------------------------

package RPT::Break;

use strict;
use warnings;

$RPT::Break::debug = 0;

%RPT::Break::oldval = ();
%RPT::Break::newval = ();

use Data::Dumper;
sub TIESCALAR{ 

	# this line is equiv to the following 3
	#bless \my $self, shift;
   my ($class, $args) = @_;

	if ($RPT::Break::debug) {
		print "TIESCALAR!\n";
		print "class: ", Dumper($class), "\n";
		print "args: ", Dumper($args), "\n";
	}
   bless \$args, $class;
}

sub STORE{ 

	my $self = shift;
	$RPT::Break::newval{$self} = shift;

	$RPT::Break::oldval{$self} = ''
		unless defined($RPT::Break::oldval{$self});

	if ($RPT::Break::debug) {
		print "STORE!\n";
		print "SELF 1: $self\n";
		print "SELF 2: $$self\n";
		print "NEWVAL: $RPT::Break::newval{$self}\n";
		print "OLDVAL: $RPT::Break::oldval{$self}\n";
		#print "self: ", Dumper($self), "\n";
	}

	if ( $RPT::Break::newval{$self} eq $RPT::Break::oldval{$self} ) {
		$$self = '';
	} else {
		$RPT::Break::oldval{$self} = $RPT::Break::newval{$self};
		#$oldval = $newval;
		#$$self = $newval;
		$$self = $RPT::Break::newval{$self};
	}

}

sub FETCH{ 
	my $self = shift ;
	return $$self;
}

1;


