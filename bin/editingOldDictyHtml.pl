#!/usr/bin/perl -w

use strict;
use warnings;
use feature qw/say/;

use IO::File;
use autodie qw/open close/;

# Deal with files
use File::Path qw( make_path );
use File::Copy qw(copy);

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

# Copy the file in a folder
my $newDirectory = 'originalHTMLs';
my $path;

if ( not defined( $path = get_path( "$newDirectory", "./$newDirectory" ) ) ) {
    die "Unable to find or create a suitable directory for output file.";
}

my $copy_filename = "$path/$filename";
copy( $filename, $copy_filename ) or die "Copy failed: $!";

# Open the file and take the data
open my $in_fh, '<', $filename
    or die "\nCannot open file \"$filename\"\n";

# Open output
my $output = "temp-" . $filename;
open my $out_fh, '>', $output
    or die "\nCannot open file \"$output\"\n";

# Parsing the FILE:
my $flag_head = 0;
while (my $line = <$in_fh>)
{
    chomp($line);
    # Remove includes <!--#include virtual
    if ( $line =~ /<\!--#include virtual/ ) {
        if ( $line =~ /<!--#include virtual="\/inc\/page-layout-bottom.html"-->/ )
        {
            $line =~ s/<!--#include virtual="\/inc\/page-layout-bottom.html"-->//;
            say "MODIFY: " . $line;
            say {$out_fh} $line;
            next;
        }
        else {
            say "DELETE: " . $line;
            next;
        }
    }

    # Remove doctype label
    if ( $line =~ /^\s{0,}<!DOCTYPE/ ) {
        say "DELETE: " . $line;
        next;
    }

    # Remove html tag
    if ( ( $line =~ /^\s{0,}<html/ ) || ( $line =~ /^\s{0,}<\/html/ ) ) {
        say "DELETE: " . $line;
        next;
    }

    # Comment out <head> tag
    if ( $line =~ /^\s{0,}<head/ ) {
        say {$out_fh} "#" . $line;
        $flag_head = 1;
        next;
    }
    if ( ($flag_head) && ( $line !~ /^\s{0,}<\/head/ ) ) {
        say {$out_fh} "#" . $line;
        next;
    }
    if ( ($flag_head) && ( $line =~ /^\s{0,}<\/head/ ) ) {
        say {$out_fh} "#" . $line;
        $flag_head = 0;
        next;
    }

    # Replacing anchoring for the angular version
    if ( $line =~ /<a href="#(\S+)">/ ) {
        my $anchor = $1;
        $line =~ s/href="#(\S+)">/ng\-click='($anchor)'>/;
        say {$out_fh} $line;
        next;
    }

    # Replacing <a href="/techniques
    if ( $line =~ /<a href=\"\/techniques/ ) {
        $line
            =~ s/<a href=\"\/techniques/<a ng\-href="#\/research\/techniques/;
        say {$out_fh} $line;
        next;
    }

    # Add right route to imgs
    if ( $line =~ /<img(.*?)src/ ) {
        if ( $line =~ /<img(.*?)src=\"\/techniques/ ) {
            $line =~ s/src=\"\/techniques/src=\"views\/techniques/;
            say {$out_fh} $line;
            next;
        }
        elsif ( $line =~ /<img(.*?)src="images/ ) {
            $line =~ s/src="images/src="views\/techniques\/images/;
            say {$out_fh} $line;
            next;
        }
        else {
            say "WARNING: check out this link " . $line;
            say {$out_fh} $line;
            next;
        }
    }
    # If nothing is found from all of the above... print it to the file
    say {$out_fh} $line;
}

exit;

sub get_path {
    my @tries = @_;
    my $good_path;
    for my $try_path (@tries) {
        if ( -e $try_path and -d _ and -w _ ) {    # Path exists. Done.
            $good_path = $try_path;
            last;
        }
        elsif ( eval { make_path($try_path); 1; } ) {    # Try to create it.
            $good_path = $try_path;    # Success, we're done.
            last;
        }
    }

    # Failure; fall through to next iteration.
    # If no more options, loop ends with $path undefined.
    return $good_path;
}

=head1 NAME

editOldDictyHtml.pl - Edit old dictyBase html files to adapt them to the views in AngularJS

=head1 SYNOPSIS

perl editOldDictyHtml.pl filename.html

=head1 OUTPUT

processed/filename.html Process the files to a new folder

=head1 DESCRIPTION 

