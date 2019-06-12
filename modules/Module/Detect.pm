#!/usr/bin/env perl

# module-detect.pl
# detect if a module is in use 
# then use or not use the module as needed

main() if not caller();

sub main {
	use strict;
	use warnings;
	use Data::Dumper;

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

}

BEGIN {

	package Module::Detect;

	use Exporter qw(import);
	our $VERSION=0.1;
	# export subs as needed
	our @EXPORT = qw();
	our @ISA=qw(Exporter);

	my %subs=();

	sub new {
		my $pkg   = shift;
		my $class = ref($pkg) || $pkg;
		my ($href) = @_;

		my $self = {
			MODULES => $href,
		};

		foreach my $module (keys %{$self->{MODULES}} ) {
	
			eval "use " .  $self->{MODULES}{$module}->{Name};

			if($@){
				$module=~/\w+\W(\S+)/;
				$subs{$module}=sub{return "$module is not installed"};
			}else{
				no warnings;
				$Data::Dumper::Terse=1;
				use warnings;
				$subs{$module}=$self->{MODULES}{$module}->{Action};
				;
			}
		}

		$self->{SUBS} = \%subs;

		my $retval = bless $self, $class;
		return $retval;
	}

	sub getSub {
		my $self = shift;
		my ($subRef) = @_;
		if ( defined ( $self->{SUBS}{$subRef} )  ) {
			return $self->{SUBS}{$subRef};
		} else {
			return sub{return 'sub not defined'};
		}
	}

}

1;


