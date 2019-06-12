#!/usr/bin/perl -w

=head1 perltrace

=head1 Jared Still

=head2 a somewhat crude but effective method to get timing information

perltrace came about when troubleshooting ssh and I was using the -v -v
options to ssh/scp.  While I could see on the screen that some bits were
taking a very long time, it would have been so much nicer to have some
timing information for each step.

Hence perltrace was created.

options:

-cmdfirst 

This is the default. It is assumed that cmds are printed to output
and then the command is executed.

-nocmdfirst

If the program you are timing runs something and then outputs the
results, use this option.

usage:

$> time scp -v -v  somefile somuser@someserver:~/ 2>&1 | perltrace.pl -cmdfirst > t.log

real    1m34.247s
user    0m0.016s
sys     0m0.013s

$> awk '{ x=x+$1 } END{print x}'  t.log
94.2339

As shown by the real time vs. the calculated time from the log, there really
is not much overhead incurred by Perl.

=cut

use POSIX qw(strftime);
use Time::HiRes( qw{tv_interval gettimeofday});
use Data::Dumper;

my ($wallClockTime,$startTime,$endTime,$tdiff,$tsum,@printline,$line);
my ($gWallclockStartTime,$gWallclockEndtime,$gStartTime,$gEndTime,$gElapsedTime);
my @l;

$|++;

# use arg 1 and 2 as start time if passed
# seconds and microseconds

use Getopt::Long;
%optctl = ();

my $opterr=GetOptions(\%optctl,
	"cmdfirst!",
	"wallclock!",
	"totals!",
	"help!",
	"h!",
	"debug!"
);


# Getopt returns 1 if no error
if (! $opterr) {
	print "error!\n";
	usage(1);
}

usage() if ( defined($optctl{h}) or defined($optctl{help}) );

my $debug = defined($optctl{debug}) ? $optctl{debug} : 0;
my $wallClock = defined($optctl{wallclock}) ? $optctl{wallclock} : 0;
my $doTotals = defined($optctl{totals}) ? $optctl{totals} : 0;

# does the command output appear before execution (-cmdfirst)
# or after execution (-nocmdfirst) ?
my $cmdfirst = defined($optctl{cmdfirst}) ? $optctl{cmdfirst} : 1;

print "cmdfirst: $cmdfirst\n" if $debug;

if ($cmdfirst){ 
	$printline[1]=''
}

# used globally with printf
my $secondsFormat='04.6f';
my $timevalFormat='010.6f';
my $diffvalFormat='04.6f';

($startTime) = [gettimeofday];
$gStartTime = $startTime;
$wallClockTime = strftime "%Y-%m-%d %H:%M:%S", localtime;
$gWallclockStartTime = $wallClockTime;

my $firstline = 1;

while (<>) {

	print "######## top of loop ##############\n" if $debug;

	chomp;
	$line=$_;

	shift @printline, push @printline,$line;
	print "printline: ", Dumper(\@printline) if $debug;

	# if this is the first line then we do not yet have timing information
	if ($firstline) {
		print "firstline: go to top of loop\n" if $debug;
		$firstline = 0;

		# pick up first line timing if -nocmdfirst
		unless ($cmdfirst) {
			($endTime) = [gettimeofday];
			$tdiff = tv_interval($startTime, $endTime);
			printf "%s%$secondsFormat %s\n", ($wallClock ? $wallClockTime . ' ' : '') , $tdiff,$printline[0];
			($startTime) = [gettimeofday];
			$wallClockTime = strftime "%Y-%m-%d %H:%M:%S", localtime;

		}

		next;
	}

	($endTime) = [gettimeofday];

	$tdiff = tv_interval($startTime, $endTime);

	printf "%s%$secondsFormat %s\n", ($wallClock ? $wallClockTime . ' ' : '') , $tdiff,$printline[0];

	tdebug('loop',$startTime,$endTime);

	($startTime) = [gettimeofday];
	$wallClockTime = strftime "%Y-%m-%d %H:%M:%S", localtime;

}


# pick up the last line if cmdfirst
# if no cmdfirst we already got timing info inside the loop
if ($cmdfirst) {
	shift @printline, push @printline,$line;
	$endTime=[gettimeofday];
	$tdiff = tv_interval($startTime, $endTime);
	tdebug('end',$startTime,$endTime);
	printf "%s%$secondsFormat %s\n", ($wallClock ? $wallClockTime . ' ' : '') , $tdiff,$printline[0];
}

$gEndTime = $endTime;

$gWallclockEndtime = $wallClockTime;
$gElapsedTime = sprintf("%$secondsFormat" , tv_interval($gStartTime, $gEndTime));

if ($doTotals) {
	print qq {

Start Time: $gWallclockStartTime
  End Time: $gWallclockEndtime
   Elapsed: $gElapsedTime

};
}


# subs follow

sub tdebug {
	return unless $debug;
	my ($label,$stime, $etime) = @_;

	# seconds + microseconds
	my $st = $stime->[0] + ($stime->[1] / 10**6);
	my $et = $etime->[0] + ($etime->[1] / 10**6);

	my $diff = $et - $st;

   print qq{   == $label\n};
   print qq{   printline: $label\n};
   printf ("   start: %$timevalFormat\n",$st);
   printf ("     end: %$timevalFormat\n",$et);
   printf ("    diff: %$diffvalFormat\n",$diff);
   print qq{   =========================\n};

}


sub usage {

	my $exitVal = shift;
	use File::Basename;
	my $basename = basename($0);
	print qq{
$basename

usage: $basename - get timing information from program output

   $basename -cmdfirst|nocmdfirst -wallclock -totals

-cmdfirst     output precedes execution
-nocmdfirst   output follows exection
-wallclock    include wall clock time
-totals       include start,stop and total elapsed time

eg:

   $basename -option1 parameter1 -option2 parameter2 ...
	time scp -v -v  somefile somuser\@someserver:~/ 2>&1 | $basename -cmdfirst > t.log
};

	exit eval { defined($exitVal) ? $exitVal : 0 };
}

