#!/usr/bin/env perl

use strict;
use warnings;
use feature qw( :5.20 );
use JSON;
use HTML::Parser;
use HTML::TokeParser;
use HTML::TreeBuilder;

# Validating data
my $script = "generateJSONfromHTML.pl";
die "Where is the name of the input file?" if ( @ARGV != 1);

my $input = $ARGV[0];
say $input;

my $p = HTML::TokeParser->new(shift||$input);

while (my $token = $p->get_tag("a")) {
	my $url = $token->[1]{href} || "-";
	my $text = $p->get_trimmed_text("/a");
	print "$url\t$text\n";
}


exit;