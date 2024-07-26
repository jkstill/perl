#!/usr/bin/env perl

# pathfinder.pl
# different than old pathfinder script
# PATH is input on command line

use strict;
use File::Find ();

=head1 pathfinder.pl

 Given a PATH or PATH like variable, find the file or files that match the search expression

 Some examples:

 Find backups.sh in $PATH

 >  pathfinder.pl backups.sh $PATH
 Dir: /home/jkstill/perl5/bin
 Dir: /home/jkstill/.nvm/versions/node/v6.3.1/bin
 Dir: /opt/perlbrew/perl5/perlbrew/bin
 Dir: /opt/perlbrew/perl5/perlbrew/perls/perl-5.24.0/bin
 Dir: /usr/local/sbin
 Dir: /usr/local/bin
   /usr/local/bin/backups.sh
 Dir: /usr/sbin
 Dir: /usr/bin
 Dir: /sbin
 Dir: /bin
 Dir: /usr/games
 Dir: /snap/bin
 Dir: /home/jkstill/.local/bin
 Dir: /home/jkstill/bin
 Dir: /home/jkstill/perl
 Dir: /u01/app/oracle/product/12.1.0/c12/bin

 The file backups.sh was found in /usr/local/bin

 Find all SQL scripts with 'part' in the name

  >  pathfinder.pl ".*part.*\.sql" $SQLPATH
 Dir: /home/jkstill/oracle/oracle-script-lib/sql
   /home/jkstill/oracle/oracle-script-lib/sql/partstats.sql
   /home/jkstill/oracle/oracle-script-lib/sql/asm_partners.sql
   /home/jkstill/oracle/oracle-script-lib/sql/partstats_sum.sql
 Dir: /home/jkstill/oracle/dba/rman/performance/all_sql
 Dir: /home/jkstill/oracle/admin/sql
   /home/jkstill/oracle/admin/sql/tabparts.sql
   /home/jkstill/oracle/admin/sql/partstats.sql
   /home/jkstill/oracle/admin/sql/showparts.sql
   /home/jkstill/oracle/admin/sql/partstats_sum.sql
   /home/jkstill/oracle/admin/sql/idxparts.sql
   /home/jkstill/oracle/admin/sql/parts.sql

 Several were found

 The regular expression used was for the Perl script, and so must adhere to those rules.

 Using a regular expression as you might for a shell will not work here:

 >  pathfinder.pl \*part*\sql $SQLPATH
  Dir: /home/jkstill/oracle/oracle-script-lib/sql
  Dir: /home/jkstill/oracle/dba/rman/performance/all_sql
  Dir: /home/jkstill/oracle/admin/sql

=cut 

our $file2find=$ARGV[0];
die "please provide filename\n" unless $file2find;
my $PATH=$ARGV[1];
die "please provide PATH\n" unless $PATH;

# Set the variable $File::Find::dont_use_nlink if you're using AFS,
# since AFS cheats.

# for the convenience of &wanted calls, including -eval statements:
use vars qw/*name *dir *prune/;
*name   = *File::Find::name;
*dir    = *File::Find::dir;
*prune  = *File::Find::prune;

sub wanted;

my @paths=split(/:/,$PATH);

foreach my $path (@paths) {
	print "Dir: $path\n";
	# Traverse desired filesystems
	File::Find::find({wanted => \&wanted}, $path)
}

exit;

sub wanted {
	/.*$file2find.*/s
		&& print("  $name\n");
}

