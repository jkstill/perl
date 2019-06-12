#!/u01/app/perl/bin/perl -w

## !!! Update for Excel::Writer::XLSX

use warnings;
use strict;
use Getopt::Long;
use PDBA;
use PDBA::CM;
use PDBA::GQ;
use PDBA::OPT;
#use Data::Dumper;
use Spreadsheet::WriteExcel::Big;

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

my( $database, $username, $connectionMode);

if (
	$optctl{h} 
	|| $optctl{z}
	|| $optctl{help}
) {
	Usage(0);
}

my $xlFile = defined($optctl{spreadsheet_file}) ? $optctl{spreadsheet_file} : 'product_revs_max.xls';

$connectionMode = '';
if ( $optctl{sysoper} ) { $connectionMode = 'SYSOPER' }
if ( $optctl{sysdba} ) { $connectionMode = 'SYSDBA' }

if ( ! defined($optctl{username}) ) {
	Usage(2);
	die "username required\n";
}
if ( ! defined($optctl{database}) ) {
	Usage(3);
	die "database required\n";
}

$username=$optctl{username};
$database=$optctl{database};

my $currentDate = localtime;

my $workBook;
my %workSheets = ();

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
my $password = '';
if ( defined( $optctl{password} ) ) {
	$password = $optctl{password};
} else {

	# username, machine and database will go to default
	# values loaded in PDBA::OPT from pwc.conf if 
	# the command line values are null

	$password = PDBA::OPT->pwcOptions (
		INSTANCE => $database,
		MACHINE => $optctl{machine},
		USERNAME => $optctl{username}
	);
}

my $dbh = new PDBA::CM(
	DATABASE => $database,
	USERNAME => $optctl{username},
	PASSWORD => $password,
);

# apparently not a database handle attribute
# but IS a prepare handle attribute
#$dbh->{ora_check_sql} = 0;
$dbh->{RowCacheSize} = 100;

$dbh->do(q{alter session set nls_date_format='mm/dd/yyyy'},{ora_check_sql => 0});

# create workbook
$workBook  = Spreadsheet::WriteExcel::Big->new(qq{${database}_${xlFile}});
die "Problems creating new Excel file ${database}_${xlFile}: $!\n" unless defined $workBook;

# create formats
my $stdFormat = $workBook->addformat(bold => 0,font => $fonts{fixed}, size => $fontSizes{fixed}, color => 'black');
my $boldFormat = $workBook->addformat(bold => 1,font => $fonts{fixed_bold}, size => $fontSizes{fixed_bold}, color => 'black');
my $hdrFormat = $workBook->addformat(bold => 1,font => $fonts{fixed_bold}, size => $fontSizes{fixed_bold}, color => 'white', bg_color => 'blue');
my $wrapFormat = $workBook->addformat(bold => 0,font => $fonts{text}, size => $fontSizes{text}, color => 'black');
$wrapFormat->set_align('vjustify');

# add the work sheet

my $sheetName='AML';

$workSheets{$sheetName} = $workBook->addworksheet($sheetName);

my $xlsSql = q{
select i.item_cde, i.item_dsc, max(ir.item_rev) item_rev
from item i
join item_revision ir on ir.item_cde = i.item_cde
where i.item_type = 'PRODUCT'
and i.mat_type = 'PRODUCT CODE'
group by i.item_cde, i.item_dsc
order by i.item_cde
};

my $sth = $dbh->prepare($xlsSql);
$sth->execute;

# setup column widths
my @precision = @{$sth->{PRECISION}};
# get scale - deal with undefs
my @scale = map { defined($_) ? $_ : 0 } @{$sth->{SCALE}};
foreach my $el ( 0..$#precision ) {
	my $colWidth = $precision[$el]+$scale[$el] > $maxColWidth 
		? $maxColWidth 
		: $precision[$el]+$scale[$el];
	$workSheets{$sheetName}->set_column($el,$el,$colWidth);
}

my %roleLineCount=();

# get column names from DBI
my @colNames = @{$sth->{NAME_uc}};
$workSheets{$sheetName}->write_row($roleLineCount{$sheetName}++,0,\@colNames,$hdrFormat);

# freeze pane at header
#$workSheets{$sheetName}->freeze_panes($roleLineCount{$sheetName},0);
$workSheets{$sheetName}->freeze_panes('B2');

while( my $rolePrivs = $sth->fetchrow_arrayref ) {
	$workSheets{$sheetName}->write_row($roleLineCount{$sheetName},0,$rolePrivs,
		$stdFormat
	);
	if ($rolePrivs->[0] eq 'ROLE' ) {
		$workSheets{$sheetName}->write($roleLineCount{$sheetName},1,
			"internal:" . $rolePrivs->[1] . "!A1", $rolePrivs->[1]
		);
	}
	$roleLineCount{$sheetName}++;
}

$dbh->disconnect;


sub Usage {
	my $exitval = shift;
	use File::Basename;
	my $basename = basename($0);

	print qq{

usage: $basename  Oracle System Account Lister 

-machine             database server
-database            target database
-username            DBA account
-password            account password
                     use one of the following options
                     to connect as SYSOPER or SYSDBA

                     [-sysdba || -sysoper]

-spreadsheet_file   Name of spreadsheet file to create. Defaults to roles.xls

};

	exit $exitval;

}

