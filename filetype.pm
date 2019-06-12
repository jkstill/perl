
# package filetype requires a filename
# it will return 0,1 or 2
# 0 = flat file
# 1 = line delimited, equal rec lengths
# 2 = line delimited, unequal rec lengths

package filetype;
use strict;

$filetype::LINE_FEED = 10;
$filetype::CARRIAGE_RETURN = 13;
$filetype::MAX_CHARS_TO_CHK = 2000;

$filetype::types{'PKZIP'} = "PK" . chr(3) . chr(4);
$filetype::types{'GZIP'} = chr(0x1f) . chr(0x8b) . chr(0x08) . chr(0x08);
$filetype::types{'INTERPRETER SCRIPT'} = '#!';
$filetype::types{'PERL SCRIPT'} = '#!.*\/perl';
$filetype::types{'TCL SCRIPT'} = '#!.*\/wish';

sub filetype
{

	$filetype::file = $_[0] || die &filetype::usage;

	$filetype::line_delimit = 0;
	$filetype::records_same_length=1;

	# determine if line delimited or a flat file

	@filetype::rec_lengths=();
	$filetype::linecount=0;

	$filetype::charcount=0;
	$filetype::char_per_line = 0;
	$filetype::linecount=0;

	open(FTYPE,$filetype::file) || die "cannot open $filetype::file - $! \n";

	while ( read FTYPE, $filetype::char, 1 )
	{

		last if $filetype::charcount++ > $filetype::MAX_CHARS_TO_CHK ;	# check max of # chars
		next if  $filetype::CARRIAGE_RETURN == $filetype::char_ascii ; # skip CR in DOS files

		$filetype::char_ascii = ord($filetype::char); # convert char to number

		# if it is a line feed, this is end of line
		if ( $filetype::LINE_FEED == $filetype::char_ascii )
		{ 
			@filetype::rec_lengths[$filetype::linecount++]=$filetype::char_per_line;
			$filetype::char_per_line=0;
			next;
		}
	
		$filetype::char_per_line++;

	}

	# check to see if lines are of the same length in line delimited file
	if ( $filetype::linecount > 0 )
	{
		$filetype::line_delimit = 1;
		$filetype::line_len_chk = $filetype::rec_lengths[0];
		for $filetype::char_per_line ( @filetype::rec_lengths )
		{
			#print $char_per_line,"\n";
			if ( $filetype::char_per_line != $filetype::line_len_chk ) { $filetype::records_same_length = 0; last }
			$filetype::line_len_chk = $filetype::char_per_line;
		}
	}

	close(FTYPE);

	if ( $filetype::line_delimit ) 
	{ 
		#file is line delimited - record lengths are the same
		if ( $filetype::records_same_length ) { return 1 }
		#file is line delimited - record lengths are unequal
		else { return 2 }
	}
	else { return 0 }  # flat file
}

sub usage
{
	my($package, $filename, $line ) = caller 1;
	print "filetype.pm package: determines if a file is line delimited or flat\n";
	print "usage: filetype::filetype(<filename>) \n";
	print "return values:\n";
	print "   0 = flat file\n";
	print "   1 = line delimited - equal record lengths\n";
	print "   2 = line delimited - unequal record lengths\n";
	if ( $filename ) 
	{
		print " ------\n";
		print "called from $filename, line $line \n";
	}
	exit 1;
}


sub FileFormatType
{
	my($file)=@_;

	use Carp;
	if ($file eq "" ) { croak "No filename supplied\n" }

	open( _FT_FILE, $file ) || croak "Cannot open $file\n";

	my($head,$readlen,@types);
	$readlen = read(_FT_FILE, $head, 512);
	close(_FT_FILE);
	if ( $readlen < 1 ) { return "UNKNOWN" }

	for $filetype::FormatType ( keys(%filetype::types) )
	{
		if ( $head =~ /^$filetype::types{$filetype::FormatType}/ ) { return $filetype::FormatType }
	}	
	return "UNKNOWN";

}


1;

