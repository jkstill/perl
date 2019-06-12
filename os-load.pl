local %SIG=%SIG;
my $connectAttr;

BEGIN {
   our $SIGPreserve='manual';

   # ensure DBD::Oracle is available
   eval "require DBD::Oracle" or die "DBD::Oracle not found\n";
	use DBD::Oracle qw(:ora_session_modes);
	# modes: ORA_SYSDBA ORA_SYSOPER ORA_SYSASM ORA_SYSBACKUP ORA_SYSDG ORA_SYSKM

   my $DBDVersion = $DBD::Oracle::VERSION;
   $connectAttr = {
      RaiseError => 1,
      AutoCommit => 0,
      ora_session_mode => 0,
   };
   print "DBD::Oracle Version: $DBDVersion\n";
   if ($DBD::Oracle::VERSION + 0 >= 1.28) {
      print "Setting Signal Preserve to 'auto'\n";
      $SIGPreserve='auto';
      $connectAttr->{ora_connect_with_default_signals} =  [ 'INT' ] ;
   } else {
      print "Leaving Signal Preserve as $SIGPreserve\n";
   }
}

use warnings;
use FileHandle;
use DBI;
use strict;
use Time::HiRes qw{usleep};

my $dbh = DBI->connect(
   'dbi:Oracle:oravm',
   'jkstill', 'XXXX',
   $connectAttr
   );

die "Connect failed \n" unless $dbh;

# apparently not a database handle attribute
# but IS a prepare handle attribute
#$dbh->{ora_check_sql} = 0;
$dbh->{RowCacheSize} = 100;

my $sql=q{select 
   to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') current_time
   , to_char(begin_time,'yyyy-mm-dd hh24:mi:ss') begin_time
   ,round(value,2) OS_LOad
from v$sysmetric
where metric_name =  'Current OS Load'};

my $sth = $dbh->prepare($sql,{ora_check_sql => 0});

$|++;

my $prevSecond=-1;
my $currSecond=-2;
my $sleepTime=30;

print "DB: $ENV{ORACLE_SID}\n";

while (1) {

   if ($prevSecond == $currSecond) { next }

   $sth->execute;

   my $ary = $sth->fetchrow_arrayref;
   print join(' ', @{$ary}),"\n";
   $sth->finish;

   while( 1) {
      ($currSecond) = localtime;
      last if not $currSecond%$sleepTime;
      usleep(250000);
   }

   
} continue {
   ($prevSecond) = localtime;
}

$dbh->disconnect;
