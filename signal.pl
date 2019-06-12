#!/home/oracle/perl -w

$SIG{HUP}=\&sighup;
$SIG{INT}=\&sigint;
$SIG{QUIT}=\&sigquit;
$SIG{TERM}=\&sigterm;


$exit = 0;

for $key ( sort keys %SIG ) {
	print "$key";
	print " - $SIG{$key}" if defined $SIG{$key};
	print "\n";
}

while (1) {
	sleep 1;
	print "loop...\n";
	exit if $exit;
}


sub sighup {
	print "Caught HUP...\n";
	$exit = 1;
}

sub sigquit {
	print "Caught QUIT...\n";
	$exit = 1;
}

sub sigint {
	print "Caught INT...\n";
	$exit = 1;
}

sub sigterm {
	print "Caught TERM...\n";
	$exit = 1;
}

