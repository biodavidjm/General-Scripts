#!/usr/bin/perl -w

use strict;
use warnings;
use feature qw/say/;

use IO::File;
use autodie qw/open close/;

# Deal with files
use FindBin;
use File::Path qw( make_path );
use File::Copy qw(move);

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

open my $in_fh, '<', $filename
    or die "Sorry, but I cannot open '$filename'!\n";

my $output_filename = "ajs-".$filename;
# open my $out_fh, '+>', $output_filename or die $!;

my $count = 0;
my $flag_head = 0;

# # Mapping systematic name to many Associated Genes
while ( my $line = <$in_fh> ) {
    chomp($line);
    # Remove includes <!--#include virtual

    if ( $line =~ /<\!--#include virtual/ ) 
    { 
        if ( $line =~ /<!--#include virtual="\/inc\/page-layout-bottom.html"-->/)
        {
            $line =~ s/<!--#include virtual="\/inc\/page-layout-bottom.html"-->//;
            say "DELETE: " . $line; 
            next;
        }
        else
        {
            say "DELETE: " . $line; 
            next; 
        }
    }

    # Remove doctype label
    if ( $line =~ /^\s{0,}<!DOCTYPE/ ) 
    { 
        say "DELETE: " . $line; 
        next; 
    }

    # Remove html tag
    if ( ($line =~ /^\s{0,}<html/ ) || ($line =~ /^\s{0,}<\/html/ ) ) 
    {
        say "DELETE: " . $line;
        next;
    }
    # Comment out <head> tag
    if ($line =~ /^\s{0,}<head/ ) 
    {
        say "#".$line;
        $flag_head = 1;
        next;
    }
    if ( ($flag_head) && ($line !~ /^\s{0,}<\/head/ ) )
    {
        say "#".$line;
        next;
    }
    if ( ($flag_head) && ($line =~ /^\s{0,}<\/head/ ) )
    {
        say "#".$line;
        $flag_head = 0; 
        next;
    }
    # Replacing anchoring for the angular version
    if ( $line =~ /<a href="#(\S+)">/)
    {
        my $anchor = $1;
        # say $line . " ----> ".$anchor;
        $line =~ s/href="#(\S+)">/ng\-click='($anchor)'>/;
        # say "\t" . $line;
    }
    # Replacing <a href="/techniques
    if ( $line =~ /<a href=\"\/techniques/)
    {
        $line =~ s/<a href=\"\/techniques/<a ng\-href="#\/research\/techniques/;
        say $line;
    }
    # Add right route to imgs
    if ( $line =~ /<img(.*?)src=\"\/techniques/ )
    {
        $line =~ s/src=\"\/techniques/src=\"views\/techniques/;
        say $line;
    }
    if ( $line =~ /<img(.*?)src=\"images/ )
    {
        $line =~ s/src=\"\/techniques/src=\"views\/techniques/;
        say $line;
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

