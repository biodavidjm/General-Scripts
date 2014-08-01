General-Scripts
===============

Scripts to provide punctual solutions to small problems

* [Data Requested by users](#dare)

* [Installation on the Mac](#inon)
	* [General](#ge)
	* [Development](#de)
		* [Perl related](#pere)
		* [Others](#ot)
	* [Database related](#darela)

<a name="dare"/>
## Data requested by users

* ``update_curated_mutant_with_ddbg_id.pl``:

updates the all-mutants.txt file from the ___Download___ section of the dictyweb with an additional column mapping the DDB_G_ID from the list of genes found in column 3. 


<a name="inon"/>
## Installations on the Mac
by @biodavidjm

Compilation of all the installations on a Mac OS X 10.9 (Mavericks).

<a name="ge"/>
### General

- iTerm 2
- CoRD: a Mac OS X remote desktop client for Microsoft Windows
- Cisco AnyConnect Secure Mobility Client (VPN)
- Eclipse Standard for Mac.
- WriteRoom
- Sublime Text 2
	- Mod: ln -s /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl /usr/local/bin/sublime

- Textmate
- Mou, The missing Markdown editor for web developers
- Chrome extensions: Gliffy diagrams
- GrandPerspective
- Magican
- XQuartz (for X11 X.Org X Window System that runs on OS X)
- Coot
- MacTeX
- Pandoc
- MAMP
- ncbi-blast-2.2.29+.dmg 255 MB	1/6/14 12:00:00 AM
- VirtualBox (already installed): Operating systems available (e.g., for web development testing)
	- Ubuntu Desktop
	- Ubuntu serve
	- Windows 7
	- Widhows 8.1 
	
- Circos on Ubuntu: I basically followed the steps [described here](http://kylase.github.io/CircosAPI/circos-on-linux-virtual-machine/), but the only difference is the step of installing the damn libgd library, which requires this command instead: `sudo apt-get -y install libgd2-xpm-dev build-essential`... so now it works in both ubuntu desktop and 

<a name="de"/>
### Development

<a name="pere"/>
#### Perl related
* Absolutely avoid using Perl from the Mac OS X system is a mandatory step. In order to use other Perl version, or to control the Perl versions, use `perlbrew`, for example.

* `Perlbrew`: follow the instructions [online](http://search.cpan.org/~gugod/App-perlbrew-0.67/lib/App/perlbrew.pm). I followed these steps:

```
	* curl -kL http://install.perlbrew.pl | bash
	* perlbrew init
	* perlbrew available
	* perlbrew install perl-5.19.11 (**it took a while**)
	* perlbrew list (check what is installed)
	* perlbrew switch perl-5.12.2 (Switch perl in the $PATH) + perl -v
    * perlbrew use perl-5.8.1 (Temporarily use another version only in current shell) + perl -v
    * perlbrew off (Turn it off completely. Useful when you messed up too deep. Or want to go back to the system Perl)
    * perlbrew switch perl-5.12.2
    
    Perl version installed: 
    - perl-5.18.2
  	- perl-5.19.11
```

* `cpanm`: Once `perlbrew` is installed, is absolutely essential to install `cpanm` running `perlbrew install-cpanm`. Use it to install libraries 

To install cpanm libraries you can install it:

* In Your home available to any perl project. Then just run `cpanm <package>`

* In a library specially created for every perl project, and this perl project will only use this library. This is done with `local::lib`, which is the package that allows the possibility of managing library packages for a particular project. But the way to install and use local::lib is through `cpanm`. Follow these steps to make sure you are doing the right thing:
	* First, make sure that `cpanm` is installed on the system (if you do, `brew remove cpanm`)
	* `perl -V` tells you which perl version and libraries you are using
Libraries are installed using.
	* Create the project folder (`ejemplo`) && cd
	* Create the perl library associated to that perl project: `perlbrew lib create ejemplo`. The message `lib 'perl-5.19.11@ejemplo' is created.` is prompted, which specify the perl version under which you are installing the library.
	* **IN EVERY SHELL** the library for that particular project MUST BE specified executing `perlbrew use perl-5.19.11@ejemplo`. Whatever perl library you know install using `cpanm` will be available only in this shell and in the perl scripts that you might run there. But first, make sure that you are truly using that perl library by doing `perl -V` and paying attention to the following line:
	
		```
		@INC:
		/Users/djt469/.perlbrew/libs/perl-5.19.11@ejemplo/lib/perl5
		/Users/djt469/perl5/lib/perl5    
		```
	* Install a package, eg:`cpanm Acme::Time::Baby`
	* Test that it works only in this shell: `perl -MAcme::Time::Baby -E 'say babytime'` if you try in other shells, with the other libraries, it won't work.
	
In conclusion: `perlbrew` helps you managing the libraries for every particular project and according to some particular perl version. It helps managing `local::lib` for you. Otherwise, you would need to do almost everything by hand and the libraries would have to be installed in a folder `lib` in your `project` directory. 
	

##### Perl Packages
Use `cpanm`, but associated to every perl version that you are managing with `perlbrew`, as explained above. Anyway, it is better to install the packages locally in your home directory. 

Some useful perl packages that you can install using `cpanm <package>`

* `Devel::Cover`
* `PPI::HTML, Test::Differences, Parallel::Iterator, JSON::XS`required by `Devel::Cover` (check the manual)
* `XML::Simple` to handle xml files
* `Data::Dumper` to dump date (for example, date in the xml file)
* `DBIx::Class::Schema::Loader` 
* `Sqitch` is a database change management application. Use it when planning to do changes in the database to keep track
		- cpanm App::Sqitch DBD::Pg
		
* Perl Object Oriented related
	- `Moose`
	- `Moose::Manual`


<a name="ot"/>
#### Others (no Perl related)
- Xcode
	- Command line Tools: I needed to subscribe first as a Mac developer.
- `Homebrew`: it needed to install the Xcode. And using brew I installed:

- RUBY: brew install ruby
- GO programming language: brew install go
- Github for Mac
- Vagrant: to manage virtual Linux from the command line. It uses VirtualBox (already installed) in the computer.
- npm, the official package manager for Node.js. (brew install)
	- npm install -g yo
- Sass: sudo gem install sass
- Hydo: HTML5 editor

#### Web development

- I TRIED to install Gumby framework (a grid system application for web design):
	- Install RVM, the Ruby Version Manager.
	- curl -L https://get.rvm.io | bash -s stable --ruby
	- Install gem dependencies (Gumby utilizes modular-scale, Compass and Sass)
sass-3.2.19
	- chunky_png-1.3.0
	- fssm-0.2.10
		- compass-0.12.5.gem (100%)
 	- Done installing documentation for chunky_png, compass, fssm, sass
modular-scale-2.0.5
	- Documentation for modular-scale-2.0.5
- sass-3.3.5
	- Documentation for sass-3.3.5
	

<a name="darela"/>
### Database related
- Oracle SQL Developer: it required to create an account to be able to download the app.

- Instant Client for Mac OS X (Intel x86) Version 11.2.0.3.0 (64-bit): Instant 
	- Client Package Basic: All files required to run OCI, OCCI, and JDBC-OCI applications 
	- Download instantclient-basic-macos.x64-11.2.0.3.0.zip (62,342,264 bytes)
- Postgres93 (it comes from postgres.app). It is a server a PostgreSQL server running on the mac
	Modify the file .bash_profile with the following line:
	PATH="/Applications/Postgres93.app/Contents/MacOS/bin:$PATH”
and now I can run the commands for PostgrlSQL
- Pgadmim (GUI)
- [SchemaSpy](http://schemaspy.sourceforge.net/) is a tool to analyze database schemas
	- it requires `brew install Graphviz`
	- Run it like this: `java -jar schemaSpy_5.0.0.jar -t pgsql -host localhost:5432 -db music_djm -s public -u djt469 -o foldername -dp postgresql-9.3-1101.jdbc3.jar` 
- Modware loader from github
- **SchemaSpy**: SchemaSpy analyzes database metadata to reverse engineer dynamic Entity Relationship (ER) diagrams. I installed `schemaSpy_5.0.0.jar`. It also requires the drivers of the database. In this case, I also have available in the same directory: `postgresql-9.3-1101.jdbc3.jar`. Check README about how to run it in the /bin/schemaSpy5/ directory 


##### Installation of DBD::Oracle 

I need to first install the 64 bits instant client for Mac, which traditionally has been very problematic. After a lot of difficulties, I made it work. And these are the steps adapted from [here](http://blog.caseylucas.com/tag/oracle-sqlplus/) (the sh script is the essential part) and specially [here](http://blog.g14n.info/2013/07/how-to-install-dbdoracle.html). Since I combined both, I am going to rewrite the steps:

Folder: ``$HOME:/opt/Oracle/packages/`` where I [downloaded](http://www.oracle.com/technetwork/topics/intel-macsoft-096467.html):

```
ls opt/Oracle/packages/
instantclient-basic-macos.x64-11.2.0.3.0.zip   
instantclient-sdk-macos.x64-11.2.0.3.0.zip     
instantclient-sqlplus-macos.x64-11.2.0.3.0.zip
```

Next unzip them:

```
$ cd $HOME/opt/Oracle
$ unzip packages/basic-10.2.0.5.0-linux-x64.zip
$ unzip packages/sdk-10.2.0.5.0-linux-x64.zip
$ unzip packages/sqlplus-10.2.0.5.0-linux-x64.zip
```

Then, go to $HOME and create a ``.oracle_profile`` file with the environment variables 

```
more .oracle_profile
export ORACLE_BASE=$HOME/opt/Oracle
export ORACLE_HOME=$ORACLE_BASE/instantclient_11_2
export PATH=$ORACLE_HOME:$PATH
export TNS_ADMIN=$HOME/etc
export NLS_LANG=AMERICAN_AMERICA.WE8ISO8859P15
export LD_LIBRARY_PATH=$ORACLE_HOME
export DYLD_LIBRARY_PATH=$ORACLE_HOME
```

...which has to be source from ``.bash_profile``. At this point, the test ``sqlplus /nolog`` should give errors. To solve the problem, I cd to the folder ``/opt/Oracle/instantclient_11_2`` and run the script ``changeOracleLibs.sh`` (it should be available in this github project, folder ``/bin``).

After running the script, testing sqlplus should work:

```
$ sqlplus /nolog

SQLPlus: Release 11.2.0.3.0 Production on Fri Mar 21 13:49:34 2014

Copyright (c) 1982, 2012, Oracle.  All rights reserved.

SQL>

```

Finally, install the DBI module ``cpanm PERL::DBI``, which was installed WITH SUCCESS!!

The testing script ``connect2oracle.pl`` was tested to connect to the Oracle database at the VM on nubic with SUCCESS!

**The preliminary conclusion is that now it is possible to develop perl DBI scripts from a Mac OS X (64 bits).**

##### Installing Chado on PostgreSQL 

I basically followed the steps explained in the [GMOD chado tutorial](http://gmod.org/wiki/Chado_Tutorial#Practice).

- MAKER (portable genome annotation pipeline) 
	- brew install maker. It required the additional modules:
       - cpanm IO::Prompt
       - cpanm IO::Prompt
       - cpanm help
       - cpanm forks::shared
       - cpanm forks::shared
       - cpanm forks::shared
       - cpanm File::Which
       - cpanm Bio::Perl
       - cpanm PerlIO::gzip
       - cpanm Bit::Vector
       - cpanm Perl::Unsafe::Signals
       - cpanm Inline
       - cpanm DBI
       - cpanm DBD::SQLite
       - cpanm DBD::Oracle
       - brew install gcc
     But after all this LONG waiting, I finally got this output:
     
	```
      brew install maker
		==> Downloading http://yandell.topaz.genetics.utah.edu/maker_downloads/static/maker-2.31.4.tgz 
		Already downloaded: /Library/Caches/Homebrew/maker-2.31.4.tgz
		==> yes "" |perl Build.PL
		==> ./Build install

		MISSING MAKER PREREQUISITES - CANNOT CONTINUE!!
		Building MAKER

		READ THIS: https://github.com/Homebrew/homebrew/wiki/troubleshooting
		If reporting this issue please do so at (not Homebrew/homebrew):
		  https://github.com/homebrew/homebrew-science/issues
	```

	Therefore, I downloaded MAKER from the official website and installed it on `~/local/maker/bin/`

- Download [CHADO](http://sourceforge.net/projects/gmod/files/gmod/) and follow installation instructions:
	- Install all the required perl modules: `cpanm install Bundle::GMOD`:
	
	```
	! Installing the dependencies failed: Module 'HTML::TreeBuilder' is not installed
	! Bailing out the installation for Bundle-GMOD-1.0.
	34 distributions installed
	```
	- Install CHADO. Basically, cd into chado-1.23/ and
	
	```
	perl Makefile.PL GMOD_ROOT=/usr/local/gmod CHADO_DB_NAME=david_chado
	-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	Makefile written.  Now you should do the following, in order:
	  1. make              (creates necessary build files)
	  2. sudo make install (creates $GMOD_ROOT and subdirectories)
  	  3. make load_schema (loads SQL schema into database)
	```
	And the database `david_chado` was created, with the following list of tables:
	
	```
	                                      List of relations
 Schema |                              Name                               |   Type   | Owner
--------+-----------------------------------------------------------------+----------+--------
 public | acquisition                                                     | table    | username
 public | acquisition_acquisition_id_seq                                  | sequence | username
 public | acquisition_relationship                                        | table    | username
 public | acquisition_relationship_acquisition_relationship_id_seq        | sequence | username
 public | acquisitionprop                                                 | table    | username
 public | acquisitionprop_acquisitionprop_id_seq                          | sequence | username
 public | all_feature_names                                               | view     | username
 public | analysis                                                        | table    | username
 public | analysis_analysis_id_seq                                        | sequence | username
 public | analysisfeature                                                 | table    | username
 public | analysisfeature_analysisfeature_id_seq                          | sequence | username
 public | analysisfeatureprop                                             | table    | username
 public | analysisfeatureprop_analysisfeatureprop_id_seq                  | sequence | username
 public | analysisprop                                                    | table    | username
 public | analysisprop_analysisprop_id_seq                                | sequence | username
 public | arraydesign                                                     | table    | username
 public | arraydesign_arraydesign_id_seq                                  | sequence | username
 public | arraydesignprop                                                 | table    | username
 public | arraydesignprop_arraydesignprop_id_seq                          | sequence | username
 public | assay                                                           | table    | username
 public | assay_assay_id_seq                                              | sequence | username
 public | assay_biomaterial                                               | table    | username
 public | assay_biomaterial_assay_biomaterial_id_seq                      | sequence | username
 public | assay_project                                                   | table    | username
 public | assay_project_assay_project_id_seq                              | sequence | username
 public | assayprop                                                       | table    | username
 public | assayprop_assayprop_id_seq                                      | sequence | username
 public | biomaterial                                                     | table    | username
 public | biomaterial_biomaterial_id_seq                                  | sequence | username
 public | biomaterial_dbxref                                              | table    | username
 public | biomaterial_dbxref_biomaterial_dbxref_id_seq                    | sequence | username
 public | biomaterial_relationship                                        | table    | username
 public | biomaterial_relationship_biomaterial_relationship_id_seq        | sequence | username
 public | biomaterial_treatment                                           | table    | username
 public | biomaterial_treatment_biomaterial_treatment_id_seq              | sequence | username
 public | biomaterialprop                                                 | table    | username
 public | biomaterialprop_biomaterialprop_id_seq                          | sequence | username
 public | cell_line                                                       | table    | username
 public | cell_line_cell_line_id_seq                                      | sequence | username
 public | cell_line_cvterm                                                | table    | username
 public | cell_line_cvterm_cell_line_cvterm_id_seq                        | sequence | username
 public | cell_line_cvtermprop                                            | table    | username
 public | cell_line_cvtermprop_cell_line_cvtermprop_id_seq                | sequence | username
 public | cell_line_dbxref                                                | table    | username
 public | cell_line_dbxref_cell_line_dbxref_id_seq                        | sequence | username
 public | cell_line_feature                                               | table    | username
 public | cell_line_feature_cell_line_feature_id_seq                      | sequence | username
 public | cell_line_library                                               | table    | username
 public | cell_line_library_cell_line_library_id_seq                      | sequence | username
 public | cell_line_pub                                                   | table    | username
 public | cell_line_pub_cell_line_pub_id_seq                              | sequence | username
 public | cell_line_relationship                                          | table    | username
 public | cell_line_relationship_cell_line_relationship_id_seq            | sequence | username
 public | cell_line_synonym                                               | table    | username
 public | cell_line_synonym_cell_line_synonym_id_seq                      | sequence | username
 public | cell_lineprop                                                   | table    | username
 public | cell_lineprop_cell_lineprop_id_seq                              | sequence | username
 public | cell_lineprop_pub                                               | table    | username
 public | cell_lineprop_pub_cell_lineprop_pub_id_seq                      | sequence | username
 public | chadoprop                                                       | table    | username
 public | chadoprop_chadoprop_id_seq                                      | sequence | username
 public | channel                                                         | table    | username
 public | channel_channel_id_seq                                          | sequence | username
 public | common_ancestor_cvterm                                          | view     | username
 public | common_descendant_cvterm                                        | view     | username
 public | contact                                                         | table    | username
 public | contact_contact_id_seq                                          | sequence | username
 public | contact_relationship                                            | table    | username
 public | contact_relationship_contact_relationship_id_seq                | sequence | username
 public | control                                                         | table    | username
 public | control_control_id_seq                                          | sequence | username
 public | cv                                                              | table    | username
 public | cv_cv_id_seq                                                    | sequence | username
 public | cv_cvterm_count                                                 | view     | username
 public | cv_cvterm_count_with_obs                                        | view     | username
 public | cv_leaf                                                         | view     | username
 public | cv_link_count                                                   | view     | username
 public | cv_path_count                                                   | view     | username
 public | cv_root                                                         | view     | username
 public | cvprop                                                          | table    | username
 public | cvprop_cvprop_id_seq                                            | sequence | username
 public | cvterm                                                          | table    | username
 public | cvterm_cvterm_id_seq                                            | sequence | username
 public | cvterm_dbxref                                                   | table    | username
 public | cvterm_dbxref_cvterm_dbxref_id_seq                              | sequence | username
 public | cvterm_relationship                                             | table    | username
 public | cvterm_relationship_cvterm_relationship_id_seq                  | sequence | username
 public | cvtermpath                                                      | table    | username
 public | cvtermpath_cvtermpath_id_seq                                    | sequence | username
 public | cvtermprop                                                      | table    | username
 public | cvtermprop_cvtermprop_id_seq                                    | sequence | username
 public | cvtermsynonym                                                   | table    | username
 public | cvtermsynonym_cvtermsynonym_id_seq                              | sequence | username
 public | db                                                              | table    | username
 public | db_db_id_seq                                                    | sequence | username
 public | db_dbxref_count                                                 | view     | username
 public | dbxref                                                          | table    | username
 public | dbxref_dbxref_id_seq                                            | sequence | username
 public | dbxrefprop                                                      | table    | username
 public | dbxrefprop_dbxrefprop_id_seq                                    | sequence | username
 public | dfeatureloc                                                     | view     | username
 public | eimage                                                          | table    | username
 public | eimage_eimage_id_seq                                            | sequence | username
 public | element                                                         | table    | username
 public | element_element_id_seq                                          | sequence | username
 public | element_relationship                                            | table    | username
 public | element_relationship_element_relationship_id_seq                | sequence | username
 public | elementresult                                                   | table    | username
 public | elementresult_elementresult_id_seq                              | sequence | username
 public | elementresult_relationship                                      | table    | username
 public | elementresult_relationship_elementresult_relationship_id_seq    | sequence | username
 public | environment                                                     | table    | username
 public | environment_cvterm                                              | table    | username
 public | environment_cvterm_environment_cvterm_id_seq                    | sequence | username
 public | environment_environment_id_seq                                  | sequence | username
 public | expression                                                      | table    | username
 public | expression_cvterm                                               | table    | username
 public | expression_cvterm_expression_cvterm_id_seq                      | sequence | username
 public | expression_cvtermprop                                           | table    | username
 public | expression_cvtermprop_expression_cvtermprop_id_seq              | sequence | username
 public | expression_expression_id_seq                                    | sequence | username
 public | expression_image                                                | table    | username
 public | expression_image_expression_image_id_seq                        | sequence | username
 public | expression_pub                                                  | table    | username
 public | expression_pub_expression_pub_id_seq                            | sequence | username
 public | expressionprop                                                  | table    | username
 public | expressionprop_expressionprop_id_seq                            | sequence | username
 public | f_loc                                                           | view     | username
 public | f_type                                                          | view     | username
 public | feature                                                         | table    | username
 public | feature_contains                                                | view     | username
 public | feature_cvterm                                                  | table    | username
 public | feature_cvterm_dbxref                                           | table    | username
 public | feature_cvterm_dbxref_feature_cvterm_dbxref_id_seq              | sequence | username
 public | feature_cvterm_feature_cvterm_id_seq                            | sequence | username
 public | feature_cvterm_pub                                              | table    | username
 public | feature_cvterm_pub_feature_cvterm_pub_id_seq                    | sequence | username
 public | feature_cvtermprop                                              | table    | username
 public | feature_cvtermprop_feature_cvtermprop_id_seq                    | sequence | username
 public | feature_dbxref                                                  | table    | username
 public | feature_dbxref_feature_dbxref_id_seq                            | sequence | username
 public | feature_difference                                              | view     | username
 public | feature_disjoint                                                | view     | username
 public | feature_distance                                                | view     | username
 public | feature_expression                                              | table    | username
 public | feature_expression_feature_expression_id_seq                    | sequence | username
 public | feature_expressionprop                                          | table    | username
 public | feature_expressionprop_feature_expressionprop_id_seq            | sequence | username
 public | feature_feature_id_seq                                          | sequence | username
 public | feature_genotype                                                | table    | username
 public | feature_genotype_feature_genotype_id_seq                        | sequence | username
 public | feature_intersection                                            | view     | username
 public | feature_meets                                                   | view     | username
 public | feature_meets_on_same_strand                                    | view     | username
 public | feature_phenotype                                               | table    | username
 public | feature_phenotype_feature_phenotype_id_seq                      | sequence | username
 public | feature_pub                                                     | table    | username
 public | feature_pub_feature_pub_id_seq                                  | sequence | username
 public | feature_pubprop                                                 | table    | username
 public | feature_pubprop_feature_pubprop_id_seq                          | sequence | username
 public | feature_relationship                                            | table    | username
 public | feature_relationship_feature_relationship_id_seq                | sequence | username
 public | feature_relationship_pub                                        | table    | username
 public | feature_relationship_pub_feature_relationship_pub_id_seq        | sequence | username
 public | feature_relationshipprop                                        | table    | username
 public | feature_relationshipprop_feature_relationshipprop_id_seq        | sequence | username
 public | feature_relationshipprop_pub                                    | table    | username
 public | feature_relationshipprop_pub_feature_relationshipprop_pub_i_seq | sequence | username
 public | feature_synonym                                                 | table    | username
 public | feature_synonym_feature_synonym_id_seq                          | sequence | username
 public | feature_union                                                   | view     | username
 public | feature_uniquename_seq                                          | sequence | username
 public | featureloc                                                      | table    | username
 public | featureloc_featureloc_id_seq                                    | sequence | username
 public | featureloc_pub                                                  | table    | username
 public | featureloc_pub_featureloc_pub_id_seq                            | sequence | username
 public | featuremap                                                      | table    | username
 public | featuremap_featuremap_id_seq                                    | sequence | username
 public | featuremap_pub                                                  | table    | username
 public | featuremap_pub_featuremap_pub_id_seq                            | sequence | username
 public | featurepos                                                      | table    | username
 public | featurepos_featuremap_id_seq                                    | sequence | username
 public | featurepos_featurepos_id_seq                                    | sequence | username
 public | featureprop                                                     | table    | username
 public | featureprop_featureprop_id_seq                                  | sequence | username
 public | featureprop_pub                                                 | table    | username
 public | featureprop_pub_featureprop_pub_id_seq                          | sequence | username
 public | featurerange                                                    | table    | username
 public | featurerange_featurerange_id_seq                                | sequence | username
 public | featureset_meets                                                | view     | username
 public | fnr_type                                                        | view     | username
 public | fp_key                                                          | view     | username
 public | genotype                                                        | table    | username
 public | genotype_genotype_id_seq                                        | sequence | username
 public | genotypeprop                                                    | table    | username
 public | genotypeprop_genotypeprop_id_seq                                | sequence | username
 public | gff3atts                                                        | view     | username
 public | gff3view                                                        | view     | username
 public | gffatts                                                         | view     | username
 public | intron_combined_view                                            | view     | username
 public | intronloc_view                                                  | view     | username
 public | library                                                         | table    | username
 public | library_cvterm                                                  | table    | username
 public | library_cvterm_library_cvterm_id_seq                            | sequence | username
 public | library_dbxref                                                  | table    | username
 public | library_dbxref_library_dbxref_id_seq                            | sequence | username
 public | library_feature                                                 | table    | username
 public | library_feature_library_feature_id_seq                          | sequence | username
 public | library_library_id_seq                                          | sequence | username
 public | library_pub                                                     | table    | username
 public | library_pub_library_pub_id_seq                                  | sequence | username
 public | library_synonym                                                 | table    | username
 public | library_synonym_library_synonym_id_seq                          | sequence | username
 public | libraryprop                                                     | table    | username
 public | libraryprop_libraryprop_id_seq                                  | sequence | username
 public | libraryprop_pub                                                 | table    | username
 public | libraryprop_pub_libraryprop_pub_id_seq                          | sequence | username
 public | magedocumentation                                               | table    | username
 public | magedocumentation_magedocumentation_id_seq                      | sequence | username
 public | mageml                                                          | table    | username
 public | mageml_mageml_id_seq                                            | sequence | username
 public | nd_experiment                                                   | table    | username
 public | nd_experiment_contact                                           | table    | username
 public | nd_experiment_contact_nd_experiment_contact_id_seq              | sequence | username
 public | nd_experiment_dbxref                                            | table    | username
 public | nd_experiment_dbxref_nd_experiment_dbxref_id_seq                | sequence | username
 public | nd_experiment_genotype                                          | table    | username
 public | nd_experiment_genotype_nd_experiment_genotype_id_seq            | sequence | username
 public | nd_experiment_nd_experiment_id_seq                              | sequence | username
 public | nd_experiment_phenotype                                         | table    | username
 public | nd_experiment_phenotype_nd_experiment_phenotype_id_seq          | sequence | username
 public | nd_experiment_project                                           | table    | username
 public | nd_experiment_project_nd_experiment_project_id_seq              | sequence | username
 public | nd_experiment_protocol                                          | table    | username
 public | nd_experiment_protocol_nd_experiment_protocol_id_seq            | sequence | username
 public | nd_experiment_pub                                               | table    | username
 public | nd_experiment_pub_nd_experiment_pub_id_seq                      | sequence | username
 public | nd_experiment_stock                                             | table    | username
 public | nd_experiment_stock_dbxref                                      | table    | username
 public | nd_experiment_stock_dbxref_nd_experiment_stock_dbxref_id_seq    | sequence | username
 public | nd_experiment_stock_nd_experiment_stock_id_seq                  | sequence | username
 public | nd_experiment_stockprop                                         | table    | username
 public | nd_experiment_stockprop_nd_experiment_stockprop_id_seq          | sequence | username
 public | nd_experimentprop                                               | table    | username
 public | nd_experimentprop_nd_experimentprop_id_seq                      | sequence | username
 public | nd_geolocation                                                  | table    | username
 public | nd_geolocation_nd_geolocation_id_seq                            | sequence | username
 public | nd_geolocationprop                                              | table    | username
 public | nd_geolocationprop_nd_geolocationprop_id_seq                    | sequence | username
 public | nd_protocol                                                     | table    | username
 public | nd_protocol_nd_protocol_id_seq                                  | sequence | username
 public | nd_protocol_reagent                                             | table    | username
 public | nd_protocol_reagent_nd_protocol_reagent_id_seq                  | sequence | username
 public | nd_protocolprop                                                 | table    | username
 public | nd_protocolprop_nd_protocolprop_id_seq                          | sequence | username
 public | nd_reagent                                                      | table    | username
 public | nd_reagent_nd_reagent_id_seq                                    | sequence | username
 public | nd_reagent_relationship                                         | table    | username
 public | nd_reagent_relationship_nd_reagent_relationship_id_seq          | sequence | username
 public | nd_reagentprop                                                  | table    | username
 public | nd_reagentprop_nd_reagentprop_id_seq                            | sequence | username
 public | organism                                                        | table    | username
 public | organism_dbxref                                                 | table    | username
 public | organism_dbxref_organism_dbxref_id_seq                          | sequence | username
 public | organism_organism_id_seq                                        | sequence | username
 public | organismprop                                                    | table    | username
 public | organismprop_organismprop_id_seq                                | sequence | username
 public | phendesc                                                        | table    | username
 public | phendesc_phendesc_id_seq                                        | sequence | username
 public | phenotype                                                       | table    | username
 public | phenotype_comparison                                            | table    | username
 public | phenotype_comparison_cvterm                                     | table    | username
 public | phenotype_comparison_cvterm_phenotype_comparison_cvterm_id_seq  | sequence | username
 public | phenotype_comparison_phenotype_comparison_id_seq                | sequence | username
 public | phenotype_cvterm                                                | table    | username
 public | phenotype_cvterm_phenotype_cvterm_id_seq                        | sequence | username
 public | phenotype_phenotype_id_seq                                      | sequence | username
 public | phenstatement                                                   | table    | username
 public | phenstatement_phenstatement_id_seq                              | sequence | username
 public | phylonode                                                       | table    | username
 public | phylonode_dbxref                                                | table    | username
 public | phylonode_dbxref_phylonode_dbxref_id_seq                        | sequence | username
 public | phylonode_organism                                              | table    | username
 public | phylonode_organism_phylonode_organism_id_seq                    | sequence | username
 public | phylonode_phylonode_id_seq                                      | sequence | username
 public | phylonode_pub                                                   | table    | username
 public | phylonode_pub_phylonode_pub_id_seq                              | sequence | username
 public | phylonode_relationship                                          | table    | username
 public | phylonode_relationship_phylonode_relationship_id_seq            | sequence | username
 public | phylonodeprop                                                   | table    | username
 public | phylonodeprop_phylonodeprop_id_seq                              | sequence | username
 public | phylotree                                                       | table    | username
 public | phylotree_phylotree_id_seq                                      | sequence | username
 public | phylotree_pub                                                   | table    | username
 public | phylotree_pub_phylotree_pub_id_seq                              | sequence | username
 public | project                                                         | table    | username
 public | project_contact                                                 | table    | username
 public | project_contact_project_contact_id_seq                          | sequence | username
 public | project_project_id_seq                                          | sequence | username
 public | project_pub                                                     | table    | username
 public | project_pub_project_pub_id_seq                                  | sequence | username
 public | project_relationship                                            | table    | username
 public | project_relationship_project_relationship_id_seq                | sequence | username
 public | projectprop                                                     | table    | username
 public | projectprop_projectprop_id_seq                                  | sequence | username
 public | protein_coding_gene                                             | view     | username
 public | protocol                                                        | table    | username
 public | protocol_protocol_id_seq                                        | sequence | username
 public | protocolparam                                                   | table    | username
 public | protocolparam_protocolparam_id_seq                              | sequence | username
 public | pub                                                             | table    | username
 public | pub_dbxref                                                      | table    | username
 public | pub_dbxref_pub_dbxref_id_seq                                    | sequence | username
 public | pub_pub_id_seq                                                  | sequence | username
 public | pub_relationship                                                | table    | username
 public | pub_relationship_pub_relationship_id_seq                        | sequence | username
 public | pubauthor                                                       | table    | username
 public | pubauthor_pubauthor_id_seq                                      | sequence | username
 public | pubprop                                                         | table    | username
 public | pubprop_pubprop_id_seq                                          | sequence | username
 public | quantification                                                  | table    | username
 public | quantification_quantification_id_seq                            | sequence | username
 public | quantification_relationship                                     | table    | username
 public | quantification_relationship_quantification_relationship_id_seq  | sequence | username
 public | quantificationprop                                              | table    | username
 public | quantificationprop_quantificationprop_id_seq                    | sequence | username
 public | stats_paths_to_root                                             | view     | username
 public | stock                                                           | table    | username
 public | stock_cvterm                                                    | table    | username
 public | stock_cvterm_stock_cvterm_id_seq                                | sequence | username
 public | stock_cvtermprop                                                | table    | username
 public | stock_cvtermprop_stock_cvtermprop_id_seq                        | sequence | username
 public | stock_dbxref                                                    | table    | username
 public | stock_dbxref_stock_dbxref_id_seq                                | sequence | username
 public | stock_dbxrefprop                                                | table    | username
 public | stock_dbxrefprop_stock_dbxrefprop_id_seq                        | sequence | username
 public | stock_genotype                                                  | table    | username
 public | stock_genotype_stock_genotype_id_seq                            | sequence | username
 public | stock_pub                                                       | table    | username
 public | stock_pub_stock_pub_id_seq                                      | sequence | username
 public | stock_relationship                                              | table    | username
 public | stock_relationship_cvterm                                       | table    | username
 public | stock_relationship_cvterm_stock_relationship_cvterm_id_seq      | sequence | username
 public | stock_relationship_pub                                          | table    | username
 public | stock_relationship_pub_stock_relationship_pub_id_seq            | sequence | username
 public | stock_relationship_stock_relationship_id_seq                    | sequence | username
 public | stock_stock_id_seq                                              | sequence | username
 public | stockcollection                                                 | table    | username
 public | stockcollection_stock                                           | table    | username
 public | stockcollection_stock_stockcollection_stock_id_seq              | sequence | username
 public | stockcollection_stockcollection_id_seq                          | sequence | username
 public | stockcollectionprop                                             | table    | username
 public | stockcollectionprop_stockcollectionprop_id_seq                  | sequence | username
 public | stockprop                                                       | table    | username
 public | stockprop_pub                                                   | table    | username
 public | stockprop_pub_stockprop_pub_id_seq                              | sequence | username
 public | stockprop_stockprop_id_seq                                      | sequence | username
 public | study                                                           | table    | username
 public | study_assay                                                     | table    | username
 public | study_assay_study_assay_id_seq                                  | sequence | username
 public | study_study_id_seq                                              | sequence | username
 public | studydesign                                                     | table    | username
 public | studydesign_studydesign_id_seq                                  | sequence | username
 public | studydesignprop                                                 | table    | username
 public | studydesignprop_studydesignprop_id_seq                          | sequence | username
 public | studyfactor                                                     | table    | username
 public | studyfactor_studyfactor_id_seq                                  | sequence | username
 public | studyfactorvalue                                                | table    | username
 public | studyfactorvalue_studyfactorvalue_id_seq                        | sequence | username
 public | studyprop                                                       | table    | username
 public | studyprop_feature                                               | table    | username
 public | studyprop_feature_studyprop_feature_id_seq                      | sequence | username
 public | studyprop_studyprop_id_seq                                      | sequence | username
 public | synonym                                                         | table    | username
 public | synonym_synonym_id_seq                                          | sequence | username
 public | tableinfo                                                       | table    | username
 public | tableinfo_tableinfo_id_seq                                      | sequence | username
 public | treatment                                                       | table    | username
 public | treatment_treatment_id_seq                                      | sequence | username
 public | type_feature_count                                              | view     | username
(380 rows)
	```
	I also created the testing database `dicty_chado` adding the [schema available on github](https://github.com/dictyBase/Test-Chado/blob/develop/share/chado.pg).
	
	
- Other [GMOD PROJECTS](http://gmod.org/wiki/Downloads):
