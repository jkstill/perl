#!/usr/bin/env perl

# https://stackoverflow.com/questions/2049735/how-can-i-tell-if-a-perl-module-is-core-or-part-of-the-standard-install
#
use strict;
use warnings;

my %_stdmod;

sub is_standard_module {
    my($module) = @_;

    unless (keys %_stdmod) {
    chomp(my $perlmodlib = `perldoc -l perlmodlib`);
    die "cannot locate perlmodlib\n" unless $perlmodlib;

    open my $fh, "<", $perlmodlib
    or die "$0: open $perlmodlib: $!\n";

    while (<$fh>) {
     next unless /^=head\d\s+Pragmatic\s+Modules/ ..  /^=head\d\s+CPAN/;

     if (/^=item\s+(\w+(::\w+)*)/) {
        ++$_stdmod{ lc $1 };
    }
    }
}

    exists $_stdmod{ lc $module } ? $module : ();
}

die "Usage: $0 module..\n" unless @ARGV;

foreach my $mod (@ARGV) {
    my $stdmod = is_standard_module $mod;
    print "$0: $mod is ", ($stdmod ? "" : "not "), "standard\n";
}

