#!/usr/bin/perl

use lib qw{./};

use Data::Dumper;
use Tie::RPT;

my %data = (

	PRJSTAT => {
		PROJECT_TEAMS	=> [qw{ COMMENT_PK  PERSON_PK }], 
		PROJECT_VIEW	=> [qw{ MEMBER_COMMENTS MEMBER_NAME PROJECT_COMMENTS PROJECT_NAME}],
		STATUS_HISTORIES	=> [qw{ COMMENT_MILESTONE_PK COMMENT_RISK_PK COMMENT_STATUS_PK PERSON_PK PROJECT_PK STATUS STATUS_DATE}],
	},

	SCOTT => {
		AVG_SALARY_VIEW	=> [qw{ AVG_SAL_DEPT DEPTNO }],
		BINCOL_TEST	=> [qw{ BINARY_DATA CLEAR_TEXT }],
		BONUS	=> [qw{ COMM ENAME JOB SAL }]
	},

);

my %pdata = ();
my @breaks=qw{ OWNER TABLE_NAME};

my $r = new Tie::RPT(
	HASHREF => \%pdata,	# data container
	STH => undef,	# \$sth if using DBI
	# COLUMNS args override $sth if present
	# column names and format field
	COLUMNS => {
		OWNER => '@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<',
		TABLE_NAME => '@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<',
		COLUMN_NAME => '@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<',
	},
	# columns to BREAK on
	BREAK_COLUMNS => [qw{OWNER TABLE_NAME}],
	COMPUTE_COLUMNS => {
	},
	PAGESIZE => 60,
	LINESIZE => 100,

);

#print Dumper($r);
#exit;

foreach my $towner ( keys %data ) {
	$pdata{OWNER}=$towner;
	foreach my $tname ( keys %{$data{$towner}} ) {
		$pdata{TABLE_NAME}=$tname;
		foreach my $col ( @{$data{$towner}->{$tname}} ) {
			$pdata{COLUMN_NAME}=$col;
			printf "%10s %20s %20s\n", 
				$pdata{OWNER}
				, $pdata{TABLE_NAME}
				, $pdata{COLUMN_NAME};
		}
	}
}


