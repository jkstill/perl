#!/usr/bin/perl

# this is used within pipewrt.frm
# unlink the file at the end, so that dataflex does not do it
# before the perl program is done with the output

$ReadPipe = $ARGV[0];

# this file signals calling dataflex program we are ready
open(SIGNAL,">$ARGV[1]") || die "can't open Signal file\n";
print SIGNAL "ready";
close(SIGNAL);

open(PIPE,$ReadPipe) || die "can't open $ReadPipe\n";
open(FILEOUT,">/tmp/jks.txt") || die "can't open /tmp/jks.txt\n";

while (<PIPE>) {

	print FILEOUT $_ ;

}

unlink($ReadPipe);
