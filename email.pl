#!/usr/bin/perl  -w

=head1 email.pl - generic email script

  email.pl is a generic email script that relies
  on a minimum of modules.  

  Mail::Sendmail must be installed for it to work

  The only required configuration is to set the name
  of the SMTP server at the top of the script. The
  variable is "$smtp", should be easy to spot.

  Two command line arguments are always required.

  -to   < recipient >
  -from < sender >

  optional:

  -message_file < file containing email message >
  -subject "subject in quotes"

  -subject will default to "Default Subject" if not
  specified on the command line

  -message_file defaults to STDIN if a filename is
  is not specified on the command line.
  

  Mail can be sent a variety of ways.

  email.pl -subject "Electronic Funds Transfer Notification \
    -from us@radisys.com \
    -to you@somewhereelse.com \
    -message_file /tmp/eft243.txt

  email.pl -subject "EFT Notice" -from me@here.com -to you@there.com < /tmp/eft243.txt

=cut

use warnings;
use Mail::Sendmail;

my $smtp = 'mail.radisys.com';

# getopt usages
# ':' indicates optional arguments
# '=' indicates mandatory arguments
#		i = integer
#		n = integer
# 		f = fixed ( real ) numbers
# 		s = string
#		@ = array

# example getopt args:  -instance dv05 -username scott -debug
#
use Getopt::Long;

%optctl = ();

GetOptions(\%optctl
	, "from=s"
	, "to=s"
	, "subject=s"
	, "message_file=s"
	, "debug!"
	, "help!"
);


my ($from, $to, $subject, $message_file, $debug, $help ) ;
{
	no warnings;
	($from, $to, $subject, $message_file, $debug, $help ) = (
		$optctl{from}
		, $optctl{to}
		, $optctl{subject}
		, $optctl{message_file}
		, defined($optctl{debug}) ? 1 : 0
		, defined($optctl{help}) ? 1 : 0
	);
};

usage(0) if $help;

if ($debug) {

print qq{
FROM    : $from
TO      : $to
SUBJECT : $subject
DEBUG   : $debug

};
	exit;
};

if (! defined($to) ) {
	warn "Please use -to <recipient address> \n";
	usage(1);
}

if (! defined($from) ) {
	warn "Please use -from <sender address> \n";
	usage(2);
}


# read from stdin if file name not supplied

my @msg;
if ( defined($message_file)) {
	open(MSG,"$message_file") || die "cannot open file $message_file - $!\n";
	@msg = <MSG>;
} else {
	@msg = <STDIN>;
}

my $msg = join('',@msg);


$subject = "Default Subject" unless $subject;


my %mail = (
	To => $to
	, From => $from
	, Subject => $subject
	, Message =>  $msg
	, smtp => $smtp
);

unless ( sendmail(%mail) ) {
	warn "$Mail::Sendmail::error - $@\n";
	exit 1;
}

sub usage {

	my $exitVal = shift;
	use File::Basename;
	my $basename = basename($0);
	print qq/

usage: $basename

  -to           recipient's address 
  -from         senders address
  -debug        print cmd line options and exit
  -subject      email subject - defaults to "Default Subject"
  -message_file file to read text from - defaults to STDIN

  use 'perldoc email.pl' to seem examples

/;

exit $exitVal;

}

