#!/usr/bin/perl -w

# ErlangC.pl	More precise forecasting mathematics using ErlangC
# Created by Craig Shallahamer on August 3, 2006

use Getopt::Long;

%optctl = ();

GetOptions(\%optctl,
	"queues=i",
	"servers=i",
	"service_time=f",
	"lambda=f",
	"help!",
	"debug!"
);

if (defined($optctl{help}) && $optctl{help}) {usage(0)};

my ($queues,$servers,$service_time,$system_arrival_rate);

# Queues in entire system
# For CPU subsystem will be 1
# For IO  subsystem will be number of devices
$queues = defined($optctl{queues}) ? $optctl{queues} : 1;

# Servers per each queue
# For CPU subsystem will be number of CPUs
# For IO  subsystems will be 1
$servers = defined($optctl{servers}) ? $optctl{servers} : 24;

# units example: ms/trx
$service_time = defined($optctl{service_time}) ? $optctl{service_time} : 4.0;

# units example: trx/ms
$system_arrival_rate = defined($optctl{lambda}) ? $optctl{lambda} : 5.0;

$queue_arrival_rate   = $system_arrival_rate / $queues ; 
$queue_traffic        = $service_time * $queue_arrival_rate ;

$rho                  = $queue_traffic / $servers ;
$ErlangB              = $queue_traffic / ( 1 + $queue_traffic ) ;

# Jagerman's algorithm
$m=0;
$eb=0;
for ($m=2;$m<=$servers;$m++) {
     $eb = $ErlangB;
     $ErlangB = $eb * $queue_traffic / ( $m + ($eb * $queue_traffic) ) ;
}
$ErlangC = $ErlangB / ( 1 - $rho + ($rho * $ErlangB)) ;

$utilization = ( $service_time * $queue_arrival_rate ) / $servers ;

$queue_time = ( $ErlangC * $service_time ) / 
              ( $servers * ( 1 - $utilization ) ) ;

$response_time = $service_time + $queue_time ;

$queue_length  = $queue_arrival_rate * $queue_time ;

print "\n";
print "Forecasting Oracle Performance by C. Shallahamer \n\n";
print "More Precise Queueing Mathematics with ErlangC \n\n";
print "System arrival rate     = $system_arrival_rate \n";
print "Queues in system        = $queues \n";
print "Queue arrival rate      = $queue_arrival_rate \n";
print "Servers per queue       = $servers \n";
print "Queue traffic           = $queue_traffic \n";
printf "Erlang C                = %10.8f\n",$ErlangC;
printf "Utilization             =%5.2f\n", $utilization;
print "Service time            = $service_time \n";
printf "Queue time              = %10.8f\n", $queue_time;
printf "Response time           = %10.8f\n", $response_time;
printf "Queue length            = %10.8f", $queue_length ;
print "\n";

sub usage {

	my $exitVal = shift;
	use File::Basename;
	my $basename = basename($0);
	print qq{
$basename

usage: $basename - ErlangC

   $basename -option1 parameter1 -option2 parameter2 ...

  -queues        number of queues in system
  -servers       number of servers in system
  -service_time  length of service time
  -lambda        arrival rate
  -help          print this screen
  -debug         debugging, if any
..

examples here:

   $basename -queues 1 -servers 10 -service_time 15 -lambda 12
};

	exit $exitVal ? $exitVal : 0;
}

