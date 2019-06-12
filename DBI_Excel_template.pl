#!/u01/app/perl/bin/perl

# DBI_Excel_template.pl
# a template script for using DBI and Spreadsheet::WriteExcel
# Jared Still
# jkstill@gmail.com

=head1 DBI/Excel::Writer::XLSX tempate

This Perl program is a template for creating other scripts
that connect to Oracle and create an Excel Spreadsheet.

This script will list all roles and permissions granted to them.

The output will be an Excel Spreadsheet, with one page for each role.

Type DBI_Excel_template..pl -help for a help screen.


=cut


use warnings;
use strict;
use DBI;
use Getopt::Long;
use Excel::Writer::XLSX;

my $debug = 0;

my %optctl = ();

Getopt::Long::GetOptions(
	\%optctl, 
	"machine=s",
	"database=s",
	"username=s",
	"password=s",
	"spreadsheet_file=s",
	"sysdba!",
	"sysoper!",
	"z","h","help");

my( $database, $password, $username, $connectionMode);

if (
	$optctl{h} 
	|| $optctl{z}
	|| $optctl{help}
) {
	Usage(0);
}

my $xlFile = defined($optctl{spreadsheet_file}) ? $optctl{spreadsheet_file} : 'roles.xlsx';

$connectionMode = 0;
if ( $optctl{sysoper} ) { $connectionMode = 4 }
if ( $optctl{sysdba} ) { $connectionMode = 2 }

if ( ! defined($optctl{username}) ) {
	warn "username required\n";
	Usage(2);
} else {$username=$optctl{username}}

if ( ! defined($optctl{database}) ) {
	warn "database required\n";
	Usage(3);
} else {$database=$optctl{database}}

my $roleWorkBook;
my %roleWorkSheets = ();

my %fonts = (
	fixed			=> 'Courier New',
	fixed_bold	=> 'Courier New',
	text			=> 'Arial',
	text_bold	=> 'Arial',
);

my %fontSizes = (
	fixed			=> 10,
	fixed_bold	=> 10,
	text			=> 10,
	text_bold	=> 10,
);

my $maxColWidth = 50;
my $counter = 0;
my $interval = 100;

# lookup the password if not on the command line
if ( defined( $optctl{password} ) ) {
	$password = $optctl{password};
} else {
	warn "Password required!\n";
	Usage(4);
}


my $dbh = DBI->connect(
	'dbi:Oracle:' . $database,
	$username, $password,
	{
		RaiseError => 1,
		AutoCommit => 0,
		ora_session_mode => $connectionMode
	}
);

die "Connect to  $database failed \n" unless $dbh;

# apparently not a database handle attribute
# but IS a prepare handle attribute
#$dbh->{ora_check_sql} = 0;
$dbh->{RowCacheSize} = 100;

$dbh->do(q{alter session set nls_date_format='mm/dd/yyyy'},{ora_check_sql => 0});

my $rolenameSth = $dbh->prepare('select role from dba_roles order by role');
$rolenameSth->execute;
my @roles=();
# get all roles
while( my $rolename = $rolenameSth->fetchrow_hashref ) {
	push @roles, $rolename->{ROLE};
}

my %roleLineCount=();
# create workbook
$roleWorkBook  = Excel::Writer::XLSX->new(qq{${database}_${xlFile}});
die "Problems creating new Excel file ${database}_${xlFile}: $!\n" unless defined $roleWorkBook;

# create formats
my $stdFormat = $roleWorkBook->add_format(bold => 0,font => $fonts{fixed}, size => $fontSizes{fixed}, color => 'black');
my $boldFormat = $roleWorkBook->add_format(bold => 1,font => $fonts{fixed_bold}, size => $fontSizes{fixed_bold}, color => 'black');
my $wrapFormat = $roleWorkBook->add_format(bold => 0,font => $fonts{text}, size => $fontSizes{text}, color => 'black');
$wrapFormat->set_align('vjustify');

# create the cover page

$roleWorkSheets{CoverPage} = $roleWorkBook->add_worksheet('CoverPage');

# scalar is fine - the data section should all be one line
my $coverIntro = <DATA>;

