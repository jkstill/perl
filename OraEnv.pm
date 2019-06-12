
######################################
# use this package to setup your 
# Oracle environment from within your
# Perl scripts.
# Please see README.OraEnv for details
######################################
# Jared Still
# jkstill@teleport.com
# www.teleport.com/~jkstill/util
######################################

package OraEnv;
use Carp;
use strict;

#####################################
# DO NOT MODIFY THESE VARIABLES!!!
# modify the OraEnv.conf file instead
##################################


# the instance list is a file that points to which server
# each instance is on
# file format: INSTANCE:VERSION:SERVER
# e.g.   db01:7.3.3:aslan

$OraEnv::INSTANCE_LIST =  '/opt/share/oracle/sql/instance.list';
$OraEnv::DBA_MAIL_LIST =  '/opt/share/oracle/lib/dba_mail_list.txt';

# the password file is setup for each user that will use OraEnv.pm
# it is located in a directory of $PASSWORD_FILE_BASE_PATH/username/$PASSWORD_FILE_NAME_PREFIX.username
# with the current settings my password file would be:
#    /opt/share/oracle/jkstill/.oracle.ids.jkstill
# file format:  INSTANCE:USERNAME:PASSWORD
# these files should of course be readable only by the owner
$OraEnv::PASSWORD_FILE_BASE_PATH = '/opt/share/oracle' ;
$OraEnv::PASSWORD_FILE_NAME_PREFIX = '.oracle.ids.';

# stuff the possible locations of the oratab file into 
# an array
# if you have more than one oratab file ( don't laugh, we
# use a master oratab file for client connections ) then
# the first record found for an instance is the one used
@OraEnv::ORA_TAB_FILES = (
	'/var/opt/oracle/oratab',
	'/etc/oratab',
	'/opt/share/oracle/lib/oratab'
);

# we use a distinct ORACLE_HOME on each server for the
# TNS_ADMIN directory, regardless of version of Oracle
# This is accomplished by having an alias in the oratab.
# file call 'onet' that points the the ORACLE_HOME we
# wish to use for TNS_ADMIN.
# Leave this variable set to 1 if you want to do this,
# else change it to 0 to set your TNS_ADMIN to 
# ORACLE_HOME/NETWORK_ADMIN

$OraEnv::USE_ONET=1;
$OraEnv::NETWORK_ADMIN='/network/admin';

# this is the base path for your LD_LIBRARY_PATH
$OraEnv::BASE_LD_LIBRARY_PATH = '/usr/openwin/lib:/opt/local/lib:/opt/local/lib/X11:/opt/local/x11r5/lib:';

$OraEnv::DEBUG= 0;

# read master configuration file
# then read user configuration file
# ( neither are required )
do "OraEnv.conf";
do "$ENV{HOME}/OraEnv.conf";

##################################
# END OF CONFIGURATION
##################################

sub SetInstanceListName {
	return $OraEnv::INSTANCE_LIST;
}

sub SetDbaMailListName {
	return $OraEnv::DBA_MAIL_LIST;
}

# returns a reference to a ref to array
# must pass a ref to an array
# pass a second parameter of 'ALL', ( or anything for that matter, it just
# import that the second parameter exists ), and the entire line from the
# instance list will be put into the hash or array, otherwise don't
# use a second parameter

sub GetInstanceList {

	my($reference,$mode) = @_;
	my $reftype = ref($reference);

	$reftype eq ''  && do {
		carp "A REFERENCE to an ARRAY or HASH must be passed to OraEnv::GetInstanceList!\n";
		return '';
	};


	open (INSTANCE, &SetInstanceListName) || do {
		carp "Unable to open " . &SetInstanceListName . "! - $!\n";
		return 0;
	};

	while(<INSTANCE>){

		# skip comments and test instances
		next if /^#/;
		next if /^ts/;

		chomp;

		my($instance,$version,$server) = split(/:/);

		$reftype =~ /ARRAY/ && do {
			if ($mode) { push(@$reference,$_) } 
			else { push(@$reference,$instance) }
		};

		$reftype =~ /HASH/ && do {
			if ($mode) { $$reference{$instance} = $_ }
			else { $$reference{$instance} = $server }
		};

	}

}

sub GetDbaMailList {

	my($reference) = @_;
	my $reftype = ref($reference);

	$reftype eq ''  && do {
		carp "A REFERENCE to an ARRAY or HASH must be passed to OraEnv::GetDbaMailList!\n";
		return '';
	};


	open (MAILLIST, &SetDbaMailListName) || do {
		carp "Unable to open " . &SetDbaMailListName . "! - $!\n";
		return 0;
	};

	# only one valid line in file
	while(<MAILLIST>){

		# skip comments and test instances
		next if /^#/;
		next if /^$/;

		chomp;

		my($instance,$version,$server) = split(/:/);

		$reftype =~ /ARRAY/ && do {
			@$reference=split(/\s/);
		};

		$reftype =~ /HASH/ && do {
			%$reference=split(/\s/);
		};

	}

}

