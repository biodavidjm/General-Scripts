#!/usr/bin/perl -w

use strict;
use feature qw/say/;

use DBI;

use Getopt::Long;
use IO::File;
use autodie qw/open close/;
use Text::CSV;

my $script = "parse_orthologs_column4.pl";

# Validation section
my %options;
GetOptions( \%options, 'sp=s', 'file=s' );
for my $arg (qw/sp file/) {
    die
        "\te.g: perl $script -sp=H.sapiens -file=../data/ortholog_information.txt\n"
        if not defined $options{$arg};
}

my $specie   = $options{sp};
my $filename = $options{file};

# Input file
open my $FILE, '<', $filename
    or die "Sorry, but I cannot open '$filename'!\n";

say "\nProcessing the file " . $filename;

# Output file
my $outtemp = "ortholog_information-" . $specie . ".txt";
my $outfile = "../data/" . $outtemp;
open my $out, '>', $outfile
    or die "\nBig problem!!!!\nI can't create '$outfile'\n";

my $count = 0;

# Mapping systematic name to many Associated Genes
while ( my $line = <$FILE> ) {
    if ( $line =~ /source/ ) { print {$out} $line; next; }
    chomp($line);
    my @data_store = split( "\t",  $line );
    my @column4    = split( " | ", $data_store[3] );

    my @listTemp = ();
    foreach my $each (@column4) {
        if ( $each =~ /$specie/ ) {
            push @listTemp, $each;
        }
    }
    if (@listTemp) {
        print {$out} $data_store[0] . "\t";
        print {$out} $data_store[1] . "\t";
        print {$out} $data_store[2] . "\t";
        print {$out} join( " | ", @listTemp ), "\n";
        $count++;
    }
}

# Let's play defense here...
if ( $count == 0 ) {
    unlink $outfile;
    say "\nE R R O R ! ! ! ! ! ! ! ! !! ! ! ! !! ";
    say "Oh oh! The specie <"
        . $specie
        . "> is not available in column 4 of the file <"
        . $filename . ">!\n";
}
else {
    say "File " . $outfile . " ready, Sir\n";
}

exit;

=head1 NAME

parse_orthologs_column4.pl  - Parse the ../data/ortholog_information.txt selecting only one specie on column 4

=head1 SYNOPSIS

perl parse_orthologs_column4.pl -sp=H.sapiens -file=../data/ortholog_information.txt

=head1 OPTIONS

 --sp       Specie name. Must be in the following format: H.sapiens
 --file     The location of the ortholog_information.txt file
 
=head1 INPUT

It requires the <ortholog_information.txt> file be available at the ../data/ directory.

=head1 OUTPUT

<ortholog_information-Specie.name.txt>
Same as the input file, but column 4 only contains orthologs from the input specie.

=head1 DESCRIPTION 

Column 4 in the file ortholog_information.txt contains the list of orthologs
for each dicty gene. This script parses the file and generates a new file with
only those dicty genes having ortholog(s) on the specie provided as input.
