#!/home/oracle/perl -w

# disou.pl
# options:
# -script : the name of a package that contains a 
# sub called 'query' that will be executed
# the file name and package name must match.  the 
# extension on the filename must be '.pm'.
#
# eg:  the package name 'userchk' would be in the
#      file 'userchk.pm'
# the @INC array must know where to find the package
# see 'userchk.pm' for an example

BEGIN { 
	unshift(@INC, ("/home/jkstill/perl", "/home/jkstill/perl/disou") ) ;

}

use OraEnv;
use DBI;
use email;

use Getopt::Long;

my($result) = Getopt::Long::GetOptions("script=s","no-mail","z","h","help");

# GetOpt returns a zero on error
if ( ( ! $result ) || ($opt_help or $opt_z or $opt_h ) ) { &main::Usage;exit }

# tell -w to shut up
$opt_z = $opt_z;
$opt_h = $opt_h;
$opt_help = $opt_help;
$opt_no_mail = $opt_no_mail;

#print "script = $opt_script \n";
#print join(' - ', @ARGV),"\n";

if ( $opt_script) { loadpkg($opt_script . '.pm') }

local($Driver)='Oracle';

$rc='';
$PASSWORD='';
$USERNAME='system';

@DBA=('jkstill@bcbso.com');

@Instances=();
if ( @ARGV ) { @Instances = @ARGV }
else { OraEnv::GetInstanceList(\@Instances) }


for $Instance ( @Instances ) {

	#print "Instance: $Instance\n";
	OraEnv::SetEnv($Instance);

	$PASSWORD=OraEnv::GetPassWord($Instance,$USERNAME);
	if ( ! $PASSWORD ) {
		warn "Password not found for user '$USERNAME' on instance '$Instance'\n";
		next;
	}

	local($dbh) = DBI->connect($Instance,'system',$PASSWORD,$Driver) || do {
		NotifyDbDown($Instance, $Instance . ' - ' . $DBI::errstr);
		warn "$Instance\: Error - $DBI::errstr\n";
		next;
	};

	if ( $DBI::errstr ) {
		NotifyDbDown($Instance, $Instance . ' - ' . $DBI::errstr);
		warn "$Instance\: Error 2 - $DBI::errstr\n";
		next;
	}

	if ( $dbh ) { 
		print "$Instance\:OK\n" unless $opt_script;

		if ( $opt_script ) { 
			#print "In opt_script check\n";
			#print "OPT SCRIPT: $opt_script\n";
			eval "use  $opt_script;";
			eval "${opt_script}::query()";
		}

		$rc = $dbh->disconnect;
	}
	else { warn "Instance\: DBI error connecting to $Instance: $DBI::errstr\n"}
	
	
}


sub NotifyDbDown {
	die unless ($#_ eq 1);
	my($db, $message) = @_;

	email::SendMail(\@DBA,"$db - problem with database!!",$message)
		unless $main::opt_no_mail;

}


sub Usage {
	print "disou.pl [-no-mail] [-script <script name> ] [instance names]\n";
}

sub loadpkg
{
	my($package) = $_[0];
	my($usecmd ) = 'use ' . $package;
	eval $usecmd;
}



