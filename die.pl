#!/usr/bin/perl

sub zf{
	print "This is z\n";
	exit 4;
}

sub yf{
	print "This is y\n";
	zf();
}

sub xf{
	print "This is x\n";
	yf();
}

xf();


