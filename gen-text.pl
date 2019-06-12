#!/usr/bin/env perl

use strict;
use warnings;
use IO::File;
 use Time::HiRes qw( gettimeofday );

# get number of lines and words from cli
my $numLines=$ARGV[0];
my $numWords=$ARGV[1];

if ( ! $numWords || ! $numLines ){
    usage();
    die;
}

my $wordFile='/usr/share/dict/words';
my $fh = IO::File->new();

$fh->open($wordFile, O_RDONLY);

die "could not open $wordFile = $!\n" unless $fh;

my @words=<$fh>;

chomp @words;

my $lastWordEl=$#words;


for (my $line=0; $line<$numLines; $line++) {
    
    my ($seconds, $microseconds) = gettimeofday;
    srand (( $line + 1) * $microseconds);
    my @list; 
    for (my $word=0; $word<$numWords; $word++) {
        push @list, $words[ int(rand($lastWordEl))];
    }
    print join(' ',@list),"\n";
}


sub usage {
    print qq{
  $0 lines words_per_line

  eg. $0 10 5

  this will print 10 lines of 5 words each
  data is taken at random from $wordFile
};

}



