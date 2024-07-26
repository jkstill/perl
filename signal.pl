#!/usr/bin/env perl

use warnings;
use strict;

$SIG{ILL}=\&sigill;
$SIG{USR1}=\&sigusr1;
$SIG{USR2}=\&sigusr2;
$SIG{HUP}=\&sighup;
$SIG{INT}=\&sigint;
$SIG{QUIT}=\&sigquit;
$SIG{TERM}=\&sigterm;


=head1 signals

$  kill -l

HUP 1) SIGHUP       
INT 2) SIGINT       
QUIT 3) SIGQUIT      
ILL 4) SIGILL       
TRAP 5) SIGTRAP
ABRT 6) SIGABRT      
BUS 7) SIGBUS       
FPE 8) SIGFPE       
KILL 9) SIGKILL     
USR1 10) SIGUSR1
SEGV 11) SIGSEGV     
USR2 12) SIGUSR2     
PIPE 13) SIGPIPE     
ALRM 14) SIGALRM     
TERM 15) SIGTERM
16) SIGSTKFLT   
CHKD 17) SIGCHLD     
CONT 18) SIGCONT     
STOP 19) SIGSTOP     
STB 20) SIGTSTP
21) SIGTTIN     
22) SIGTTOU     
23) SIGURG      
24) SIGXCPU     
25) SIGXFSZ
26) SIGVTALRM   
27) SIGPROF     
28) SIGWINCH    
29) SIGIO       
30) SIGPWR
31) SIGSYS      
34) SIGRTMIN    
35) SIGRTMIN+1  
36) SIGRTMIN+2  
37) SIGRTMIN+3
38) SIGRTMIN+4  
39) SIGRTMIN+5  
40) SIGRTMIN+6  
41) SIGRTMIN+7  
42) SIGRTMIN+8
43) SIGRTMIN+9  
44) SIGRTMIN+10 
45) SIGRTMIN+11 
46) SIGRTMIN+12 
47) SIGRTMIN+13
48) SIGRTMIN+14 
49) SIGRTMIN+15 
50) SIGRTMAX-14 
51) SIGRTMAX-13 
52) SIGRTMAX-12
53) SIGRTMAX-11 
54) SIGRTMAX-10 
55) SIGRTMAX-9  
56) SIGRTMAX-8  
57) SIGRTMAX-7
58) SIGRTMAX-6  
59) SIGRTMAX-5  
60) SIGRTMAX-4  
61) SIGRTMAX-3  
62) SIGRTMAX-2

$  perl -e 'use Data::Dumper; print join("\n",keys %SIG)'| sort
ABRT
ALRM
BUS
CHLD
CLD
CONT
FPE
HUP
ILL
INT
IO
IOT
KILL
NUM32
NUM33
NUM35
NUM36
NUM37
NUM38
NUM39
NUM40
NUM41
NUM42
NUM43
NUM44
NUM45
NUM46
NUM47
NUM48
NUM49
NUM50
NUM51
NUM52
NUM53
NUM54
NUM55
NUM56
NUM57
NUM58
NUM59
NUM60
NUM61
NUM62
NUM63
PIPE
POLL
PROF
PWR
QUIT
RTMAX
RTMIN
SEGV
STKFLT
STOP
SYS
TERM
TRAP
TSTP
TTIN
TTOU
UNUSED
URG
USR1
USR2
VTALRM
WINCH
XCPU
XFSZ

=cut

my $exit = 0;

foreach my $key ( sort keys %SIG ) {
	print "$key";
	print " - $SIG{$key}" if defined $SIG{$key};
	print "\n";
}

while (1) {
	sleep 1;
	print "loop...\n";
	exit if $exit;
}

sub sigill {
	print "Caught ILL...\n";
	$exit = 1;
}

sub sigusr1 {
	print "Caught USR1...\n";
	$exit = 0;
}

sub sigusr2 {
	print "Caught USR2...\n";
	$exit = 0;
}


sub sighup {
	print "Caught HUP...\n";
	$exit = 0;
}

sub sigquit {
	print "Caught QUIT...\n";
	$exit = 1;
}

sub sigint {
	print "Caught INT...\n";
	$exit = 0;
}

sub sigterm {
	print "Caught TERM...\n";
	$exit = 0;
}

