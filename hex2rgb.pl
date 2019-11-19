#!/usr/bin/env perl

# convert HTML Hex code to RGB
#

use warnings;
use strict;
use Data::Dumper;

sub htmlHex2Dec ($);
sub lightOrDark($);
sub getFontColor($);

my $code='#339966';
#$code='#FFFFFF';

my @data=htmlHex2Dec($code);

print "'$code' is a ", lightOrDark(\@data), " color: The font used is : ", getFontColor(lightOrDark(\@data)), "\n";

print Dumper ( \@data );
#$data[1] = hex(substr($code,1,2));
#$data[2] = hex(substr($code,3,2));
#$data[3] = hex(substr($code,5,2));

# returns array
sub htmlHex2Dec ($) {

	my $hexCode = $_[0];

	print "hexCode: $hexCode\n";

	return (
		hex(substr($hexCode,1,2)),
		hex(substr($hexCode,3,2)),
		hex(substr($hexCode,5,2))
	)

}

sub lightOrDark($) {

	my $aref = $_[0];

	# found the basis for this on stack overflow
	# https://stackoverflow.com/questions/1855884/determine-font-color-based-on-background-color

	my $a = 1 - ( 0.299 * $aref->[0] + 0.587 *  $aref->[1] + 0.114 *  $aref->[2])/255;

	if ($a < 0.5) {
		return 'light'; # bright colors - black font
	} else {
		return 'dark' ; # dark colors - white font
	}

}

# returns white or black
# valid inputs are 'light' and 'dark'
# but really, only 'dark' is checked
sub getFontColor($) {
	my $shade = $_[0];
	
	return $shade =~ /dark/ ? 'white' : 'black';
}