{
my $upperDB = uc($database);
$coverIntro =~ s/<<DATABASE>>/$upperDB/g;
}

$roleLineCount{CoverPage} = 0;
$roleWorkSheets{CoverPage}->set_column($roleLineCount{CoverPage},0,60);
$roleWorkSheets{CoverPage}->write($roleLineCount{CoverPage}++,0,$coverIntro, $wrapFormat);

# create all role worksheets
# just list all roles on the cover page in alpha order, with links
foreach my $role ( sort @roles ) {
	$roleWorkSheets{$role} = $roleWorkBook->add_worksheet($role);

	# set column widths per each sheet
	# these are commented out
	# see dynamic settings in data loop below
	#$roleWorkSheets{$role}->set_column(0,0,10); # privtype
	#$roleWorkSheets{$role}->set_column(1,1,40); # privname
	#$roleWorkSheets{$role}->set_column(2,2,20); # owner
	#$roleWorkSheets{$role}->set_column(3,3,30); # table_name
	#$roleWorkSheets{$role}->set_column(4,4,10); # grantable ( admin option )

	# create link to cover page
	$roleWorkSheets{$role}->write(0,0,"internal:CoverPage!A1", 'CoverPage');
	$roleWorkSheets{CoverPage}->write($roleLineCount{CoverPage}++,0,"internal:${role}!A1", $role);

	$roleLineCount{$role} = 1;
}

my $roleSql = q{
select * 
from (
select 'ROLE' privtype, granted_role privname, null owner, null table_name, admin_option grantable
from dba_role_privs
where grantee = upper(?)
union
select 'SYSPRIV' privtype, privilege privname, null owner, null table_name, admin_option grantable
from dba_sys_privs
where grantee = upper(?)
union
select 'TABPRIV' privtype, privilege privname, owner, table_name, grantable
from dba_tab_privs
where grantee = upper(?)
order by 1, 2, 3, 4
)
};

foreach my $role ( sort @roles ) {

	my $sth = $dbh->prepare($roleSql);
	$sth->execute($role,$role,$role);

	
	# setup column widths
	my @precision = @{$sth->{PRECISION}};
	# get scale - deal with undefs
	my @scale = map { defined($_) ? $_ : 0 } @{$sth->{SCALE}};
	foreach my $el ( 0..$#precision ) {
		my $colWidth = $precision[$el]+$scale[$el] > $maxColWidth 
			? $maxColWidth 
			: $precision[$el]+$scale[$el];
		$roleWorkSheets{$role}->set_column($el,$el,$colWidth);
	}

	# get column names from DBI
	my @colNames = @{$sth->{NAME_uc}};
	$roleWorkSheets{$role}->write_row($roleLineCount{$role}++,0,\@colNames,$boldFormat);

	# freeze pane at header
	$roleWorkSheets{$role}->freeze_panes($roleLineCount{$role},0);

	while( my $rolePrivs = $sth->fetchrow_arrayref ) {
		$roleWorkSheets{$role}->write_row($roleLineCount{$role},0,$rolePrivs,
			$stdFormat
		);
		if ($rolePrivs->[0] eq 'ROLE' ) {
			$roleWorkSheets{$role}->write($roleLineCount{$role},1,
				"internal:" . $rolePrivs->[1] . "!A1", $rolePrivs->[1]
			);
		}
		$roleLineCount{$role}++;
	}
}

$dbh->disconnect;


sub Usage {
	my $exitval = shift;
	use File::Basename;
	my $basename = basename($0);

	print qq{

usage: $basename  Oracle System Account Lister 

-database            target database
-username            DBA account
-password            account password
                     use one of the following options
                     to connect as SYSOPER or SYSDBA

                     [-sysdba || -sysoper]

-spreadsheet_file   Name of spreadsheet file to create. Defaults to roles.xlsx

};

	exit $exitval;

}

__DATA__
This Spreadsheet contains a separate worksheet for every role in the database <<DATABASE>>.  You may go directly to the page for each role by clicking on it on this page. If there are other database roles assigned to the chosen role, you may go to those roles by clicking on the links.  Try this on the DBA role, as it usually has several links. You may return to this page by clicking on 'CoverPage' in the cell at the top left of each page.
