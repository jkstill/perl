
package debug;


# call with false (0) or the level of debuggin
# my $d = debug->new(3);

sub new {
	my $pkg = shift;
	my $class = ref($pkg) || $pkg;
	my $outputLevel = $_[0];

	my $self = { OUTPUTLEVEL => $outputLevel, CLASS => $class };
	my $retval = bless $self, $class;
	return $retval;

}


sub showself {
	my $self = shift;
	use Data::Dumper;
	print Dumper($self);
	$self->print(2,['this is showself','sdfsdf']);
}

# call with level and simple array ref, hash ref or a scalar

sub print {
	my $self = shift;
	my ($level,$data) = @_;
	use Data::Dumper;

	print "level: $level\n";
	print "Data Dump: ", Dumper($data);

	my $isRef = ref($data);

	# if blank then probably a scalar
	#if (! $refType ) { $refType = ref(\$data) }

	#printf "REFTYPE: ";
	#if ( 'SCALAR' eq $refType ) {
		#printf "SCALAR\n";
	#} elsif ( 'ARRAY' eq $refTtype ) {
		#printf "ARRAY\n";
	#} elsif ( 'HASH' eq $refType ) {
		#printf "HASH\n";
	#} else { printf "NO IDEA\n" }

	return;

}

1;

