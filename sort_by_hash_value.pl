#!/usr/bin/perl

# test sorting by a value in hash

use Data::Dumper;


print "\n\nsimple example\n\n";

my %columns = (
	c1 => 'D',
	c2 => 'X',
	c3 => 'B',
	c4 => 'J',
);

print '%columns ', Dumper(\%columns),"\n";

foreach my $col ( sort { $columns{$a} cmp $columns{$b} } keys %columns) {
	print "Column $col - $columns{$col}\n";
}

print "\n\nmore complex example\n\n";

my %tables = (
	customer => {
		order => 2,
		create => 'create table customer',
	},

	product => {
		order => 1,
		create => 'create table product',
	},

	manufacturer => {
		order => 0,
		create => 'create table manufacturer',
	}
);

print '%tables: ', Dumper(\%tables),"\n";

foreach my $table ( sort { $tables{$a}->{order} <=> $tables{$b}->{order} } keys %tables) {
	print "order : $tables{$table}->{order} table: $table \n";
}




