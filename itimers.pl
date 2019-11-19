#	itimers.pl - timer manipulation functions
#	written by tom christiansen <tchrist@convex.com>
#
#	getitimer, setitimer  - like syscalls but return true on success
#				NB: require packed data for args
#
#	itimer		      - conversion function for packing and 
#				unpacking itimers.  packs in scalar context,
#				unpacks in array context.
#
#	alarm		      - like libc call but can take and returns floats
#

require 'sizeof.ph';
require 'syscall.ph';
require 'sys/time.ph';

#
# careful: implementation dependent!
#
$itimer_t = 'L4';  # itimers consist of four longs
$sizeof{'itimer'} = '16' unless defined $sizeof{'itimer'};  # from sizeof.ph?

###########################################################################
# itimer conversion function; this one goes both ways
#
sub itimer {
    if (wantarray) {
	warn "itimer: only expected one arg in array context" if $#_;
	warn "itimer: itimer to unpack not length ".$sizeof{'itimer'} 
	    unless length($_[0]) == $sizeof{'itimer'};
	return unpack($itimer_t, $_[0]);
    } else {
	return pack($itimer_t, $_[0], $_[1], $_[2], $_[3]); 
    } 
} 


###########################################################################
sub setitimer {
    local($which) = shift;
    local($retval);

    die "setitimer: input itimer not length ".$sizeof{'itimer'} 
	unless length($_[0]) == $sizeof{'itimer'};

    $_[1] = &itimer(0,0,0,0);
    syscall(&SYS_setitimer, $which, $_[0], $_[1]) != -1;
} 

###########################################################################
sub getitimer {
    local($which) = shift;

    $_[0] = &itimer(0,0,0,0);

    syscall(&SYS_getitimer, $which, $_[0]) != -1;
} 

###########################################################################
# 
# alarm; send me a SIGALRM in this many seconds (fractions ok)
# 
#
sub alarm {
    local($ticks) = @_;
    local($itimer,$otimer);
    local($isecs, $iusecs, $secs, $usecs);

    $secs = int($ticks);
    $usecs = ($ticks - $secs) * 1e6;

    $otimer = &itimer(0,0,0,0);
    $itimer = &itimer(0,0,$secs,$usecs);

    &setitimer(&ITIMER_REAL, $itimer, $otimer) 
	|| warn "alarm: setitimer failed: $!";

    ($isecs, $iusecs, $secs, $usecs) = &itimer($otimer);
    return $secs + ($usecs/1e6);
} 
