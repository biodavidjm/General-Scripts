#!/usr/bin/perl -w

use strict;
use warnings;
use feature qw/say/;

use IO::File;
use autodie qw/open close/;

# Deal with files
use FindBin;
use File::Path qw( make_path );

# Validation section
my $script = "editOldDictyHtml.pl";
if ( @ARGV != 1 ) {
    print "One ARGUMENT NEEDED ----->";
    say "Usage: $script filename.html";
    exit;
}

# Input file
my $filename = $ARGV[0];
die "---> Hey!!! "
    . $filename
    . " does not have the 'html' extension. Why not?\n"
    if ( $filename !~ /.*\.html/ );

my $output_filename = "ajs-".$filename;

open my $in_fh, '<', $filename
    or die "Sorry, but I cannot open '$filename'!\n";

open my $out_fh, '+>', $output_filename or die $!;

my $count = 0;
my $flag_head = 0;

# # Mapping systematic name to many Associated Genes
while ( my $line = <$in_fh> ) {
    chomp($line);
    if ( $line =~ /^\s{0,}<!DOCTYPE/ ) 
    { 
        say "DELETE: " . $line; 
        next; 
    }
    if ($line =~ /^\s{0,}<head/ ) 
    {
        say "#".$line;
        $flag_head = 1;
        next;
    }
    if ( ($flag_head) && ($line !~ /^\s{0,}<\/head/ ) )
    {
        say "#".$line;
    }
    if ( ($flag_head) && ($line =~ /^\s{0,}<\/head/ ) )
    {
        say "#".$line;
        $flag_head = 0; 
    }
}


exit;

=head1 NAME

editOldDictyHtml.pl - Edit old dictyBase html files to adapt them to the views in AngularJS

=head1 SYNOPSIS

perl editOldDictyHtml.pl filename.html

=head1 OUTPUT

processed/filename.html Process the files to a new folder

=head1 DESCRIPTION 

