
# filereader
# given a record size and filename, it will determine if the file is
# flat or line delimited. If flat, it reads the records and prints them with
# line feed. If line delimited, it just reads and prints.

# this is useful in the case of files that are sent to us, and sometimes they
# are flat and sometimes they are not

# make sure perl can find my perl library files

use filetype;

package fileread;

sub fileread 
{

	$fileread::file = shift || die &fileread::usage;
	$fileread::reclen = shift || die &fileread::usage;

	#print STDERR "file=$fileread::file\n";
	#print STDERR "reclen=$fileread::reclen\n";

	$fileread::type = filetype::filetype($file);

	if ( 0 == $fileread::type) { $fileread::expr = "while ( read(FILEREAD_FILE,\$_,$fileread::reclen))" }
	else { $fileread::expr = 'while(<FILEREAD_FILE>)' }

	open(FILEREAD_FILE,"$fileread::file") || die "could not open file $fileread:file\n" ;
	$fileread::body='
	{
		chomp;
		print;
		print "\n";
	}';

	$fileread::run = $fileread::expr . $fileread::body;
	eval $fileread::run;
	close(FILEREAD_FILE);
}

sub usage
{
   my($package, $filename, $line ) = caller 1;
   print STDERR "usage: fileread::fileread(<filename>,<reclen>) \n";
   print STDERR "fileread.pm package: determines if a file is flat\n";
   print STDERR "or line delimited, reads it and prints to STDOUT\n";
   if ( $filename ) 
   {
      print " ------\n";
      print "called from $filename, line $line \n";
   }
   exit 1;
}

1;


