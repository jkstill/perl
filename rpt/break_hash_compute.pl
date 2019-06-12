#!/usr/bin/perl

use lib qw{./};

use Data::Dumper;
use Tie::RPT;

my %data = (

	PRJSTAT => {
		PROJECT_TEAMS	=> { 
			COMMENT_PK => 12,
			PERSON_PK => 12
		}, 
		PROJECT_VIEW	=> { 
			MEMBER_COMMENTS => 30,
			MEMBER_NAME  => 20,
			PROJECT_COMMENTS => 50,
			PROJECT_NAME => 50
		},
		STATUS_HISTORIES	=> { 
			COMMENT_MILESTONE_PK => 12,
			COMMENT_RISK_PK => 12,
			COMMENT_STATUS_PK => 12,
			PERSON_PK => 12,
			PROJECT_PK => 12,
			STATUS  => 1,
			STATUS_DATE => 7,
		},
	},

	SCOTT => {
		AVG_SALARY_VIEW	=> { 
			AVG_SAL_DEPT => 4,
			DEPTNO => 2
		},
		BINCOL_TEST	=> { 
			BINARY_DATA => 2000,
			CLEAR_TEXT => 2000
		},
		BONUS	=> { 
			COMM => 6,
			ENAME => 20,
			JOB => 6,
			SAL => 8
		}
	},

);


#print Dumper(\%data);
#exit;

my %pdata = ();

my $r = new Tie::RPT(
	HASHREF => \%pdata,	# data container
	STH => undef,	# \$sth if using DBI
	# COLUMNS args override $sth if present
	# column names and format field
	COLUMNS => {
		OWNER => '@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<',
		TABLE_NAME => '@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<',
		COLUMN_NAME => '@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<',
		COLUMN_SIZE => '@######.##',
	},
	COLUMN_ORDER => [qw{OWNER TABLE_NAME COLUMN_NAME COLUMN_SIZE}],
	# columns to BREAK on
	BREAK_COLUMNS => [qw{OWNER TABLE_NAME}],
	# compute columns must also be break columns
	COMPUTE_COLUMNS => {
		OWNER => COLUMN_SIZE,
		TABLE_NAME => COLUMN_SIZE,
	},
	PAGESIZE => 60,
	LINESIZE => 100,

);

#print Dumper($r);
#exit;

#$r->formatLine;

foreach my $towner ( keys %data ) {
	$pdata{OWNER}=$towner;
	foreach my $tname ( keys %{$data{$towner}} ) {
		$pdata{TABLE_NAME}=$tname;
		foreach my $col ( keys %{$data{$towner}->{$tname}} ) {
			$pdata{COLUMN_NAME}=$col;
			$pdata{COLUMN_SIZE} = $data{$towner}{$tname}->{$col};

			#if ( $r->breakStatus(TABLE_NAME) ) {
				#print "BREAK on $tname!\n";
			#}

			$r->output(\%pdata);

			#printf "%10s %20s %20s %10d\n", 
				#$pdata{OWNER}
				#, $pdata{TABLE_NAME}
				#, $pdata{COLUMN_NAME}
				#, $pdata{COLUMN_SIZE};
		}
	}
}



