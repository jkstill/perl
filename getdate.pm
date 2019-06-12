

package getdate;

local ($rdate,$sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst);

sub GetTime {
	($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime(time);

	$year += 1900;
	
	$rtime = substr('00' . $hour, length($hour),2 );
	$rtime = $rtime . ':' .  substr('00' . $min, length($min),2 );
 	$rtime = $rtime . ':' . substr('00' . $sec, length($sec),2 );

 	return($rtime);

}

sub GetDate {
	($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime(time);

	$year += 1900;
	
	$rdate =  substr('00' . ($mon+1), length($mon+1),2 );
	$rdate = $rdate . '/' .  substr('00' . $mday, length($mday),2 );
	$rdate = $rdate . '/' . $year;

	return($rdate);
}


sub GetTimeRaw {
	($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime(time);

	$year += 1900;
	
	$rtime = substr('00' . $hour, length($hour),2 );
	$rtime = $rtime . substr('00' . $min, length($min),2 );
 	$rtime = $rtime . substr('00' . $sec, length($sec),2 );

 	return($rtime);

}

sub GetDateRaw {
	($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime(time);

	$year += 1900;
	
	$rdate =  $year . substr('00' . ($mon+1), length($mon+1),2 );
	$rdate = $rdate .  substr('00' . $mday, length($mday),2 );

	return($rdate);
}

1;

