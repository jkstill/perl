#!/usr/bin/perl -w
use strict;
use Getopt::Long;
use MIME::Base64;

my ( $in, $out );
# Parse command line options
my $stat = GetOptions(    
	"i|input=s"  => \$in,
	"o|output=s" => \$out,
	"h|help|?"   => \&usage);

if ( defined $in ) {    
	close(STDIN);    
	open( STDIN, "<", $in ) || die "Cannot open $in for reading:$!\n";
}

if ( defined $out ) {
	close(STDOUT);
	open( STDOUT, ">", $out ) || die "Cannot open $out for writing:$!\n";
}

# Move to the first empty line and start decoding after it.

while (<STDIN>) { last if /^\s*$/; }

# Decode until the end of the file or the first empty line.

while (<STDIN>) {    
	last if /^\s*$/;
	printf( "%s", decode_base64($_) );
}

sub usage {    
	print      q(

mimedecode - command line utility for decoding MIME encoded files.      
USAGE:mime -i <input file> -o <output file>
);    
	exit(0);

}
