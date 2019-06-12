#!/usr/bin/perl


use lib q{./};

use RPT;
use Data::Dumper;

%data = (

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

#print Dumper(\%data);

my($owner, $tableName, $columnName)=('','','');

my $b1 = new RPT; 
$b1->break(\$owner);
$b1->break(\$tableName);

foreach my $towner ( keys %data ) {
	foreach my $tname ( keys %{$data{$towner}} ) {
		#print "\tTABLE: $tableName\n";
		foreach my $col ( @{$data{$towner}->{$tname}} ) {
			$owner = $towner;
			$tableName = $tname;
			$columnName = $col;
			printf "%15s %30s %30s\n", $owner, $tableName, $columnName;
		}
	}
}

