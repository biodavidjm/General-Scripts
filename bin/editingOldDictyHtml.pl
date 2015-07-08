#!/usr/bin/perl -w

use strict;
use warnings;
use feature qw/say/;

use IO::File;
use autodie qw/open close/;

# Deal with files
use File::Path qw( make_path );
use File::Copy qw(copy);
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

# Copy the file in a folder
my $newDirectory = 'originals';
my $path;

# create the folder if it does not exist
if ( not defined( $path = get_path( "$newDirectory", "./$newDirectory" ) ) ) {
    die "Unable to find or create a suitable directory for output file.";
}

# Check whether the file already exists there
my $checking = "$path/$filename";
die "$checking exits already. Please, solve the conflict before running this script again!\n" if -e $checking;

# Copy the original file there if it does not exist already
my $copy_filename = "$path/$filename";
copy( $filename, $copy_filename ) or die "Copy failed: $!";

# Open the file and take the data
open my $in_fh, '<', $filename
    or die "\nCannot open file \"$filename\"\n";

# Open output
my $tempout = "temp-" . $filename;
open my $out_fh, '>', $tempout
    or die "\nCannot create file \"$tempout\"\n";

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
            say {$out_fh} $line;
            next;
        }
        elsif ( $line =~ /<!--#include virtual="\/inc\/footer_withSide.html"-->/ )
        {
            $line =~ s/<!--#include virtual="\/inc\/footer_withSide.html"-->//;
            say {$out_fh} $line;
            next;
        }
        else {
            next;
        }
    }

    # Remove doctype label
    if ( $line =~ /^\s{0,}<!DOCTYPE/ ) {
        next;
    }

    # Remove html tag
    if ( $line =~ /^\s{0,}<html/ ) {
        next;
    }
    if ( $line =~ /^\s{0,}<\/html/ ) {
        next;
    }

    # Comment out <head> tag
    if ( $line =~ /^\s{0,}<head/ ) {
        # say {$out_fh} "<!-- ";
        # say {$out_fh} $line;
        $flag_head = 1;
        next;
    }
    if ( ($flag_head) && ( $line !~ /^\s{0,}<\/head/ ) ) {
        # say {$out_fh} $line;
        next;
    }
    if ( ($flag_head) && ( $line =~ /^\s{0,}<\/head/ ) ) {
        # say {$out_fh} $line;
        # say {$out_fh} " -->";
        $flag_head = 0;
        next;
    }

    if ( ( $line =~ /<body>/ ) || ( $line =~ /<\/body>/ )  )
    {
        next;
    }

    # Replacing anchoring for the angular version and  <a href="/techniques
    # Both can happen in the same line
    if ( ( $line =~ /<a href=\"\/techniques/ ) || ( $line =~ /<a href="#(\S+)">/ ) ) {
        
        if ( $line =~ /<a href="#(\S+)">/ )
        {
            my $anchor = $1;
            $line =~ s/href="#(\S+)">/href="" ng-click="scrollTo('$anchor')">/;
        }
        if ( $line =~ /<a href=\"\/techniques/ )
        {
            $line =~ s/<a href=\"\/techniques/<a ng\-href="#\/research\/techniques/;
            say {$out_fh} $line;
            next;
        }
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

close $in_fh;
close $out_fh;

move $tempout, $filename;

say $filename . " processed successfully";

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

=over

- The input html file modified

- The original version of the file in the folder B</originals>

=back

=head1 DESCRIPTION

The script parses html files and transform them in AngularJS views:

=over

- Removes the previous dicty C<includes>

- Removes C<DOCTYPE> tag

- Removes C<html> tag

- Removes out the C<head> section

- Replaces html anchors by Angular anchors, i.e., B<href="#anchor"> by B<ng-click='($anchor)'>) 

- Replaces B<href="/techniques/.."> by B<ng-href="#/research/techniques/...">

- Right path for B=<img> tags

=back

