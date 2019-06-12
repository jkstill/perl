
my $delimiter = '@';

# all search strings to be replaced by replace string
my $searchString = 'C:\\\ORAWIN95';
my $replaceString = 'D:\\ORAWIN95';

use Win32::TieRegistry( ArrayValues=>0 );

$Registry->Delimiter($delimiter);

# setup to work on Oracle keys/values
my $root = "LMachine${delimiter}SOFTWARE${delimiter}ORACLE";

recurseKey($root,$delimiter, $searchString, $replaceString);
#recurseKey($root,$delimiter );

sub recurseKey {

	my ( $rootKey ) = shift || die "recurseKey needs a rootKey\n";;
	my ( $delimiter ) = shift || die "recurseKey needs a delimiter\n";
	my ( $searchString ) = shift || die "recurseKey needs a searchString\n";
	my ( $replaceString ) = shift || die "recurseKey needs a replaceString\n";


	my $diskKey= $Registry->{$rootKey}
		or  die "Can't read $rootKey : $^E\n";  

	foreach $entry (  keys(%$diskKey)  ) {

		# if a value print it, if a key recurse
		# keys end with a delimiter
		# values begin with a delimiter

		# a value
		if ( $entry =~ /^${delimiter}/ ) { 

				#print "KEY: $rootKey  VALUE: $entry\n" ;
				my $text = $diskKey->{$entry};
				next unless $text =~ /^$searchString/i;
				printf "%-30s = %-40s\n" ,$entry,$text;

				my $newText = $text;
				$newText =~ s/^$searchString/$replaceString/i;
				printf "%-30s = %-40s\n\n" ,'',$newText;

				# uncomment this line to make the change
				#$diskKey->{$entry} = $newText;


		} else {  # a key
			my $newKey = $rootKey . $delimiter . $entry;
			$_ = $newKey;
			eval "tr/$delimiter/$delimiter/s";
			$newKey = $_;
			#print "newkey: $newKey\n";
			recurseKey ($newKey, $delimiter, $searchString, $replaceString ) 
		}
	}
}
