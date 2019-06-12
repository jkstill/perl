package Pkgtest;

# without the BEGIN this script will not work without including the 'Pkgtest:' prefixes
# Have not yet figured out why the variable does not work.

use Data::Dumper;

#sub getTestVar($);

#BEGIN {
	use Exporter qw(import);
	our $VERSION=0.1;
	our @EXPORT = qw(&getTestVar &squared $testVar);
	our @ISA=qw(Exporter);
#}


# do not export variable names
# use a hash or something and return with an index
# exporting variables may not even work (  perldoc Exporter to see that in print )

my $t='testing';

my $vars = {
	'string1' => 'this is string 1',
	string2 => 'this is string 2',
	'string3' => 'this is string 3',
	'string4' => 'this is string 4',
	'string5' => 'this is string 5',
};


sub getTestVar {
	my ($key) = @_;


	print Dumper($vars);

	#return $vars{$key};

	if ( defined($vars->{$key}) ) { return $vars->{$key}}
	else{ return 'no such value' }
}

sub squared {
	return $_[0] * $_[0];
}



1;


