#!/usr/bin/env perl

# DBI-sqltrace.pl
# A simple script to demonstrate the use of the DBI::Oracle::SQLTrace module
# take the Perl module from this script and put it in your Perl library path or perl script
# if embedding the module in your script, make sure the module is in a BEGIN block

use warnings;
use strict;
use FileHandle;
use DBI;
use Getopt::Long;
use Data::Dumper;
$Data::Dumper::Indent=2; # 1= more compact indentation, 2=default
$Data::Dumper::Sortkeys=1; # sorted hash keys handier for consistency
$Data::Dumper::Maxrecurse=3;
$Data::Dumper::Maxdepth=3;
$Data::Dumper::Terse=0;

my %optctl = ();

my($db, $username, $password);
my ($help, $sysdba, $connectionMode, $localSysdba, $sysOper) = (0,0,0,0,0);
my $sqlTrace = 0;
my $traceBindValues = 0;
my $traceWaits = 1;
my $traceId = '';

Getopt::Long::GetOptions(
	\%optctl,
	"database=s"	=> \$db,
	"username=s"	=> \$username,
	"password=s"	=> \$password,
	"sysdba!"		=> \$sysdba,
	"local-sysdba!"=> \$localSysdba,
	"sysoper!"		=> \$sysOper,
	"sql-trace!"	=> \$sqlTrace,
	"trace-waits!"	=> \$traceWaits,
	"trace-binds!"	=> \$traceBindValues,
	"trace-id=s"	=> \$traceId,
	"z|h|help"		=> \$help
);

if (! $localSysdba) {

	$connectionMode = 0;
	if ( $sysOper ) { $connectionMode = 4 }
	if ( $sysdba ) { $connectionMode = 2 }

	usage(1) unless ($db and $username and $password);
}


#print qq{
#
#USERNAME: $username
#DATABASE: $db
#PASSWORD: $password
    #MODE: $connectionMode
 #RPT LVL: @rptLevels
#};
#exit;


$|=1; # flush output immediately

my $dbh ;

if ($localSysdba) {
	$dbh = DBI->connect(
		'dbi:Oracle:',undef,undef,
		{
			RaiseError => 1,
			AutoCommit => 0,
			ora_session_mode => 2
		}
	);
} else {
	$dbh = DBI->connect(
		'dbi:Oracle:' . $db,
		$username, $password,
		{
			RaiseError => 1,
			AutoCommit => 0,
			ora_session_mode => $connectionMode
		}
	);
}

die "Connect to  $db failed \n" unless $dbh;
$dbh->{RowCacheSize} = 100;

my $sqltraceObj;

if ( $sqlTrace ) {
	$sqltraceObj = DBI::Oracle::SQLTrace->new(
		DBH => $dbh,
		DEBUG => 0,
		BINDS => $traceBindValues,
		WAIT => $traceWaits,
		TRACE_ID => $traceId
	);
	$sqltraceObj->start_trace();
	warn "SQL Trace started\n";
}

my $sql=q{select user from dual};
my $sth = $dbh->prepare($sql,{ora_check_sql => 0});
$sth->execute;
my ($dbuser) = $sth->fetchrow_array;
$sth->finish;

print "Username: $dbuser\n";

if ( $sqlTrace ) {
	$sqltraceObj->stop_trace();
	my $trace_file = $sqltraceObj->get_trace_file_name();
	warn "SQL Trace stopped\n";
	warn "Trace file: $trace_file\n";
}

$dbh->disconnect;

sub usage {
	my $exitVal = shift;
	$exitVal = 0 unless defined $exitVal;
	use File::Basename;
	my $basename = basename($0);
	print qq/

usage: $basename

  --database      target instance
  --username      target instance account name
  --password      target instance account password

  --sql-trace     enable SQL trace for the session
  --trace-waits   enable wait event tracing (default)
  --trace-binds   enable bind value tracing
  --trace-id      set trace file identifier (default '')

  --sysdba        logon as sysdba
  --sysoper       logon as sysoper
  --local-sysdba  logon to local instance as sysdba. ORACLE_SID must be set
                 the following options will be ignored:
                   --database
                   --username
                   --password

  example:

  $basename -database dv07 -username scott -password tiger -sysdba  

  $basename -local-sysdba 

/;
   exit $exitVal;
};

