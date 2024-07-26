#!/usr/bin/env perl
#
use warnings;
use strict;

use lib './lib';

my $n='MyPackage.pm';
my $y='MyPackage';

eval { require $n; $y->import(qw(func_exported func_export_ok get_var)); };

# use MyPackage qw(do_awesome_thing);

print '  fqn: ' . MyPackage::func_exported() . "\n";
print 'local: ' . func_exported() . "\n";
print func_export_ok() . "\n";

# do not export variables
# just use a function to get it
my $z=get_var();
print "var_exported: $z\n";

print "=============================================\n";

$n='NewPackage.pm';
$y='NewPackage';

eval { require $n; $y->import(qw(func_exported_new func_export_ok_new get_var)); };

print '  fqn: ' . NewPackage::func_exported_new() . "\n";
print 'local: ' . func_exported_new() . "\n";
print func_export_ok_new() . "\n";

# do not export variables
# just use a function to get it
$z=get_var();
print "var_exported: $z\n";

