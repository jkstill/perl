:

printf "Generating nicknames 1\n"
./gen_nicknames_1.pl > nicknames.tmp
printf "Generating nicknames 2\n"
./gen_nicknames_2.pl >> nicknames.tmp
printf "Generating nicknames 3\n"
./gen_nicknames_3.pl >> nicknames.tmp

# there are multiple sources for nicknames
# weed out the duplicates

sort nicknames.tmp | uniq > nicknames.txt
rm -f nicknames.tmp

./gen_nicknames_data.pl  | grep -vE "VAR1 =|};$" > nicknames.dat

rm -f nicknames.txt

./gen_nicknames_pkg.pl > Nicknames.pm

rm -f nicknames.dat

echo
echo Nicknames.pm has been generated
echo check it into RCS
echo 


