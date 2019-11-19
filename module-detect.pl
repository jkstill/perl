#!/usr/bin/env perl

# module-detect.pl
# detect if a module is in use 
# then use or not use the module as needed

use strict;
use warnings;

my %subs=();

#my @modules = ('use Data::Dumper','No::Such::Module');
my %modules = (
	'Dumper' => {
		Name => 'Data::Dumper',
		Action => sub{return Dumper(@_)},
	},

	'NotExist' => {
		Name => 'No::Such::Module',
		Action => sub{return 'should never see this'},
	},

);

foreach my $module (keys %modules){
	
	eval "use " .  $modules{$module}->{Name};
	#print "module: $module\n";

	if($@){
		$module=~/\w+\W(\S+)/;
		$subs{$module}=sub{return "$module is not installed"};
		#$subs{NotExist}=sub{return "$module is not installed"};
	}else{
		no warnings;
		$Data::Dumper::Terse=1;
		use warnings;
		$subs{$module}=$modules{$module}->{Action};
		#$subs{NotExist}=sub{return 'should never see this'};
		;
	}
};

print "Dumping \%modules: " .  $subs{Dumper}(\%modules) . "\n";
print "Dumping \%subs " .  $subs{Dumper}(\%subs) . "\n";

print "NotExist \%modules: " .  $subs{NotExist}(\%modules) . "\n";


