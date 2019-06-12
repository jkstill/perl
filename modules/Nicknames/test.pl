
use lib qw(./);

use Nicknames;
use Data::Dumper;

my @nicknames=qw(Barb Steve Babs Tom);

#get root names

foreach my $nickname (@nicknames) {
	my $rootname = rootname($nickname);
	print "$nickname - $rootname\n";
}

# get all nick names for root name of each name in list

foreach my $nickname (@nicknames) {
	my $rootname = Nicknames::rootname($nickname);
	print "$rootname\n";
	my $nicknameList = nicknames($rootname);
	#print Dumper($nicknameList);
	foreach $masterNickname (@{$nicknameList}) {
		print "\t$masterNickname\n";
	}
}

