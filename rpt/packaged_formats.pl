#!/usr/bin/perl

=head1 Packaged Formats Demo

This script simply demonstrates how formats can
be used inside of a package.

The important thing to remember is that the namespace
must be identified.  e.g. mf package uses mf::STDOUT.

=cut

use English;
use FileHandle;
use Data::Dumper;

my @data=();

my %formats = (
	COLUMN_FORMATS => {
		OWNER => '@<<<<<<<<<',
		TABLE_NAME => '@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<',
		COLUMN_NAME => '@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<',
	},
);

my $o = new mf(%formats);

open(DATA,"packaged_formats.txt")|| die "cannot open data file - $!\n";

while(<DATA>){
	@data = split(/,/);
	$o->output(\@data);
}

# End of main
package mf;
use English;

use Data::Dumper;

@mf::outdata=();
my $formatBodyName = 'formatbody';

sub new {
	my $pkg = shift;
	my $class = ref($pkg) || $pkg;

	my (%args) = @_;

	formatLine2(\%args);

	bless \%args, $class;

}

sub output {
	my($self, $dataArray) = @_;
	@mf::outdata = @{$dataArray};
	STDOUT->format_name("mf::${formatBodyName}");
	write;
}

sub formatLine2 {

	my ($args, $debug) = @_;

	my $format = "format mf::${formatBodyName} =\n";
	for my $key ( keys %{$args->{COLUMN_FORMATS}}) {
		$format .= $args->{COLUMN_FORMATS}{$key}. " ";
	}
	$format .= "\n" . '@mf::outdata' . "\n" . '.' . "\n";
	$format .= "\n" . '.' . "\n";

	print "Format Line: $format" if $debug;
	eval $format;
}

