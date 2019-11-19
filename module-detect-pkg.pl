#!/usr/bin/env perl

# module-detect.pl
# detect if a module is in use 
# then use or not use the module as needed


use strict;
use warnings;
use Data::Dumper;

#use lib './modules';
use Module::Detect;

my $m = Module::Detect->new(
	{
		'Dumper' => {
			Name => 'Data::Dumper',
			Action => sub{return Dumper(@_)},
		},

		'NotExist' => {
			Name => 'No::Such::Module',
			Action => sub{return 'should never see this'},
		}
	}
);


#print Dumper($m);

my $dumper = $m->getSub('Dumper');
my $notExist = $m->getSub('NotExist');
my $notDefined = $m->getSub('NotDefined');

print 'Dumping $m: ' . &$dumper($m) . "\n";
print 'NotExist function -  $m: ' . &$notExist($m) . "\n";
print 'NotDefined function -  $m: ' . &$notDefined($m) . "\n";

