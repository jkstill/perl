#currtime.pl - return a string formatted for current local time

print CurrTime(), "\n";

sub CurrTime {

	local( $sec, $min, $hour, $Time );

	($sec, $min, $hour) = localtime();
	$Time = $Time .   substr("0" . $hour, length("0" . $hour) - 2, 2) . ":";
	$Time = $Time . substr("0" . $min, length("0" . $min) - 2, 2) . ":";
	$Time = $Time . substr("0" . $sec, length("0" . $sec) - 2, 2) ;

	return($Time);
}
1;

