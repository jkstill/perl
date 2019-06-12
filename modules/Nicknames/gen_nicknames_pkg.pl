#!/u01/app/perl/bin/perl -w

my $infile='nicknames.dat';

open(NICK,"$infile") || die "cannot open $infile -$!\n";

print q{

package Nicknames;
require Exporter;
use strict;

use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);
use vars qw(%rootnames %nicknames);

$VERSION= '0.01';
@ISA = qw(Exporter);
@EXPORT  = qw(nicknames rootname);
@EXPORT_OK = ();

%EXPORT_TAGS = (
	ALL => [@EXPORT, @EXPORT_OK]
);


# return list of nicknames for a name
sub nicknames {
	# initial cap
	my $rootname = ucfirst(lc(shift));
	return $rootnames{$rootname} if exists $rootnames{$rootname};
}

# return rootname for a nickname
sub rootname {
	my $nickname = ucfirst(lc(shift));
	return $nicknames{$nickname} if exists $nicknames{$nickname};
}

};


while(<NICK>) { print }


print q {
1;
};


