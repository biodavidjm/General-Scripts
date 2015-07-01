General-Scripts
===============

___Scripts to provide punctual solutions to simple (or complex) problems___

***


# Data requested by users

- `update_curated_mutant_with_ddbg_id.pl`:

updates the all-mutants.txt file from the __Download__ section of the dictyBase with an additional column mapping the DDB_G_ID from the list of genes found in column 3. 

- `parse_orthologs_column4.pl`:

Column 4 in the file `ortholog_information.txt` contains the list of orthologs
for each dicty gene. This script parses the file and generates a new file with
only those dicty genes having ortholog(s) on the specie provided as input.

- `editingOldDictyHtml.pl`: 
 
Edit old dictyBase html files to adapt them to the views in AngularJS. Check [this document](https://github.com/dictyBase/frontpage-dictybase/blob/develop/documentation/htmlMigration2angular.md) (or perldoc) to find out more about the details



