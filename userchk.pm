
package userchk;

sub output{
}

sub query {

	my($SQL) = 'select 
						global_name, 
						username, sid 
					from global_name, v$session
					where username is not null';

	my($sth) = $main::dbh->prepare($SQL);
	my($rc)  = $sth->execute;

	#print "In the query routine \n";
	while( @data_array = $sth->fetchrow ) {
		#print "Fetching data in query...\n";
		write;
	}

	#print "Done in query routine\n";
	
}

format STDOUT = 
@<<<<<<<<<<<<<<<<<<<<<  @<<<<<<<<<<<<<<<<<<<<   @####
$data_array[0], $data_array[1], $data_array[2]
.

1;

