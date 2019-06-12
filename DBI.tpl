#!/home/oracle/perl -w

use strict;
no strict qw(refs vars);
use OraEnv;
use email;

# set these according to environment ( home, work )

# HOME
#$MailDomain='localhost';
# dba repository
#$DBAREP='ts99';

use Getopt::Long;

my($result) = Getopt::Long::GetOptions(
	"username=s",
	"instance=s",
	"debug",	
	"z","h","help"
);

# GetOpt returns a zero on error or lack of args
if ( ( ! $result ) || ($opt_help or $opt_z or $opt_h ) ) { &Usage;exit 1 }
if ( ! $opt_username or ! $opt_instance ) { &Usage;exit 1 }

# tell -w to shut up
$opt_z = $opt_z;
$opt_h = $opt_h;
$opt_help = $opt_help;
$opt_debug = $opt_debug;
$opt_username = $opt_username;
$opt_instance = $opt_instance;
	

# set the environment before loading DBI as it needs TNS_ADMIN
OraEnv::SetEnv($opt_instance);

use DBI;

# do not mail passwords unless the passwords are generated
$opt_mailpassword = 0 unless $opt_mailpassword;
$opt_gen_passwords = 0 unless $opt_gen_passwords;
$opt_mailpassword = $opt_mailpassword & $opt_gen_passwords;

# flush buffer for every write
$|=1;

$DEBUG=$opt_debug;
$DEBUG=$DEBUG;

$Password = OraEnv::GetPassWord($opt_instance,$opt_username);

$UserSQL = qq{ select username, default_tablespace from dba_users };

my $dbh = DBI->connect( 
	'dbi:Oracle:'.$opt_instance, 
	$opt_username, 
	$Password, 
	{ RaiseError => 1, AutoCommit => 0 }
) || die "Database connection not made: $DBI::errstr";

my $sth = $dbh->prepare( $UserSQL );

$sth->bind_columns( undef, \($Username,$Tablespace) );
$sth->execute();

while ( $sth->fetch ) {
	print "USER: $Username  DEF TBS: $Tablespace \n";
}

$dbh->disconnect();

sub Usage {
print <<EOF

DBI.tpl - template for DBI scripts
usage :
   -username         : dba username ( must be in password files )
   -instance         : create in which instance?
   -debug            : debug mode - just prints output
   -help             : show this message

EOF

}


