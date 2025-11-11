#!/usr/bin/env perl

# this is a simple script to use scp to retrieve files from a remote server
# that is all it does
# password authentication is not supported
# key based authentication is required

use strict;
use warnings;
use Carp;

use Getopt::Long;

my $remoteUser = '';
my $remoteHost = '';
my $remotePath = '';
my $localPath  = '';	
my $keyFile	= '';

my %optctl = ();

GetOptions(\%optctl,
	'remote-user=s' => \$remoteUser,
	'remote-host=s' => \$remoteHost,
	'remote-path=s' => \$remotePath,
	'local-path=s'  => \$localPath,
	'key-file=s'    => \$keyFile,
	'help|h',
) or croak "Error in command line arguments";

if ($optctl{help}) {
	usage(0);
}

usage(1) unless $remoteUser && $remoteHost && $remotePath && $localPath;

# demonstrate usage of Net::SCP module

my $scp = Net::SCP->new();

eval {
	$scp->scp_get($remoteUser, $remoteHost, $remotePath, $localPath, $keyFile);
	print "File copied successfully from ${remoteUser}\@${remoteHost}:${remotePath} to ${localPath}\n";
};

if ($@) {
	croak "\nError during scp_get:\n $@\n\n";
}

## end of main script ##

sub usage {
	print "Usage: $0 --remote-user USER --remote-host HOST --remote-path /path/to/remote/file --local-path /path/to/local/destination [--key-file /path/to/private/key]\n";
	exit $_[0];
}


BEGIN {
package Net::SCP;
use Carp;
use strict;
use warnings;

use Data::Dumper;
$Data::Dumper::Indent=2; # 1= more compact indentation, 2=default
$Data::Dumper::Sortkeys=1; # sorted hash keys handier for consistency
$Data::Dumper::Maxrecurse=3;
$Data::Dumper::Maxdepth=3;
$Data::Dumper::Terse=0;

use Exporter qw(import);
our $VERSION=0.1;
our @EXPORT = qw(scp_get);
our @ISA=qw(Exporter);

# locate the scp binary
sub locate_binary {
	my $self=shift;
	my $filename=shift;
	my $whichBinary = '';;

	# Get the PATH environment variable
	my $path = $ENV{PATH};

	my @pathDirs = split /:/, $path; # Use ';' for Windows

	foreach my $dir (@pathDirs) {
		my $fullPath = "$dir/$filename";

		# Check if the file exists at this full path
		if (-e $fullPath) {
			$whichBinary = $fullPath;
			last; # Stop searching once found
		}
	}

	unless ($whichBinary) {
    	print "File '$filename' not found in PATH.\n";
		croak "locate_binary: $filename not found in PATH";
	}

	$self->{${filename}.'_binary'}=$whichBinary;

	return $self;
}

sub new {
  my $class=shift;
  my $self={};
  $self=locate_binary($self,'scp');
  bless $self, $class;
  return $self;
}

sub scp_get {
  my ($self, $remoteUser, $remoteHost, $remotePath, $localPath,$keyFile)=@_;
  croak "scp_get: missing arguments" unless defined $remoteUser && defined $remoteHost && defined $remotePath && defined $localPath;

  my $scpCmd="$self->{scp_binary} ";
  $scpCmd .= " -B "; # batch mode, no password prompts
  $scpCmd .= " -i ${keyFile} " if defined $keyFile && $keyFile ne '';
  $scpCmd .= " ${remoteUser}\@${remoteHost}:${remotePath} ${localPath}";
  print "Executing: $scpCmd\n";
  my $result=system($scpCmd);
  if ($result != 0) {
	 croak "scp_get: scp command failed with exit code ".($result >> 8);
  }
  return 1;
}
1;
}
1;

