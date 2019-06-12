
Nicknames:


#############################
# Generating the names:
#############################

The following  files are used to generate names in nickname:rootname
format.  These names redirected into a master nickname list, and then
that is used to create the data for the Nicknames.pm module.

Some information is also found in comments in the scripts and text files.

* gen_nicknames_1.pl:

This generates a list of names taken from the Perl Module
Ligua::EN:Nicknames.  The module is lacking some key functionality,
namely deriving a list of nicknames from a name.

It is also very poorly documented, and written in a rather 
confusing manner.  Rather than use it, I am just generating 
names from it.

* gen_nicknames_2.pl

Generate nickname list from data found in work2.txt

* gen_nicknames_3.pl

Generate nickname list from data found in work3.txt

#############################
# Generating the module data:
#############################


  ./gen_nicknames_1.pl > nicknames.tmp
  ./gen_nicknames_2.pl >> nicknames.tmp
  ./gen_nicknames_3.pl >> nicknames.tmp

there are multiple sources for nicknames
weed out the duplicates

  sort nicknames.tmp | uniq > nicknames.txt

Now generate the data structures

  ./gen_nicknames_data.pl  | grep -vE "VAR1 =|};$" > nicknames.dat

Now create the package file:

  ./gen_nicknames_pkg.pl > Nicknames.pm


gen_nicknames.sh:

This shell script runs everything for you.  
Just be sure the Nicknames.pm file is writable.


