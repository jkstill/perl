#!/usr/bin/env perl

use Perl::Critic;

my $file = shift;


$tmpSeverity=shift;

my $severity = $tmpSeverity ? $tmpSeverity : 5;

print "\nWorking on: $file\n\n";

my $critic = Perl::Critic->new( ( -severity => $severity ) );
my @violations = $critic->critique($file);

my $violationCount = @violations;
if ($violationCount) {
	print "\n== Violations ==\n";
	print @violations;
} else {
	print "\nNo Violations Found\n";
}

