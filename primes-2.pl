#!/usr/bin/perl

# http://c2.com/cgi/wiki?SieveOfEratosthenesInManyProgrammingLanguages

$n=1000000;
 for($t=3; $t*$t<$n; $t+=2) {
     if (!$c[$t]) {
         for($s=$t*$t; $s<$n; $s+=$t*2) { $c[$s]++ }
     }
 }
 print "2\n";
 for($t=3; $t<$n; $t+=2) {
     $c[$t] || print "$t\n";
 }
