#!/home/oracle/perl/bin/perl


print "Hash references:\n\n";

$hr={};

$hr->{first_name} = 'Jared';
$hr->{last_name} = 'Still';
$hr->{occupation} = 'DBA';
$hr->{hobby} = 'humbling developers';

for $key ( keys %$hr ) {

	# either of these will work
	# -> is dereference operator
	print "$key: $hr->{$key} \n";
	#print "$key: $$hr{$key} \n";
}

$hr={};


print "\n\n";
print "Hash References to an Array Reference:\n\n";
# cannot store array directly - must store a reference

# like this
$hr->{alphabet} = ['a','b','c','d','e'];
$hr->{numbers} = [1,2,3,4,5];

# or this
@x = ('!','@','#','$','%');
$hr->{symbols} = \@x;

for $key ( sort keys %$hr ) {

	print "$key: ";

	#either of these 2 lines will work
	#for $el ( @{ $hr->{$key} } ) {
	#for $el ( @{ $$hr{$key} } ) {

	# this one also works - strange
	#for $el ( @{ @$hr{$key} } ) {

	for $el ( @{ $hr->{$key} } ) {
		print "$el ";
	}

	print "\n";

}