BEGIN {

package DBI::Oracle::SQLTrace;

use strict;
use warnings;
use Carp;
use Data::Dumper;
$Data::Dumper::Indent=2; # 1= more compact indentation, 2=default
$Data::Dumper::Sortkeys=1; # sorted hash keys handier for consistency
$Data::Dumper::Maxrecurse=3;
$Data::Dumper::Maxdepth=3;
$Data::Dumper::Terse=0;

use Exporter qw(import);
our $VERSION=0.1;
our @EXPORT = qw(start_trace stop_trace);
our @ISA=qw(Exporter);

use constant {
   START_TRACE => 0,
   STOP_TRACE  => 1,
};

my %SQL = (
	START_TRACE => q{alter session set events '10046 trace name context forever, level  },
	STOP_TRACE  => q{alter session set events '10046 trace name context off'},
	SET_TRACE_ID => q{alter session set tracefile_identifier = '?'},
	GET_TRACE_FILE_NAME => q{select value from v$diag_info where name = 'Default Trace File'},
);

sub new {
	my $pkg = shift;
	my $class = ref($pkg) || $pkg;

	my (%args) = @_;

=head1 DESCRIPTION

  This module provides methods to start and stop SQL trace
  on an Oracle database session.

  The user must have the alter session privilege.

=cut

=head2 ARGUMENTS

 Passed as a hash:
 DBH           - database handle
 BINDS         - include bind values in trace (default 0)
 WAITS         - include wait events in trace (default 1)
 DEBUG         - debug flag (default 0)
 TRACE_ID      - value added the trace file name (default '')

=cut

	$args{SQL} = \%SQL;

	my $self = bless \%args, $class;

	if ( ! exists($self->{DEBUG}) ) { $self->{DEBUG} = 0; }
	if ( ! exists($self->{BINDS}) ) { $self->{BINDS} = 0; }
	if ( ! exists($self->{WAITS}) ) { $self->{WAITS} = 1; }

	my $trace_level = 0;
	$trace_level += 4 if ( $self->{BINDS} );
	$trace_level += 8 if ( $self->{WAITS} );
	$self->{TRACE_LEVEL} = $trace_level;

	if ( defined $self->{TRACE_ID} ) {
		print STDERR "Setting trace ID to $self->{TRACE_ID}\n" ; #if $self->{DEBUG};
		$self->set_trace_id( $self->{TRACE_ID} );
	} else {
		croak "DBI::Oracle::SQLTrace->new: DBH argument is required\n";
	}

	print "DBI::Oracle::SQLTrace self: ", Dumper($self) ; #if $args{DEBUG};

	# one way to create a dispatch table in an object
	# this is probably the simplest and least flexible method
	# but it is one I will understand easily again when
	# working on the code at a later time
	$self->{dispatchers}[START_TRACE] = sub { $self->start_trace(); };
	$self->{dispatchers}[STOP_TRACE] = sub { $self->stopTrace(); };

	return $self;
}

sub get_trace_file_name {
	my ($self) = @_;
	my ($dbh) = $self->{DBH};
	#print Dumper($self);
	my $sth = $dbh->prepare($SQL{GET_TRACE_FILE_NAME});
	$sth->execute;
	my ($trace_file) = $sth->fetchrow_array;
	$sth->finish;
	return $trace_file;
}

sub set_trace_id {
	my ($self, $trace_id) = @_;
	my ($dbh) = $self->{DBH};
	eval {
		local $dbh->{RaiseError} = 1;
		local $dbh->{PrintError} = 0;
		$dbh->do("alter session set tracefile_identifier = '$trace_id'");
	};
	if ($@) {
		cleanup_and_croak($self, "Failed to set tracefile identifier to $trace_id: $@");
	}
	return get_trace_file_name($self);
}

sub start_trace {
	my ($self) = @_;
	warn "Starting trace with level $self->{TRACE_LEVEL}\n";
	warn "SQL: ", $self->{SQL}{START_TRACE}, "\n" ;
	my $sth = $self->{DBH}->prepare($self->{SQL}{START_TRACE} . qq{$self->{TRACE_LEVEL}'});
	$sth->execute;
	$sth->finish;
}
sub stop_trace {
	my ($self, $dbh) = @_;
	$self->{DBH}->do($self->{SQL}{STOP_TRACE});
}

sub cleanup_and_croak {
	my ($self, $msg) = @_;
	eval {
		local $dbh->{RaiseError} = 1;
		local $dbh->{PrintError} = 0;
		$self->stop_trace();
		$self->{DBH}->disconnect if $self->{DBH};
	};	
	croak $msg;
}
1;

}


