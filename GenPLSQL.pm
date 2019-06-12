
package GenPLSQL;

use strict;
use DBI;
use OraEnv;
use Carp;
#no strict qw(vars refs);

#flush STDOUT so I can see progress
$|=1;

local( *PARMS, *BODY, *HDR);

($GenPLSQL::db, $GenPLSQL::username, $GenPLSQL::password)=('','','');
(@GenPLSQL::InsertTables, @GenPLSQL::UpdateTables)=((),());
($GenPLSQL::debug_flag)=('');
%GenPLSQL::InsertColHash=();
%GenPLSQL::Parameters=();
$GenPLSQL::dbh='';


(
	$GenPLSQL::SyserrTabFileSuffix, 
	$GenPLSQL::SyserrPkgFileSuffix, 
	$GenPLSQL::HdrPkgSuffix, 
	$GenPLSQL::BodyPkgSuffix 
) = qw(syserr_tab_cr.sql syserr_pkg.sql hdr_pkg.sql body_pkg.sql );


GenPLSQL::DebugOff();

sub DebugOn {
	$GenPLSQL::debug_flag=1;
}

sub DebugOff {
	$GenPLSQL::debug_flag=0;
}

sub debug{
	$GenPLSQL::debug_flag;
}


sub SetEnv {
	$GenPLSQL::db = shift || croak "GenPLSQL:SetEnv needs sid\n";
	OraEnv::SetEnv($GenPLSQL::db);
}

sub SetPasswd {
	$GenPLSQL::username = shift || croak "Need a usernane in GenPLSQL::SetPasswd\n";
	$GenPLSQL::password = OraEnv::GetPassWord($GenPLSQL::db,$GenPLSQL::username);
}

sub GetParms {

	print STDOUT "\nGetting Parameters\n";
	my($Parameter,@Parameters,$dummy, $key);
	open(PARMS,"parameters.txt") || croak "cannot open parameters.txt - $!\n";
	@Parameters=<PARMS>;
	close (PARMS);
	chomp(@Parameters);

	for $Parameter ( @Parameters ) {
		($GenPLSQL::ParmName, $GenPLSQL::Parm ) = split(/:/, $Parameter);
		$GenPLSQL::Parameters{$GenPLSQL::ParmName} = $GenPLSQL::Parm;
	}

	# check for known required parameters
	for $key ( qw(
			package_prefix
			owner
			insert_table_text 
			update_table_text 
			syserr_tab_text 
			syserr_text )) {
		
		croak "$key not set in parameters.txt\n" unless exists($GenPLSQL::Parameters{$key});

	}

	# we know this is a required parameter
	$GenPLSQL::Parameters{'owner'} = uc($GenPLSQL::Parameters{'owner'});

}