sub GetPassWord {

	my($instance) = shift || croak "OraEnv::GetPassWord needs the instance name\n";
	my($username) = shift || croak "OraEnv::GetPassWord needs the username\n";

	my($PassWord, $dummy, $PassStr, $PassReturn);

	$PassReturn = OraEnv::GetPassWordFileData($username);

	($PassStr) = grep(/$instance/, @$PassReturn);
	($dummy,$dummy,$PassWord) = split(/:/,$PassStr);

	$PassWord;

}


sub GetPassWordFileData {

	my($username) = shift || croak "OraEnv::GetPassWordFileData needs the username\n";

	my(@PassData, $PassWordFile);

	$PassWordFile = $OraEnv::PASSWORD_FILE_BASE_PATH . '/' . $username . '/' . $OraEnv::PASSWORD_FILE_NAME_PREFIX . $username;
	open(PASSWD,$PassWordFile ) || die "cannot open password file 'FILE: $PassWordFile' - $! \n";

	@PassData=<PASSWD>;
	close(PASSWD);
	\@PassData;

}

sub OraTabFileData {

	my($FoundFile) = 0;
	my(@OraTabData, @OraTabTmpData );

	my($file);
	foreach $file ( @OraEnv::ORA_TAB_FILES ) {
		open(ORATAB,$file) && do {
			$FoundFile = 1;
			@OraTabTmpData = <ORATAB>;
			close(ORATAB);
		};
		push(@OraTabData, @OraTabTmpData);
	}

	\@OraTabData;

}

# set the ORACLE_HOME, ORACLE_SID, and TNS_ADMIN ( for bcbso )
# this function may potentially read 3 files, and may come up
# with 3 values for any setting.  Always take the first one,
# as the files are read in order of precedence
#
# the values in %ENV are modified
#
sub SetEnv {

	my($instance) = shift || croak "OraEnv::SetEnv needs the instance name\n";

	my($OraTabAarrayRef) = OraEnv::OraTabFileData;

	my(@OracleHome, $dummy);
	
	(@OracleHome) = grep(/^${instance}/, @$OraTabAarrayRef);

	carp "Instance $instance not found in Oratab files\n" unless defined($OracleHome[0]);

	$ENV{'ORACLE_SID'} = $instance;
	($dummy, $ENV{'ORACLE_HOME'}) = split(/:/, $OracleHome[0]);

	my(@PathElements)=split(/\//, $ENV{'ORACLE_HOME'});
	shift @PathElements;

	$ENV{ORACLE_BASE}='';
	# ORACLE_BASE is 2 dirs above ORACLE_HOME
	for my $key ( 0 .. ( $#PathElements - 2 ) ) {
		#print "$key: $o[$key] \n";
		$ENV{ORACLE_BASE} = $ENV{ORACLE_BASE} . '/' . $PathElements[$key];
	}

	if ( $OraEnv::USE_ONET ) { 
		my $dummy;
		my(@TnsAdmin) = grep(/^onet/, @$OraTabAarrayRef);
		carp "Instance TNS_ADMIN not found in Oratab files\n" unless defined($TnsAdmin[0]);
		($dummy, $ENV{'TNS_ADMIN'}) = split(/:/, $TnsAdmin[0]);
		$ENV{'TNS_ADMIN'} = $ENV{'TNS_ADMIN'} . $OraEnv::NETWORK_ADMIN 
	}
	else { $ENV{'TNS_ADMIN'} = $ENV{'ORACLE_HOME'} . $OraEnv::NETWORK_ADMIN }

	chomp($ENV{'TNS_ADMIN'});
	chomp($ENV{'ORACLE_HOME'});
	chomp($ENV{'ORACLE_SID'});

	$ENV{'LD_LIBRARY_PATH'} = 
		$OraEnv::BASE_LD_LIBRARY_PATH .  "$ENV{'ORACLE_HOME'}/lib:$ENV{'ORACLE_HOME'}/precomp/lib:";

}

sub Debugging {
	return $OraEnv::DEBUG;
}

sub DebugOn {
	$OraEnv::DEBUG = 1;
}

sub DebugOff {
	$OraEnv::DEBUG = 0;
}

sub ShowConfParms {

	if (OraEnv::Debugging()) {
		print "INSTANCE_LIST: $OraEnv::INSTANCE_LIST\n";
		print "PASSWORD_FILE_BASE_PATH: $OraEnv::PASSWORD_FILE_BASE_PATH\n";
		print "PASSWORD_FILE_NAME_PREFIX: $OraEnv::PASSWORD_FILE_NAME_PREFIX\n";
		print "ORA_TAB_FILES: @OraEnv::ORA_TAB_FILES\n";
		print "USE_ONET: $OraEnv::USE_ONET\n";
		print "NETWORK_ADMIN: $OraEnv::NETWORK_ADMIN\n";
		print "BASE_LD_LIBRARY_PATH: $OraEnv::BASE_LD_LIBRARY_PATH\n";

	}

}
1;


