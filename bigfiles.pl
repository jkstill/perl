#!/u01/app/perl/bin/perl -w


use strict;
use File::Find ();

use Getopt::Long;

my %optctl = ();

GetOptions(\%optctl,
	"dir=s",
	"bytes=i",
	"help",
	"debug!"
);

my $dir = defined $optctl{dir} ? $optctl{dir} : '.';
my $bytes = defined $optctl{bytes} ? $optctl{bytes} : 1024;

if (defined($optctl{help})) { usage(0) }

# Set the variable $File::Find::dont_use_nlink if you're using AFS,
# since AFS cheats.

# for the convenience of &wanted calls, including -eval statements:
use vars qw/*name *dir *prune/;
*name   = *File::Find::name;
*dir    = *File::Find::dir;
*prune  = *File::Find::prune;

sub wanted;

# Traverse desired filesystems
File::Find::find({wanted => \&wanted}, $dir );

print "\nSearched directory $dir\n";
print "Looking for files >= $bytes bytes\n";

exit;


sub wanted {
    my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size);


    if (($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size) = lstat($_)) {
    	print("$size:$name\n") if $size >= (512 * 2**10 );
	 }
}


sub usage {

	my $exitVal = shift;
	use File::Basename;
	my $basename = basename($0);
	print qq{
$basename

usage: $basename - search for big files

   $basename -dir <directory> -bytes <bytes>

-dir    directory to start search
-bytes  minimum size of file to find
..

examples here:

   $basename -dir $ENV{HOME} -bytes 1048576
};

	exit $exitVal ? $exitVal : 0;
}


