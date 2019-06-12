
=head1 NAME

GetKey.pm - front end to Term::ReadKey

=head1 USAGE

the two functions currently implemented are getYN and quitOrContinue

used to get one key reponses from the user.

the use of Term::ReadKey prevents the user from using <CTRL-C>

An example of both follows.

if ( GetKey::getYN() ) {

	print "you said YES\n";

} else {

	print "you said NO\n";

}

if ( GetKey::quitOrContinue() ) {

	print "you said to CONTINUE\n";

} else {

	print "you said QUIT\n";

}

you may optionally provide an argument to replace the default prompt

if ( GetKey::quitOrContinue('Ya wanna finish or not? Q/C') ) {

	print "you said to CONTINUE\n";

} else {

	print "you said QUIT\n";

}

you may optionally provide an argument to replace the default prompt

rolling your own is another option.  the 2 functions above call
GetKey::getKey. The 2 args to this function are a prompt and
a ref to an array of possible one letter responses.

for example:

my $key =  GetKey::getKey('this is a test',['A','B','C','D','E']);

this example will allow only A-E as valid input.

Note:  all keys are forced to upper case in getKey.


Jared Still - BCBSO

=cut

package GetKey;

use strict;
use Carp;

# if element 0 of the array passed by reference
# is 'PRESS ANY KEY', pressing any key will return

sub getKey {

	if ( scalar @_ != 2 ) { Carp::croak "Wrong number of args\n" }
	my($prompt,$keySetAryRef) = @_;

	if ( ref($keySetAryRef) ne 'ARRAY' ) {
		Carp::croak "getKey keyset arg should be array ref\n";	
	}

	local( $| = 1);

	use Term::ReadKey;

	ReadMode 4;
	my $keyPress = "dummy";
	my $in = *STDIN;
	while(! ( grep( /$keyPress/, @$keySetAryRef ) ))
	{
		print "\n$prompt ", join('/', @$keySetAryRef), " : ";
		my $count=0;
		$count++ while !defined($keyPress=ReadKey(-1, $in));
		$keyPress = uc($keyPress);
		last if ( $keySetAryRef->[0] eq 'PRESS ANY KEY' ); 
	}
	ReadMode 1;
	print "\n";
	$keyPress;
}

sub getYN {
	my ($prompt) = shift;
	$prompt = 'Enter "Y" or "N"' unless $prompt;
	my $ret = GetKey::getKey($prompt,['Y','N'] );
	if ( $ret eq 'Y' ) { return 1 }
	else { return 0 }
}

sub quitOrContinue {
	my ($prompt) = shift;
	$prompt = 'Enter "Q" to quit or "C" to continue' unless $prompt;
	my $ret = GetKey::getKey($prompt,['Q','C'] );
	if ( $ret eq 'C' ) { return 1 }
	else { return 0 }
}

1;


