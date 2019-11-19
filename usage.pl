

sub usage {

	my $exitVal = shift;
	use File::Basename;
	my $basename = basename($0);
	print qq{
$basename

usage: $basename - <SCRIPT DESCRIPTION>

   $basename -option1 parameter1 -option2 parameter2 ...

-option1         parameter1
-option2         parameter2
..

examples here:

   $basename -option1 parameter1 -option2 parameter2 ...
};

	exit eval { defined($exitVal) ? $exitVal : 0 };
}

