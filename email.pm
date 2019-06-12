
package email;

use strict;
use Carp;

# MailList is a ref to a list of names; msg and subject are strings
sub SendMail {
	my($MailList,$msg,$subject) = @_;
	$msg = "Unspecified Email text " unless $msg;
	$subject = 'Mail ' unless $subject;

	# remove parens from message
	# they make the shell crazy
	$msg =~ s#\(|\)##g;

	# escape dollar signs, as perl tries to interpret them
	$msg =~ s#\$#\\\$#g;

	my($MailCmd);
	-x "/bin/mail" && do {$MailCmd = "/bin/mail "}; 
	-x "/bin/mailx" && do {$MailCmd = "/bin/mailx "}; 
	
	if ( ! defined($MailCmd) ) {
		warn "Mail program unavailable in email.pm\n";
		return;
	}

	my($MailDest);

	foreach $MailDest ( 0..$#$MailList ) {
		if( system("(echo '$msg' | $MailCmd -s '$subject' $MailList->[$MailDest]) 2>&1 1>/dev/null") ) 
			{ carp "failed to email '$msg' to $MailList->[$MailDest] from Email\n" }
	}
}

1;

