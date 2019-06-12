# returns TRUE if going to STDOUT, FALSE otherwise

sub IsStdout {
 local(*FALSE,*TRUE);
 $FALSE=0;
 $TRUE=1;
 return ( -t STDOUT ? $TRUE : $FALSE ) ; 
}
1;

