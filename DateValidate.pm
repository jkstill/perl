

package DateValidate;

use Carp;

#example usage

# requires date in dd/mm/yyyy format 
#
#$date=$ARGV[0];
#
#eval { $date = DateValidate::IsDateValid(\$date) };
#
#print "$date - ";
#if ( $@ ) { print "Date is invalid\n" }
#else { print "Date is valid\n" }


sub IsDateValid {
	my( $dateref ) = shift;
	my($month, $day, $year) = split(/\//, $$dateref);

	# pad with zeroes
	$month = substr( 'x00' . $month,-2);
	$day = substr( 'x00' . $day,-2);

	if ( $year > 9999 ) { croak "$year is an invalid year\n" }
	if ( $month < 1 or $month > 12 ) { croak "$month is an invalid month\n" }

	my %MonthMaxDays = (
		'01' => 31,
		'02' => GetLeapDays($year),
		'03' => 31,
		'04' => 30,
		'05' => 31,
		'06' => 30,
		'07' => 31,
		'08' => 31,
		'09' => 30,
		'10' => 31,
		'11' => 30,
		'12' => 31
	);


	if ( $day < 1 or $day > $MonthMaxDays{$month} ) { croak "$day is an invalid day\n" }

	$$dateref = $month . '/' . $day . '/' . $year ;

}

sub GetLeapDays {
	my $year = shift;

	# From Kernighan and Ritchie
	my $LeapYear = ($year % 4 == 0 && !($year % 100 == 0 && !($year % 400 == 0)));

	if ( $LeapYear ) { return 29 }
	else { return 28 }
}

1;