sub GetInsertTables {

	print STDOUT "\nGetting table info from database\n";

	open(TABLES, $GenPLSQL::Parameters{'insert_table_text'}) || croak "unable to open  $GenPLSQL::Parameters{'insert_table_text'} - $! \n";

	my(@InsertTableText);
	@InsertTableText=<TABLES>;
	close( TABLES);
	#remove comments
	@InsertTableText = grep(!/^#/, @InsertTableText);
	chomp(@InsertTableText);

	my($line,$InsertTableName, @InsertColumns);

	for $line ( @InsertTableText ) {
		($InsertTableName) = split(/:/,$line);
		@InsertColumns = split(/:/,$line);
		shift(@InsertColumns);
		$GenPLSQL::InsertColHash{$InsertTableName}=[ @InsertColumns ];
		push(@GenPLSQL::InsertTables, uc($InsertTableName));
	}

	if ( GenPLSQL::debug() ) {
		my($Table, $colnum);
		print "TABLE VALUES:\n";
		foreach $Table ( keys %GenPLSQL::InsertColHash ) {
			print "Table: $Table\n";
			for $colnum ( 0 .. $#{ $GenPLSQL::InsertColHash{$Table} } ) {
				print "\tColumn: $GenPLSQL::InsertColHash{$Table}[$colnum]\n";
			}
		}
	}

}

sub GetUpdateTables {

	print STDOUT "\nGetting table update info from database\n";

	open(TABLES, $GenPLSQL::Parameters{'update_table_text'}) || croak "unable to open  $GenPLSQL::Parameters{'update_table_text'} - $! \n";

	@GenPLSQL::UpdateTableText=<TABLES>;
	close( TABLES);
	#remove comments
	@GenPLSQL::UpdateTableText = grep(!/^#/, @GenPLSQL::UpdateTableText);
	chomp(@GenPLSQL::UpdateTableText);

	@GenPLSQL::UpdateTables = @GenPLSQL::UpdateTableText;

	my ($Table );
	if ( GenPLSQL::debug() ) {
		print "UPDATE TABLE VALUES:\n";
		foreach $Table ( @GenPLSQL::UpdateTables ) {
			print "Table: $Table\n";
		}
	}

}

sub Connect {
	print STDOUT "\nConnecting to $GenPLSQL::db\n";
	$GenPLSQL::dbh = DBI->connect('dbi:Oracle:' . $GenPLSQL::db, $GenPLSQL::username, $GenPLSQL::password );
	croak "Connect to  $GenPLSQL::db failed \n" unless $GenPLSQL::dbh;
}

sub OpenSqlOut {
	print STDOUT "\nOpen SQL output files\n";
	my($HdrPkgFile) = ${GenPLSQL::Parameters{'package_prefix'}} . $GenPLSQL::HdrPkgSuffix;
	my($BodyPkgFile) = ${GenPLSQL::Parameters{'package_prefix'}} . $GenPLSQL::BodyPkgSuffix;

	open(GenPLSQL::HDR,">${HdrPkgFile}") || croak "unable to create $HdrPkgFile - $!\n";
	open(GenPLSQL::BODY,">${BodyPkgFile}") || croak "unable to create $BodyPkgFile - $!\n";

}


sub PkgHdrs {
	
	my($PkgType) = shift || croak "Need to know if updates/inserts in PkgHdrs\n";
	
	print STDOUT "\nWriting package headers\n";

	print GenPLSQL::HDR "create or replace package ${GenPLSQL::Parameters{'package_prefix'}}${PkgType}\n";
	print GenPLSQL::HDR "is\n\n";

	print GenPLSQL::BODY "create or replace package body ${GenPLSQL::Parameters{'package_prefix'}}${PkgType}\n";
	print GenPLSQL::BODY "is\n\n";
	print GenPLSQL::BODY "\n\terror_code integer;\n";
	print GenPLSQL::BODY "\n\terror_msg varchar(200);\n\n";

	if ( lc($PkgType) eq 'inserts' ) { GenPLSQL::InsertHdrDocs("${GenPLSQL::Parameters{'package_prefix'}}${PkgType}") }
	else { GenPLSQL::UpdateHdrDocs("${GenPLSQL::Parameters{'package_prefix'}}${PkgType}") }

}

sub PkgInsertHdrs {
	GenPLSQL::PkgHdrs('inserts');
}

sub PkgUpdateHdrs {
	GenPLSQL::PkgHdrs('updates');
}

sub InsertCode {

	print STDOUT "\nWriting INSERT code\n";

	no strict 'vars';
	my($Table);
	for $Table ( @GenPLSQL::InsertTables ) {

		print "TABLE: $Table\n" if &GenPLSQL::debug();
		my($ary, $rv, $DbaTabColumnSql, $sthCol);

		$DbaTabColumnSql="select column_name,data_type
				from all_tab_columns 
				where table_name = '$Table' and owner = \'$GenPLSQL::Parameters{'owner'}\'
				order by nullable, column_id";

		$sthCol = $GenPLSQL::dbh->prepare($DbaTabColumnSql);

		$rv = $sthCol->execute || croak "error with statement $DbaTabColumnSql \n";

		print ".";
		my($ShortTable) = substr($Table,0,26);

		my(@proc, @InsertColumns)=(),();
		my(%ChkForCol)=();
		# check for columns to exclude
		@ChkForCol{  @{ $GenPLSQL::InsertColHash{$Table}} } = (1) x @{ $GenPLSQL::InsertColHash{$Table}};

		while( $ary = $sthCol->fetchrow_arrayref ) {

			unless ( $ChkForCol{$$ary[0]} ) {
				#push(@proc, "\t\t$${ary[0]}_in ${Table}.$${ary[0]}%type default null,");
				push(@proc, "\t\t" . substr($${ary[0]},0,27) . "_in ${Table}.$${ary[0]}%type default null,");
				push(@InsertColumns,$${ary[0]});
			}
		}

		$proc[$#proc] = substr($proc[$#proc],0,length($proc[$#proc])-1);

		&PrintCodeDoc("${ShortTable}_ins",\@proc);

		print GenPLSQL::BODY lc("\n\n\tprocedure ${ShortTable}_ins (\n");
		print GenPLSQL::HDR lc("\n\n\tprocedure ${ShortTable}_ins (\n");

		my($line);
		for $line( @proc ) { 
			print ".";
			print GenPLSQL::BODY lc("$line\n");
			print GenPLSQL::HDR lc("$line\n");
		}

		print '.';
		print GenPLSQL::HDR "\t);\n";
		print GenPLSQL::BODY "\t)\n";

		print '.';
		print GenPLSQL::BODY "\tis\n";
		print GenPLSQL::BODY "\tbegin\n\n";

		my(@coltmp) = @InsertColumns;
		for $ColNumber ( 0 .. ($#coltmp -1 ) ) {
			$coltmp[$ColNumber] = $coltmp[$ColNumber] . ",";
		}

		print GenPLSQL::BODY "\t\tinsert into $Table (\n";
		for $column( @coltmp ) { 
			print '.';
			print GenPLSQL::BODY lc("\t\t\t$column\n");
		}
		print GenPLSQL::BODY "\t\t)\n";
		print GenPLSQL::BODY "\t\tvalues (\n";

		@coltmp = @InsertColumns;
		for $ColNumber ( 0 .. ($#coltmp -1 ) ) {
			$coltmp[$ColNumber] = substr($coltmp[$ColNumber],0,27) . "_in,";
		}
		$coltmp[$#ColNumber] = substr($coltmp[$#ColNumber],0,27) . '_in';

		for $column( @coltmp ) { 
			print '.';
			print GenPLSQL::BODY lc("\t\t\t${column}\n");
		}
		print GenPLSQL::BODY "\t\t);\n\n";

		print GenPLSQL::BODY "\texception\n\n";
		print GenPLSQL::BODY "\t\twhen others then\n";

		print GenPLSQL::BODY "\t\t\terror_msg := SQLERRM;\n";
		print GenPLSQL::BODY "\t\t\terror_code := SQLCODE;\n";

		print GenPLSQL::BODY "\t\t\tdbms_output.put_line('error inserting into $Table');\n";
		print GenPLSQL::BODY "\t\t\t${GenPLSQL::Parameters{'package_prefix'}}syserr.${GenPLSQL::Parameters{'package_prefix'}}system_errors_ins(\n";
		print GenPLSQL::BODY "\t\t\t\terror_code,\n";
		print GenPLSQL::BODY "\t\t\t\terror_msg,\n";
		print GenPLSQL::BODY lc("\t\t\t\t'error encountered in ${GenPLSQL::Parameters{'package_prefix'}}inserts.". substr(${Table},0,26) . "_ins'\n");
		print GenPLSQL::BODY "\t\t\t);\n";
	
		print GenPLSQL::BODY "\t\t\traise;\n";

		print GenPLSQL::BODY "\tend;\n\n";

	}

}

sub UpdateCode {

	print STDOUT "\nWriting UPDATE code\n";

	my($Table);
	for $Table ( @GenPLSQL::UpdateTables ) {

		$Table = uc($Table);
		print '.';
		print "TABLE: $Table\n" if &GenPLSQL::debug();
		my($ary, $rv, $DbaTabColumnSql, $DbaPkColSql, $sthPk, $sthCol);

		$DbaPkColSql = " select t.constraint_type, column_name
			from all_cons_columns c, all_constraints t
			where
				c.owner = t.owner
				and c.constraint_name = t.constraint_name
				and c.table_name = t.table_name
				and t.constraint_type in ('P', 'U')
				and t.owner = \'$GenPLSQL::Parameters{'owner'}\'
				and t.table_name = '$Table'
			order by  constraint_type, column_name";

		$DbaTabColumnSql="select column_name, data_type
				from all_tab_columns 
				where table_name = '$Table' and owner = \'$GenPLSQL::Parameters{'owner'}\'
				order by nullable, column_id";


		# try to get the data for the WHERE clause first
		# if no PK or UK is present, then don't create an
		# update routine, as it would update ALL rows without
		# benefit of a unique key

		# WHERE clause here
		#print "$DbaPkColSql\n\n";
		$sthPk = $GenPLSQL::dbh->prepare($DbaPkColSql);
		$rv = $sthPk->execute || croak "error with statement $DbaPkColSql \n";
		my(@where)=();
		print "\nTable: $Table\n" if &GenPLSQL::debug;
		while( $ary = $sthPk->fetchrow_arrayref ) {
			print "\t$$ary[0] - $$ary[1]\n" if &GenPLSQL::debug;
			push(@where, "\t\t\tand " . $${ary[1]} . " = nvl(" . substr($${ary[1]},0,27) . "_in, $${ary[1]})");
		}

		if ( $where[0] ) {

			$sthCol = $GenPLSQL::dbh->prepare($DbaTabColumnSql);

			$rv = $sthCol->execute || croak "error with statement $DbaTabColumnSql \n";

			print ".";
			my($ShortTable) = substr($Table,0,26);

			my(@proc, @UpdateColumns, %ColumnDataTypes)=(),();

			while( $ary = $sthCol->fetchrow_arrayref ) {

				$ColumnDataTypes{$${ary[0]}} = $${ary[1]};

				push(@proc, "\t\t" . substr($${ary[0]},0,27) . "_in ${Table}.$${ary[0]}%type default null,");
				push(@UpdateColumns,$${ary[0]});
			}

			$proc[$#proc] = substr($proc[$#proc],0,length($proc[$#proc])-1);

			&PrintCodeDoc("${ShortTable}_upd",\@proc);

			print GenPLSQL::BODY lc("\n\n\tprocedure ${ShortTable}_upd (\n");
			print GenPLSQL::HDR lc("\n\n\tprocedure ${ShortTable}_upd (\n");

			my($line);
			for $line( @proc ) { 
				print ".";
				print GenPLSQL::BODY lc("$line\n");
				print GenPLSQL::HDR lc("$line\n");
			}

			print '.';
			print GenPLSQL::HDR "\t);\n";
			print GenPLSQL::BODY "\t)\n";

			print '.';
			print GenPLSQL::BODY "\tis\n";
			print GenPLSQL::BODY "\tbegin\n\n";

			my(@coltmp) = @UpdateColumns;
			my($ColNumber, @ColNumber, $ColNum);
			for $ColNumber ( 0 .. ($#coltmp -1 ) ) {
				$coltmp[$ColNumber] = $coltmp[$ColNumber] . ",";
			}

			print GenPLSQL::BODY "\t\tupdate $Table set\n";

			@coltmp = @UpdateColumns;
			for $ColNumber ( 0 .. $#coltmp ) {

				if ( $ColumnDataTypes{ $UpdateColumns[$ColNumber]} =~ /CHAR/ ) {
					print "CHARACTER TYPE:  $UpdateColumns[$ColNumber] - $ColumnDataTypes{ $UpdateColumns[$ColNumber]}\n"
						if GenPLSQL::debug();

					$coltmp[$ColNumber] = "decode(" . 
						substr(${coltmp[$ColNumber]},0,27) . "_in," .
						"'NULL',NULL," .
						"nvl(" . substr(${coltmp[$ColNumber]},0,27) . "_in,${coltmp[$ColNumber]}))";

				} elsif ( $ColumnDataTypes{ $UpdateColumns[$ColNumber]} =~ /DATE/ ) {
					print "DATE TYPE:  $UpdateColumns[$ColNumber] - $ColumnDataTypes{ $UpdateColumns[$ColNumber]}\n"
						if GenPLSQL::debug();

					$coltmp[$ColNumber] = "decode(" . 
						substr(${coltmp[$ColNumber]},0,27) . "_in," .
						"to_date('01/01/0001','mm/dd/yyyy'),NULL," .
						"nvl(" . substr(${coltmp[$ColNumber]},0,27) . "_in,${coltmp[$ColNumber]}))";

				} elsif ( $ColumnDataTypes{ $UpdateColumns[$ColNumber]} =~ /NUMBER/ ) {
					print "NUMBER TYPE:  $UpdateColumns[$ColNumber] - $ColumnDataTypes{ $UpdateColumns[$ColNumber]}\n"
						if GenPLSQL::debug();

					$coltmp[$ColNumber] = "decode(" . 
						substr(${coltmp[$ColNumber]},0,27) . "_in," .
						"-1,NULL," .
						"nvl(" . substr(${coltmp[$ColNumber]},0,27) . "_in,${coltmp[$ColNumber]}))";

				} else {
					print "NUMERIC TYPE:  $UpdateColumns[$ColNumber] - $ColumnDataTypes{ $UpdateColumns[$ColNumber]}\n"
						if GenPLSQL::debug();
					$coltmp[$ColNumber] = "nvl(" . substr(${coltmp[$ColNumber]},0,27) . "_in,${coltmp[$ColNumber]})";
				}

				$coltmp[$ColNumber] .= ',' unless ( $ColNumber == $#coltmp );
				#print "$ColNumber : $#coltmp\n";

			}

			for $ColNum( 0 .. $#coltmp ) { 
				my($tmpline)='';
				print '.';
				#print GenPLSQL::BODY lc("\t\t\t${UpdateColumns[$ColNum]} = ${coltmp[$ColNum]}\n");
				$tmpline = lc("\t\t\t${UpdateColumns[$ColNum]} = ${coltmp[$ColNum]}");
				$tmpline =~ s/'null'/'NULL'/g;
				print GenPLSQL::BODY "$tmpline\n";
			}
		
			$where[0] =~ s/^([\s]*)and(.*)$/$1 $2/;
			print  GenPLSQL::BODY "\t\twhere\n";
			for $line( @where ) { 
				print ".";
				print GenPLSQL::BODY lc("$line\n");
			}

			print GenPLSQL::BODY "\t\t;\n\n";

			print GenPLSQL::BODY "\texception\n\n";
			print GenPLSQL::BODY "\t\twhen others then\n";

			print GenPLSQL::BODY "\t\t\terror_msg := SQLERRM;\n";
			print GenPLSQL::BODY "\t\t\terror_code := SQLCODE;\n";

			print GenPLSQL::BODY "\t\t\tdbms_output.put_line('error updating $Table');\n";
			print GenPLSQL::BODY "\t\t\t${GenPLSQL::Parameters{'package_prefix'}}syserr.${GenPLSQL::Parameters{'package_prefix'}}system_errors_ins(\n";
			print GenPLSQL::BODY "\t\t\t\terror_code,\n";
			print GenPLSQL::BODY "\t\t\t\terror_msg,\n";
			print GenPLSQL::BODY lc("\t\t\t\t'error encountered in ${GenPLSQL::Parameters{'package_prefix'}}inserts.". substr(${Table},0,26) . "_ins'\n");
			print GenPLSQL::BODY "\t\t\t);\n";
	
			print GenPLSQL::BODY "\t\t\traise;\n";

			print GenPLSQL::BODY "\tend;\n\n";

		} else { # no WHERE clause
			print GenPLSQL::HDR "\n\n";
			print GenPLSQL::HDR "--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n";
			print GenPLSQL::HDR "--!!\n";
			print GenPLSQL::HDR "--!! The UPDATE procedures for $Table\n";
			print GenPLSQL::HDR "--!! were not created due to the absence\n";
			print GenPLSQL::HDR "--!! of a PRIMARY or UNIQUE key\n";
			print GenPLSQL::HDR "--!!\n";
			print GenPLSQL::HDR "--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n";
			print GenPLSQL::HDR "\n\n";
		}
	}

}


sub EndPkg {
	print GenPLSQL::BODY "end;\n\n";
	print GenPLSQL::BODY "/\n\n";
	print GenPLSQL::BODY "show errors\n\n";

	print GenPLSQL::HDR "end;\n\n";
	print GenPLSQL::HDR "/\n\n";
	print GenPLSQL::HDR "show errors\n\n";

	print "\n";

	#close(GenPLSQL::BODY);
	#close(GenPLSQL::HDR);
}


sub CreateErrorTab {
	print STDOUT "\nCreating SQL for system error table\n";

	my($SysErrFile) = ${GenPLSQL::Parameters{'package_prefix'}} . ${GenPLSQL::SyserrTabFileSuffix};
	open(ERRTXT, $GenPLSQL::Parameters{'syserr_tab_text'}) || croak "Cannot open $GenPLSQL::Parameters{'syserr_tab_text'} - $!\n";
	open(ERRTAB, ">${SysErrFile}" ) || croak "Cannot create ${SysErrFile} - $!\n";
	my( @ErrCode,$line );
	@ErrCode = <ERRTXT>;
	chomp(@ErrCode);
	close (ERRTXT);

	for $line ( @ErrCode ) {
		$line =~ s/<PREFIX>/$GenPLSQL::Parameters{'package_prefix'}/g;
		print ERRTAB "$line\n";
	}

	close (ERRTAB);
}

sub CreateSysErrorCode {
	print STDOUT "\nCreating system error code\n";
	my($SysErrPkgFile) = ${GenPLSQL::Parameters{'package_prefix'}} . $GenPLSQL::SyserrPkgFileSuffix;
	open(ERRTXT, $GenPLSQL::Parameters{'syserr_text'}) || croak "Cannot open $GenPLSQL::Parameters{'syserr_text'} - $!\n";
	open(ERRCODE, ">${SysErrPkgFile}" ) || croak "Cannot create ${SysErrPkgFile} - $!\n";

	my( @ErrCode,$line );
	@ErrCode = <ERRTXT>;
	chomp(@ErrCode);
	close (ERRTXT);

	for $line ( @ErrCode ) {
		$line =~ s/<PREFIX>/$GenPLSQL::Parameters{'package_prefix'}/g;
		print ERRCODE "$line\n";
	}
}

# code to compile all of the packages
sub CreateCompileSql {

	my($CompFile) = "${GenPLSQL::Parameters{'package_prefix'}}comp.sql";
	local( *PARMS );
	open(COMP, ">$CompFile") || croak "Unable to create $CompFile in CreateCompileSql - $!\n";

	print STDOUT "\nCreating SQL file to compile all packages for ${GenPLSQL::Parameters{'package_prefix'}}\n";
	print COMP "\@${GenPLSQL::Parameters{'package_prefix'}}${GenPLSQL::SyserrTabFileSuffix}\n";
	print COMP "\@${GenPLSQL::Parameters{'package_prefix'}}${GenPLSQL::SyserrPkgFileSuffix}\n";
	print COMP "\@${GenPLSQL::Parameters{'package_prefix'}}${GenPLSQL::HdrPkgSuffix}\n";
	print COMP "\@${GenPLSQL::Parameters{'package_prefix'}}${GenPLSQL::BodyPkgSuffix}\n";

	close ( COMP);

}


sub PrintCodeDoc {
	my($proc_name) = shift || croak "PrintCodeDoc needs a procedure name\n";
	my($rcol_array) = shift || croak "PrintCodeDoc needs an array reference\n";
	my($col, $colname, $colspec, $newcol);

	print GenPLSQL::HDR "\n";
	print GenPLSQL::HDR "\t--", '#' x 60 , "\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--# PROCEDURE: ", lc($proc_name), "\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--# PARAMETERS:\n";
	print GenPLSQL::HDR "\t--#\n";

	for $col ( @$rcol_array ) {
		$newcol = lc($col);
		$newcol =~ s/^\s+//;
		($colname, $colspec) = split(/\s+/, $newcol);
		print GenPLSQL::HDR "\t--#    $colname $colspec\n";
		if ( GenPLSQL::debug() ) { print STDOUT "\tCOLUMN: $colname $colspec\n" }
	}

	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--", '#' x 60 , "\n\n";
}

sub InsertHdrDocs {
	my($PkgName) = shift || croak "InsertHdrDocs needs a package name\n";
	print GenPLSQL::HDR "\n";
	print GenPLSQL::HDR "\t--", '#' x 60 , "\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--# PACKAGE: " , lc($PkgName), "\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--# These INSERT procedures may be called by using positional\n";
	print GenPLSQL::HDR "\t--# parameters or by using named parameters.  Using named parameters\n";
	print GenPLSQL::HDR "\t--# allows you to insert a subset of the total columns.  All NOT NULL\n";
	print GenPLSQL::HDR "\t--# columns must of course be inserted.\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--# EXAMPLE PROCEDURE:\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--#    procedure my_tab_ins (\n";
	print GenPLSQL::HDR "\t--#       name_in varchar2(20),\n";
	print GenPLSQL::HDR "\t--#       workdate_in date,\n";
	print GenPLSQL::HDR "\t--#       timeworked_in number,\n";
	print GenPLSQL::HDR "\t--#       address_in varchar2(20),\n";
	print GenPLSQL::HDR "\t--#       city_in varchar2(20),\n";
	print GenPLSQL::HDR "\t--#       state_in varchar2(2)\n";
	print GenPLSQL::HDR "\t--#    );\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--# Now, insert just the name and address\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--# POSITIONAL:\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--#    begin\n";
	print GenPLSQL::HDR "\t--#       my_tab_ins('Jared Still',null,null,\n";
	print GenPLSQL::HDR "\t--#          '100 SW First', 'Portland','OR'\n";
	print GenPLSQL::HDR "\t--#       );\n";
	print GenPLSQL::HDR "\t--#    end;\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--# NAMED:\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--#    begin\n";
	print GenPLSQL::HDR "\t--#       my_tab_ins(\n";
	print GenPLSQL::HDR "\t--#          name_in => 'Jared Still',\n";
	print GenPLSQL::HDR "\t--#          address_in => '100 SW First'\n";
	print GenPLSQL::HDR "\t--#          city_in => 'Portland',\n";
	print GenPLSQL::HDR "\t--#          state_in => 'OR'\n";
	print GenPLSQL::HDR "\t--#       );\n";
	print GenPLSQL::HDR "\t--#    end;\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--", '#' x 60 , "\n";
}

sub UpdateHdrDocs {
	my($PkgName) = shift || croak "UpdateHdrDocs needs a package name\n";
	print GenPLSQL::HDR "\n";
	print GenPLSQL::HDR "\t--", '#' x 60 , "\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--# PACKAGE: " , lc($PkgName), "\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--# These UPDATE procedures may be called by using positional\n";
	print GenPLSQL::HDR "\t--# parameters or by using named parameters.  Using named parameters\n";
	print GenPLSQL::HDR "\t--# allows you to update based on all key columns, or just some of\n";
	print GenPLSQL::HDR "\t--# the key columns.\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--# The benefit of named parameters is that it allows you to specify\n";
	print GenPLSQL::HDR "\t--# only the columns you wish to use, rather than specify a null\n";
	print GenPLSQL::HDR "\t--# for each column you don't wish to use.\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--# EXAMPLE PROCEDURE:\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--#    procedure my_tab_upd (\n";
	print GenPLSQL::HDR "\t--#       last_name_in varchar2(20),\n";
	print GenPLSQL::HDR "\t--#       first_name_in varchar2(20),\n";
	print GenPLSQL::HDR "\t--#       workdate_in date,\n";
	print GenPLSQL::HDR "\t--#       timeworked_in number,\n";
	print GenPLSQL::HDR "\t--#       address_in varchar2(20),\n";
	print GenPLSQL::HDR "\t--#       city_in varchar2(20),\n";
	print GenPLSQL::HDR "\t--#       state_in varchar2(2)\n";
	print GenPLSQL::HDR "\t--#    );\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--# Now, update address for all rows with last name of 'Jones'\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--# POSITIONAL:\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--#    begin\n";
	print GenPLSQL::HDR "\t--#       my_tab_upd('Jones',null,null,null,\n";
	print GenPLSQL::HDR "\t--#          '100 SW First', 'Portland','OR'\n";
	print GenPLSQL::HDR "\t--#       );\n";
	print GenPLSQL::HDR "\t--#    end;\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--# NAMED:\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--#    begin\n";
	print GenPLSQL::HDR "\t--#       my_tab_upd(\n";
	print GenPLSQL::HDR "\t--#          last_name_in => 'Jones',\n";
	print GenPLSQL::HDR "\t--#          address_in => '100 SW First,'\n";
	print GenPLSQL::HDR "\t--#          city_in => 'Portland',\n";
	print GenPLSQL::HDR "\t--#          state_in => 'OR'\n";
	print GenPLSQL::HDR "\t--#       );\n";
	print GenPLSQL::HDR "\t--#    end;\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--# NOTES:\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--# All columns not specified in the arguments, or specified in the\n";
	print GenPLSQL::HDR "\t--# arguments as NULL will default to their current value.\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--# This allows you to specify only the columns of the key you wish to\n";
	print GenPLSQL::HDR "\t--# base your update on, and only the columns that you wish to update.\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--# Special handling is required to update a column to NULL\n";
	print GenPLSQL::HDR "\t--# To update a date column to NULL, pass a date argument of '01/01/0001'.\n";
	print GenPLSQL::HDR "\t--# To update a character column to NULL, pass a literal string of 'NULL'. \n";
	print GenPLSQL::HDR "\t--# Numeric columns cannot be made NULL using these procedures.\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--# e.g.\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--#    begin\n";
	print GenPLSQL::HDR "\t--#       my_tab_upd(\n";
	print GenPLSQL::HDR "\t--#          last_name_in => 'Jones',\n";
	print GenPLSQL::HDR "\t--#          birthdate_in => to_date('01/01/0001','mm/dd/yyyy')\n";
	print GenPLSQL::HDR "\t--#          middle_initial_in => 'NULL',\n";
	print GenPLSQL::HDR "\t--#          state_in => 'OR'\n";
	print GenPLSQL::HDR "\t--#       );\n";
	print GenPLSQL::HDR "\t--#    end;\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--#\n";
	print GenPLSQL::HDR "\t--", '#' x 60 , "\n";
}
1;




