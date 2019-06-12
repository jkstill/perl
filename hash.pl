#!/usr/bin/env perl
#

use strict;
use warnings;

use Data::Dumper;
$Data::Dumper::Terse=1;

print "\n== Hash\n";

my %hash=(
	0 => 'zero',
	1 => 'one',
	2 => 'two',
	3 => 'three',
	4 => 'four',
);

print 'Value pointed to by $hash{2}: ', $hash{2}, "\n\n";
print Dumper(\%hash);

print "\n== Hash Ref (reference - address of)\n";

my $hashRef=\%hash;

print 'Value pointed to by $hashRef->{2}: ', $hashRef->{2}, "\n\n";
print Dumper($hashRef);

print "\n== more complex Hash - array references stored as the values\n";

my %cHash = (
	# operating systems
	OS => [
		'Linux',
		'DG/UX',
		'HP/UX',
		'AIX',
		'Minix',
		'Windows',
	],

	# databases 
	DB => [
		'Oracle',
		'MySQL',
		'PostgreSQL',
		'SQL Server',
		'Informix',
		'MariaDB',
	],

);

print 'The second OS appears as $cHash{OS}->[1]: ',  $cHash{OS}->[1], "\n";

print 'The fourth DB appears as $cHash{DB}->[3]: ',  $cHash{DB}->[3], "\n\n";

print Dumper(\%cHash);

print "\n== more complex Hash as  Hash Ref \n";

my $cHashRef = \%cHash;

print 'The second OS appears as $cHash{OS}->[1]: ',  $cHash{OS}->[1], "\n";

print 'The fourth DB appears as $cHash{DB}->[3]: ',  $cHash{DB}->[3], "\n\n";

print Dumper(\%cHash);


