#!/usr/bin/perl

$|++;

$action='continueProgram';

sub zf{
	print "This is z\n";
	sleep(5);
	print "zf-Action: $action\n";
	exit 1;
}

sub yf{
	print "This is y\n";
	zf();
}

sub xf{
	print "This is x\n";
	yf();
}

{
	$SIG{ALRM}=\&sigAlarm;
	alarm(3);
	print "running..."; 
	xf();
	&$action;
	print "Exiting normally\n";

}


sub sigAlarm {
	print "Checking Alarm\n";
	$action = 'exitProgram';
	return 0;
}

sub exitProgram {
	print "\nexiting via exitProgram\n";
	exit 0;
}

sub continueProgram { print "\ncontinuing via continueProgram\n" }
