#!/usr/bin/env perl

use warnings;
use strict;
use IO::File;
use Data::Dumper;
use Time::HiRes qw(tv_interval gettimeofday);
use Fcntl qw(:DEFAULT O_RDONLY O_SYNC O_DIRECT);

my $verbose=0;

my $bs=16 * 2**10;
my $iterations=4096;
my $file='testdata-10M.dat';

my $fh = new IO::File;

$fh->open($file,'<','O_RDONLY | O_SYNC | O_DIRECT') || die "cannot open $file - $!\n";

binmode $fh;

my @fileAttributes = stat($fh);

#print Dumper(\@fileAttributes);

my $fileSize = $fileAttributes[7];
my $blocks = $fileSize / $bs;
my $maxSeekPos = ($blocks * $bs) - $bs ;

print qq{

      size: $fileSize
        bs: $bs
    blocks: $blocks
maxSeekPos: $maxSeekPos

} if $verbose;

my $processT0 = [gettimeofday];

my @times;

for ( my $i=0; $i < $iterations; $i++) {

	print "i: $i " if $verbose;

	my $fileSeekPos = int(rand($blocks)) * $bs;

	my $readT0=[gettimeofday];

	$fh->seek($fileSeekPos, 0);
	print "fileSeekPos: $fileSeekPos\n" if $verbose;

	my $currFilePos = $fh->getpos;

	my $buf;
	print "read with $bs bytes at position $fileSeekPos : " , $bs + $fileSeekPos, "\n" if $verbose;
	my $rc=$fh->read($buf,$bs,0) || die "failed to read - $@\n";

	my $readT1=[gettimeofday];

	push @times,tv_interval($readT0,$readT1);

	print " rc: $rc\n" if $verbose;

	# should not happen
	if ( $rc == $bs ) { ; }
	elsif ( $rc == 0 ) { print "EOF\n" }
	elsif ( $rc < $bs ) { print "Short Read\n" }
	elsif ( ! defined($rc) ) { print "Error - rc not defined\n" }
	elsif ( ! $rc ) { print "Error - not rc\n" }
	else {print "unknown error\n"}

	print "==================\n" if $verbose;

}

print "\n";

my $processT1 = [gettimeofday];

my $processTime = tv_interval $processT0, $processT1;

#foreach my $time ( @times ) { printf("%02.6f\n", $time) }

print "total time: $processTime\n";

my ($minTime, $maxTime, $timeSum) = (999999,0,0);
map { $timeSum += $_ } @times;
map { $minTime = $_ if $_ < $minTime } @times;
map { $maxTime = $_ if $_ > $maxTime } @times;

print "reads: $iterations\n";
printf("read Time: %02.6f\n", $timeSum);
printf("min read Time: %02.6f\n", $minTime);
printf("max read Time: %02.6f\n", $maxTime);
printf("avg read Time: %02.6f\n", $timeSum / $iterations);



