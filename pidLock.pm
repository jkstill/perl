
# lockpid
# jared still
# jkstill@teleport.com

# use to create locked files with PID in them

# save the PID in a file and lock it
# continue on open file failure
# caller must check for success or failure

=head1 NAME

pidLock.pm

=head1 USAGE

use pidLock to create a lock file with the PID of the process
as the contents of the file.  Prevent a script from executing
several times simultaneously.

e.g.


use pidLock;

my $lfile='/tmp/pidtest.lock';

$SIG{INT}=sub{ unlink $lfile; exit };


if ( pidLock::lockFile($lfile) ) {

	print "file locked with pidLock\n";

} else { die "unable to lock $lfile\n" }

=cut

package pidLock;

local *FH;
use Carp;

# pass handle, filename and PID
#lockFile($lockFile);

sub lockFile {

	( my $lockFile = shift) || croak "lockFile requires a file name\n";

	use Fcntl qw{:flock};

	# setup for lock file
	my $pid=$$;
	my $lockPid;
	local $|=1;

	if ( -r $lockFile and -w $lockFile ) {

		open(FH, $lockFile) || croak "could not open $lockFile(0) - $! \n";
		($lockPid) = <$fh_lockFile>;
		close FH;

		print "existing lock file '$lockFile' created by PID $lockPid\n";
		print "will try to lock\n";

		# file must be opened with intent to write
		# required on Solaris, don't know about other platforms
		open(FH,"+<$lockFile" ) || croak "could not open $lockFile(1) - $! \n";

		# lock file, recreate and relock
		# print PID to file
		if ( flock(FH, LOCK_EX|LOCK_NB) ) {

			open(FH,">$lockFile" ) || croak "could not create $lockFile(2) - $! \n";
			print FH $pid;

			unless ( flock(FH, LOCK_EX|LOCK_NB ) )
			 { croak "could not obtain exclusive lock on $lockFile(3) - $! \n"}

		} else { croak "process $lockPid holding exclusive lock on $lockFile(4) - $! \n"}

	} else { # lock file does not exist
		open(FH, ">$lockFile" ) || croak "could not create $lockFile(5) - $! \n";
		print FH $pid;
		unless ( flock(FH, LOCK_EX|LOCK_NB ) )
			{ croak "could not obtain exclusive lock on $lockFile(4) - $! \n"}
	}

	1;

}

1;



