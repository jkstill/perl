#!/usr/bin/env perl

use Data::Dumper;
use XML::Dumper;
my $dump = new XML::Dumper;


=head1 XML::Dumper Demo

 This is only good for dumping Perl data to XML.

 The XML is created with elements that allow XML::Dumper to read it back into a Perl data structure.

 This module does NOT read standard XML files.

=cut
 
my $perl  = '';
my $xml   = '';
 
#  ====l Convert Perl code to XML
$perl = [
  {
              fname       => 'Fred',
              lname       => 'Flintstone',
              residence   => 'Bedrock'
  },
  {
              fname       => 'Barney',
              lname       => 'Rubble',
              residence   => 'Bedrock'
  }
];

$xml = $dump->pl2xml( $perl );

print "\nPerl -> XML\n";
print "XML:\n$xml\n";
 
# ===== Dump to a file
#my $file = "dump.xml";
#$dump->pl2xml( $perl, $file );
 
my @perl = $dump->xml2pl( $xml );
 
print "XML -> Perl\n";
print "Perl\n", Dumper(\@perl),"\n";
