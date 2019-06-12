#!/u01/app/perl/bin/perl -w

use strict;

my $infile="work2.txt";
open(WORK,"$infile") || die "cannot open $infile - $!\n";

my $delimiter=':';
my $printit=0;
my $isNickname=1;
my ($nickname, $rootname);
my $debug=1;

while(<WORK>){
	next if /^#/;
	chomp;	
	# order in file is nickname, rootname
	# rootname or nickname may have multiples
	# delimited by :
	if ($isNickname){
		$nickname = $_;
		$isNickname=0;
		$printit=0;
	} else {
		$rootname = $_;
		$isNickname=1;
		$printit=1;
	}

	if ($printit) {
		# cycle through list of names if multiples
		if ( $nickname =~ /$delimiter/ ) {
			my @nicknames=split(/$delimiter/,$nickname);
			foreach my $name (@nicknames) { 
				$name = ucfirst(lc($name));
				# cycle through rootnames if needed
				if ( $rootname =~ /$delimiter/ ) {
					#warn "splitting rootname $rootname\n";
					my @rootnames=split(/$delimiter/,$rootname);
					foreach my $rname (@rootnames) { 
						$rname = ucfirst(lc($rname));
						print "${name}${delimiter}${rname}\n";
					}
				} else {
					$rootname = ucfirst(lc($rootname));
					print "${name}${delimiter}${rootname}\n";
				}
			}
		} else {
			if ( $rootname =~ /$delimiter/ ) {
				#warn "splitting rootname $rootname\n";
				my @rootnames=split(/$delimiter/,$rootname);
				foreach my $rname (@rootnames) { 
					$rname = ucfirst(lc($rname));
					print "${nickname}${delimiter}${rname}\n";
				}
			} else {
				$rootname = ucfirst(lc($rootname));
				$nickname = ucfirst(lc($nickname));
				print "${nickname}${delimiter}${rootname}\n";
			}
		}
		$printit = 0;
	}
}


