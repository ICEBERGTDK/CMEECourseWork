#!bin/bash

if [ -z "$1" -o ! -e "$1" ]
then 
	echo "Please enter a correct filename"
elif [[ "$1" != *.csv ]]
then
	echo "Please enter a .csv file"
elif [ ! -s $1 ]
then
	echo "The file is empty"
elif [ -f $1.txt ]
then
	echo "$1.txt is already exist."
else 
	echo "take a csv to a space separated values file."
	cat $1 | tr -s "," "\b" >> $1.txt
	echo "Done!"
fi
exit
