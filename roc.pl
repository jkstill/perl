#!/usr/bin/perl

=head1 Rate of change

 x represents a time unit
 y represents a unit of resource usage

 x1 = period start
 x2 = period end

 y1 = resource usage at time x1
 y2 = resource usage at time x2

 x3 = value representing 100% of resource capacity

 calculate the rate of change

         y2 - y1
   r =  _________

         x2 - x1
  

=cut

# start time and end time
# assuming minutes
my $times=[30,60];

# starting capacity and ending capacity
# assume megabytes or whatever
my $series=[100,200];
my $capacity=300;

my $x = Forecast->new (
	{
		TIME => $times,
		SERIES => $series,
		CAPACITY => $capacity
	}
);


print "Showing some predictions \n";

# assume the time unit is minutes
foreach my $c ( (70,80,90,100) ) {
	print "Capacity of ${c}% will occur in ",  $x->timeToThreshold($c), " minutes\n";
}

# warn me if 90% capacity will occur within N minutes
my $maxCapacityPct=90;
my $minTimeThreshold = 21;

print "\n\nWarn if threshold of ${maxCapacityPct}% will be reached in $timeThreshold\n";

my $predictedTimeToThreshold = $x->timeToThreshold(${maxCapacityPct});

if ( $predictedTimeToThreshold <= $minTimeThreshold) {
	warn "Capacity of ${maxCapacityPct}% will occur in ",   $predictedTimeToThreshold, " minutes\n" ;
} else {
	print "No problem found!\n";
}

##############################################################
## Package Follows
##############################################################

package Forecast;

require Exporter;
our @ISA= qw(Exporter);
our @EXPORT_OK = ( 'timeToThrehold','rateOfChange');
our $VERSION = '0.01';

#sub new(@@$);

sub new {

	use Data::Dumper;
	use Carp;

	my $pkg = shift;
	my $class = ref($pkg) || $pkg;
	#print "Class: $class\n";
	my ($args) = @_;
	#print 'args: ' , Dumper($args);

	my $self = {
		TIME=>$args->{TIME},
		SERIES=>$args->{SERIES},
		CAPACITY=>$args->{CAPACITY},
		CLASS=>$class
	};

   #print Dumper($self);

	{
		no warnings;
		if ( (not defined $self->{TIME}) || (not defined $self->{SERIES}) || (not defined $self->{CAPACITY})  ) {
			warn "invalid call to $self->{CLASS}\n";
			warn "call with \nmy \$a = $self->{CLASS}->new(\n";
			warn "   {\n";
			warn "      TIME=> (x1, x2),\n";
			warn "      SERIES => (y1, y2\n";
			warn "      CAPACITY => (x3)\n";
			warn "   }\n";
			croak;
		}
	}

	my $retval = bless $self, $class;
	return $retval;
}

sub rateOfChange {
	use Carp;
	my $self = shift;
	return ( 
		($self->{SERIES}[1] - $self->{SERIES}[0] )
		/
		($self->{TIME}[1] - $self->{TIME}[0] )
	);
}

sub timeToThreshold {
	use Carp;
	my $self = shift;
	my $pctThreshold = shift;

   #print Dumper($self);

=head2 timeToThreshold

 Return the number of time units required to reach the threshold of capacity

 A negative return value indicates the threshold is lower than the current usage

 Verbose code to explain how this works 

	my $roc = $self->rateOfChange;

	# calculate rate of change
	my $avail = $threshold -  $self->{SERIES}[1];

	# divide available capacity by rate of cahnge
	return $avail / $roc;

=cut

	#my $sizeThreshold = $self->{CAPACITY} / $pctThreshold * 100;
	#( $sizeThreshold -  $self->{SERIES}[1] ) /  $self->rateOfChange;
	# becomes 1 lines - leave commented code for clarity
	(
		( ( $self->{CAPACITY} * $pctThreshold / 100 ) -  $self->{SERIES}[1] )
		/
		$self->rateOfChange
	)
}

1;


