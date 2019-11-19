#!/home/oracle/perl/bin/perl

# template for DBI programs

use warnings;
use FileHandle;
use DBI;
use strict;
use Data::Dumper;

use Getopt::Long;

our %optctl = ();

Getopt::Long::GetOptions(
	\%optctl, 
	"database=s",
	"username=s",
	"password=s",
	"target=s",
	"sysdba!",
	"sysoper!",
	"z","h","help");

#setup environment - homegrown package

our($db, $username, $password, $connectionMode);

$connectionMode = 0;
if ( $optctl{sysoper} ) { $connectionMode = 4 }
if ( $optctl{sysdba} ) { $connectionMode = 2 }

if ( 
	! defined($optctl{database})
	|| ! defined($optctl{username})
	|| ! defined($optctl{password})
	|| ! defined($optctl{target})
) { Usage(1) }


$db=$optctl{database};
$username=$optctl{username};
$password = $optctl{password};

our $dbh = DBI->connect(
	'dbi:Oracle:' . $db, 
	$username, $password, 
	{ 
		RaiseError => 1, 
		AutoCommit => 0,
		ora_session_mode => $connectionMode
	} 
	);

die "Connect to  $db failed \n" unless $dbh;

our $fkSql= q{
select
	 col.table_name
	, col.constraint_name
	, col.column_name
	, col.position
from (
	select distinct
		c.owner owner
		, c.table_name table_name
		, c.constraint_name constraint_name
	from dba_constraints c, dba_constraints p
	where c.r_constraint_name = p.constraint_name
	and c.r_owner = p.owner
	and p.owner = ?
) con,
	dba_cons_columns col
where con.owner = col.owner
and con.constraint_name = col.constraint_name
and con.table_name = col.table_name
order by table_name, constraint_name
};

our $idxSql = q{
select
	a.table_name
	, a.index_name index_name
	, b.column_name column_name
	, b.column_position column_position
from dba_indexes a, dba_ind_columns b
where  a.table_name = b.table_name
	and a.index_name = b.index_name
	and a.owner = ?
	and b.index_owner = a.owner
order by a.table_name,a.index_name, b.column_position
};

our $sth = $dbh->prepare($fkSql);
my $targetUser = uc($optctl{target});

use vars qw{$rv};
our $rv = $sth->execute($targetUser) || die "error with statement $fkSql \n";

my %fk=();

# get the FK data
while( my $ary = $sth->fetchrow_hashref ) {
	push @{$fk{ $ary->{TABLE_NAME} }{ $ary->{CONSTRAINT_NAME} }}, $ary->{COLUMN_NAME};

	#print "TABLE:  $ary->{TABLE_NAME}   ";
	#print "CONSTRAINT:  $ary->{CONSTRAINT_NAME}   ";
	#print "COLUMN:  $ary->{COLUMN_NAME}\n";
}

#print Dumper(\$fk{FMSERNO});


# get the index data
$sth = $dbh->prepare($idxSql);

$rv = $sth->execute($targetUser) || die "error with statement $idxSql \n";

my %idx=();

# get the INDEX data
while( my $ary = $sth->fetchrow_hashref ) {
	$idx{ $ary->{TABLE_NAME} }{ $ary->{INDEX_NAME} }[ $ary->{COLUMN_POSITION} -1 ] = $ary->{COLUMN_NAME};

	#print "TABLE:  $ary->{TABLE_NAME}   ";
	#print "INDEX:  $ary->{INDEX_NAME}   ";
	#print "COLUMN:  $ary->{COLUMN_NAME}\n";
}


#print Dumper(\$idx{FMSERNO});

$sth->finish;
$dbh->disconnect;

# OK, go the data, time to check for indexes

foreach my $table ( sort keys %fk ) {
	print "Table: $table\n";
	foreach my $constraint ( sort keys %{$fk{$table}} ) {
		print "\tConstraint: $constraint  ";

		# extract the first N columns from the index
		# and compare to N columns in FK
		# if not a 1:1 relationship, then no index 
		# will support the FK

		my $indexSupported = '';
		my $supportingIndex = '';
		my @fkColumns = @{$fk{$table}{$constraint}};
		foreach my $index ( keys %{$idx{$table}} ) {
			# if not at least the same number of columns
			# as the FK, then skip the index

			my @idxColumns = @{$idx{$table}{$index}};

			# if the number of index columns is less than 
			# the number of FK columns, then this index
			# cannot support the FK.  skip it
			next if $#idxColumns < $#fkColumns;

			# trim the index column array to the same
			# number of elements as the FK.  These
			# leading index columns need to match the
			# FK columns
			@idxColumns = @idxColumns[0..$#fkColumns];

			# do the index columns match the FK columns?
			# order is not important. The leading columns
			# of the index must match the columns in the FK.
			# the index will support the FK, even if the 
			# columns are in a different order
			if ( join('',(sort @idxColumns)) eq join('',(sort @fkColumns)) ) {
				$indexSupported=1;
				$supportingIndex = $index;
				last;
			}
		}

		if ( $indexSupported ) {
			print "is supported by index $supportingIndex\n";
		} else {
			print "is NOT supported by any index\n";
		}
	}
}

sub Usage {
	my ($exitVal) = shift;
	use File::Basename;
	my $program = basename($0);
	print qq/

usage:  $program

  $program -database dv07 -username scott -password tiger -schema truman

  -database which database?
  -username account to connect to
  -password your password
  -target   which schema to check

  -sysdba || -sysoper optional. 
                      connect as sysoper or sysdba? 
                      only specify one of these


/;

	exit $exitVal;
}



