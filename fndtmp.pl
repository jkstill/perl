#! /usr/bin/perl -w

use strict;
use File::Find ();
use File::Type;
use Data::Dumper;
use Getopt::Long;

# Set the variable $File::Find::dont_use_nlink if you're using AFS,
# since AFS cheats.

my %optctl = ();
my @dirs=();

my $opterr = GetOptions(\%optctl,
	"dir=s@"  => \@dirs,
	"help",
);

if (! $opterr) {
 print "error!\n";
 usage(1);
 
}


my $help = defined( $optctl{help}) ? 1 : 0;

if ($help) {
	usage(0);
}


# for the convenience of &wanted calls, including -eval statements:
use vars qw/*name *dir *prune/;
*name   = *File::Find::name;
*dir    = *File::Find::dir;
*prune  = *File::Find::prune;

sub wanted;


my %files=();
my $currEpoch=time;
my $secPerDay=60*60*24; # 86400

# Traverse desired filesystems
our $dir2Search;
foreach $dir2Search ( @dirs ) {
	File::Find::find({wanted => \&wanted}, $dir2Search);
}

#print Dumper(\%files);
#exit;

foreach my $dir ( sort keys %files ) {
	print "dir: $dir\n";
	my %userFiles=%{$files{$dir}};
	foreach my $user ( sort keys %userFiles ) {
		print "user: $user\n";
		printf "   age    count   megabytes\n";
		my %fileAges=%{$userFiles{$user}};
		foreach my $bucket ( sort {$a<=>$b} keys %fileAges ) {
			printf "   %03d  %7d  %9.2f\n", $bucket,$fileAges{$bucket}[0],$fileAges{$bucket}[1]/2**20;
		}
	}
}

exit;


sub wanted {
	my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,$atime,$mtime);
	my $user;
	my $lastAccessDays=0;
	my $bucket;

	my $isFile=0;

	$isFile =1 if (($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,$atime,$mtime) = lstat($_)) && -f _;

	if ($isFile) {
	
		$user=getpwuid($uid);
		$lastAccessDays=((($currEpoch - $mtime)/$secPerDay) % $secPerDay) + 1;
		# 7 days per bucket
		$bucket=int($lastAccessDays/7);
		$files{$dir2Search}->{$user}->{$bucket}[0]++; 
		$files{$dir2Search}->{$user}->{$bucket}[1] += $size; 
	}
}

sub usage {
	my $exitCode=$_;
	print "fndtmp.pl -dir /tmp -dir /var/tmp ...\n";
	exit $exitCode;
}

