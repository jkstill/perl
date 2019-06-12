#!/usr/bin/perl

use Time::HiRes qw(sleep);

my $file=shift;
die "please specify file name\n" unless defined($file);
die "cannot open $file\n" unless -r $file;
open FILE, "<$file" || die "unable to open file : $!\n\t$file\n";

# seek to end of file
seek(FILE, 0, 2);

my $curpos;
for(;;) {
	for ( $curpos = tell(FILE); $_ = <FILE>; $curpos = tell(FILE)) { print }
	sleep(.25);
	# advance curpos bytes
	seek(FILE, $curpos, 0); 
}



