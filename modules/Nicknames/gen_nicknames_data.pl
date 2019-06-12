#!/u01/app/perl/bin/perl -w

use strict;
use Data::Dumper;

my $infile="nicknames.txt";
open(NICK,"$infile") || die "cannot open $infile - $!\n";

my $delimiter=':';
my $debug=1;
my %rootnames=();
my %nicknames=();

while(<NICK>){
	next if /^#/;
	chomp;	
	# order in file is nickname:rootname
	my ($nickname,$rootname) = split(/$delimiter/);

	#capitalize - init caps
	# that is how data is checked in scripts using this
	$nickname = ucfirst(lc($nickname));
	$rootname = ucfirst(lc($rootname));

	$nicknames{$nickname} = $rootname;
	push @{$rootnames{$rootname}},$nickname;
}

print "%rootnames = (\n";
print Dumper(\%rootnames);
print ");\n";
print "%nicknames = (\n";
print Dumper(\%nicknames);
print ");\n";


