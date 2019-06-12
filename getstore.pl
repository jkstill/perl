#!/home/oracle/perl -Tw

use strict;
$|++;

use LWP::Simple;
use HTTP::Status;

my $WHERE = "http://www.oracle.com/openworld/white_papers";
chdir "/orawork/zips/papers" or die "chdir: $!";

my $FIRSTTIME = 0;              # ignore "not modified" errors

for ( my $paper=700; $paper<711; $paper++ ) {
  my $name = $paper . '.pdf';
  warn "fetching $name\n";
  my $rc = getstore("$WHERE/$name", $name);
  next if $rc == RC_OK;
  if ($rc == RC_NOT_FOUND) {
    warn "$name: not found\n";
  } else {
    warn "$name: Unexpected error: ", status_message($rc), " ($rc)\n";
  }
}
