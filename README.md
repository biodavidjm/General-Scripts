General-Scripts
===============

Scripts to provide punctual solutions to small problems


## Data requested by users

* ``update_curated_mutant_with_ddbg_id.pl``:

updates the all-mutants.txt file from the ___Download___ section of the dictyweb with an additional column mapping the DDB_G_ID from the list of genes found in column 3. 



## Installations on the Mac
by @biodavidjm

Compilation of all the installations on my machine.

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
- Modware loader from github

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

The preliminary conclusion is that now it is possible to develop perl DBI scripts from a Mac OS X (64 bits).


### Development
- Perl CPAN (but it is better to use cpanm)
- Perl cpanm (it is better to use.
	- sudo cpanm Modern::Perl
	- sudo cpanm plenv: PLENV sets up a box environment. It basically isolates your home from the system.
	- sudo cpanm Module::Starter
	- sudo cpanm -n  git://github.com/dictyBase/Modware-Loader.git

	**Do not install Test-Chado**
	- Sqitch is a database change management application. Use it when planning to do changes in the database to keep track
		- sudo cpanm App::Sqitch DBD::Pg
* Perlbrew: cpanm App::perlbrew, although the best option is to follow the instructions [online](http://search.cpan.org/~gugod/App-perlbrew-0.67/lib/App/perlbrew.pm). I followed these steps:

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
```


* Perl Object Oriented related
	- cpanm Moose
	- cpanm Moose::Manual

- perl-5.18.2.tar.gz (locally)
- Homebrew: it needed to install the Xcode. And using brew I installed:

- RUBY: brew install ruby
- GO programming language: brew install go
- Github for Mac
- Vagrant: to manage virtual Linux from the command line. It uses VirtualBox (already installed) in the computer.

- npm, the official package manager for Node.js. (brew install)
	- npm install -g yo
- Sass: sudo gem install sass
- Hydo: HTML5 editor

### Web development

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
