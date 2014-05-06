#!/usr/bin/perl -w

use strict;
use feature qw/say/;

use DBI;

use Getopt::Long;
use IO::File;
use autodie qw/open close/;
use Text::CSV;

my $script = "update_curated_mutants_with_ddbg_id.pl";

# Validation section
my %options;
GetOptions( \%options, 'dsn=s', 'user=s', 'passwd=s', 'file=s' );
for my $arg (qw/dsn user passwd file/) {
    die
        "\tperl $script -dsn=ORACLE_DNS -user=USERNAME -passwd=PASSWD -file=FILE_NAME\n"
        if not defined $options{$arg};
}

my $host     = $options{dsn};
my $user     = $options{user};
my $pass     = $options{passwd};
my $filename = $options{file};

open my $FILE, '<', $filename or die "Sorry, but I cannot open '$filename'!\n";

say "- Processing the file";

# Mapping systematic name to many Associated Genes
my %hash_sys2genes = ();
my $skip           = 0;
while ( my $line = <$FILE> ) {
    $skip++;
    if ( $skip == 1 ) { next; }
    chomp($line);
    my @data_store = split( "\t", $line );
    $hash_sys2genes{ $data_store[0] } = $data_store[2];
}

print "- Connecting to the database... ";
my $dbh = DBI->connect( "dbi:Oracle:host=$host;sid=orcl;port=1521",
    $options{user}, $options{passwd},
    { RaiseError => 1, LongReadLen => 2**20 } );
print " done!!\n";

# Database setup
# Select DDB_G_ID based on gene_name

my $statement = <<"STATEMENT";
SELECT dbx.accession AS DDB_G_ID
FROM cgm_chado.feature gene
INNER JOIN cgm_chado.dbxref dbx ON gene.dbxref_id = dbx.dbxref_id
WHERE gene.name = ?
STATEMENT

# Foreach gene name, it gets the DDB_G ID.
# Since it is a one-to-one result, it uses selectrow_array.

my %hash_gene2ddb = ();
for my $id ( keys %hash_sys2genes ) {
    my @temp = split( ' \| ', $hash_sys2genes{$id} );
    foreach my $genename (@temp) {
        my @ddb_g_id = $dbh->selectrow_array( $statement, {}, ($genename) );

   # The same gene name might be called several times, so let's just overwrite
        $hash_gene2ddb{$genename} = $ddb_g_id[0];
    }
}
$dbh->disconnect();

# Printing the file again adding the additional column of DDB_G_ID

# Output
my $outfile = "../data/all-mutants-ddb_g.txt";
open my $out, '>', $outfile
    or die "\nBig problem!!!!\nI can't create '$outfile'\n";

# Open input file again
open my $FILEAGAIN, '<', $filename or die "Cannot open '$filename'!\n";
my $skipa = 0;

print "- Writing file... <";
while ( my $line = <$FILEAGAIN> ) {
    $skipa++;
    if ( $skipa == 1 ) {
        print {$out}
            "Systematic_Name\tStrain_Descriptor\tAssociated gene(s)\tDDB_G_ID\tPhenotypes\n";
        next;
    }
    chomp($line);
    my @data_store = split( "\t", $line );

    print {$out} $data_store[0] . "\t"
        . $data_store[1] . "\t"
        . $data_store[2] . "\t";

    my $gene_column = $data_store[2];
    my @temp        = split( ' \| ', $gene_column );
    my $number      = @temp;
    if ( $number == 0 ) { die "ooooooh nooooooo!\n"; }

    my $gene = $temp[0];
    if ( $number > 1 ) {
        print {$out} join( ' | ', @temp );

        # foreach my $genename (@temp) {
        #     print {$out} $hash_gene2ddb{$genename} . " | ";
        # }
        print {$out} "\t";
    }
    else {

        print {$out} $hash_gene2ddb{$gene} . "\t";
    }

    print {$out} $data_store[3] . "\n";
}

print $outfile. "> is out!\n\n";

exit;

=head1 NAME

update_curated_mutants_with_ddbg_id.pl  - Update the all-mutants.txt with a DDB_G_ID additional column

=head1 SYNOPSIS

perl update_curated_mutants_with_ddbg_id.pl  --dsn=<Oracle DSN> --user=<Oracle user> --passwd=<Oracle password> --file=<FILE_NAME>


=head1 OPTIONS

 --dsn           Oracle database DSN
 --user          Database user name
 --passwd        Database password
 --file          File name (probably all-mutants.txt)

=head1 INPUT

It requires the <all-muntants.txt> file be available at the ../data/ directory.

=head1 OUTPUT

<all-mutants-ddb_g.txt>
Same as the input file, but with an extra column with DDB_G_id

=head1 DESCRIPTION

Add an additional column to the file <all-mutants.txt> that contains the DDB_G
ID of the gene names within the 3rd column ("Associated genes(s)").
The new column name: <DDB_G_ID>
