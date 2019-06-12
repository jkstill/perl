#!/u01/app/perl/bin/perl -w

use strict;

my $infile="work3.txt";
open(WORK,"$infile") || die "cannot open $infile - $!\n";

my $delimiter=':';
my $nnDelimiter=',';
my $debug=0;

while(<WORK>){
	next if /^#/;
	chomp;	
	my ($rootname,$nicknames)=split(/$delimiter/);
	foreach my $nickname ( split(/$nnDelimiter/,$nicknames) ) {
		print "$nickname:$rootname\n";
	}
	next;

=head1

	# order in file is nickname, rootname
	# rootname or nickname may have multiples
	# delimited by :
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

=cut

}


