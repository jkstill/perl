#!/usr/bin/perl


=head1 eccentric.pl

Perl implementation of a program to determine the size of the packing to 
use in a 3 jaw lathe chuck for eccentric, or offset work.

The Windows program is old, and does not work on windows 7.

The source was included, so it was easy to translate to perl

Marv Klotz has an excellent utility for setting up a 3-jaw chuck for a specific off-set (aka eccentricity) at:
http://www.myvirtualnetwork.com/mklotz/files/eccent.zip

=cut


my $root3=sqrt(3);
print "THREE JAW ECCENTRIC PACKING CALCULATION\n";
print "Width of chuck jaws in inches - eg. 0.125 : ";

my $w=<>;
chomp $w;

print "Diameter of workpiece in inches - eg 1.5625 : ";

my $d=<>;
chomp $d;

my $r=.5*$d;

print "Required eccentric offset in inches - eg 0.28125 : ";

my $e=<>;
chomp $e;

if ($e>($r+$w)/$root3)
{
 die "Work will fall through unpacked jaws.\n";
}

my $p;
if ($w>$root3*$e)
{
	$p=1.5*$e;
}
else
{
	$p=1.5*$e-$r+0.5*sqrt(4*$r*$r-3*$e*$e+2*$e*$w*$root3-$w*$w);
}

printf ("\nRequired Packing Size = %.4lf in\n",$p);


