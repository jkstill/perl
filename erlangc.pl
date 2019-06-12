#!/usr/bin/perl

# ErlangC.pl	More precise forecasting mathematics using ErlangC
# Created by Craig Shallahamer on August 3, 2006

$queues               =  1; # Queues in entire system
                              # For CPU subsystem will be 1
                              # For IO  subsystem will be number of devices
$servers              =  19 ; # Servers per each queue
                              # For CPU subsystem will be number of CPUs
                              # For IO  subsystems will be 1
$service_time         =  4; # units example: ms/trx
$system_arrival_rate  =  5 ; # units example: trx/ms

$queue_arrival_rate   = $system_arrival_rate / $queues ; 
$queue_traffic        = $service_time * $queue_arrival_rate ;

$rho                  = $queue_traffic / $servers ;
$ErlangB              = $queue_traffic / ( 1 + $queue_traffic ) ;

# Jagerman's algorithm
$m=0;
$eb=0;
for ($m=2;$m<=$servers;$m++) {
     $eb = $ErlangB;
     $ErlangB = $eb * $queue_traffic / ( $m + $eb * $queue_traffic ) ;
}
$ErlangC = $ErlangB / ( 1 - $rho + $rho * $ErlangB ) ;

$utilization = ( $service_time * $queue_arrival_rate ) / $servers ;
print "Utilization             = $utilization \n";

$queue_time = ( $ErlangC * $service_time ) / 
              ( $servers * ( 1 - $utilization ) ) ;

$response_time = $service_time + $queue_time ;

$queue_length  = $queue_arrival_rate * $queue_time ;

print "\n";
print "Forecasting Oracle Performance by C. Shallahamer \n\n";
print "More Precisse Queueing Mathematics with ErlangC \n\n";
print "System arrival rate     = $system_arrival_rate \n";
print "Queues in system        = $queues \n";
print "Queue arrival rate      = $queue_arrival_rate \n";
print "Servers per queue       = $servers \n";
print "Queue traffic           = $queue_traffic \n";
print "Erlang C                = $ErlangC \n";
print "Utilization             = $utilization \n";
print "Service time            = $service_time \n";
print "Queue time              = $queue_time \n";
print "Response time           = $response_time \n";
print "Queue length            = $queue_length \n";
print "\n";
