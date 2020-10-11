#!bin/bash
if [ -z "$1" -o  -z "$2"  -o ! -e "$1" -o ! -e "$2" ]
then
	echo "Please enter corrct filenames"
elif [ ! -s $1 ]
then
	echo "File1 is empty."
	cat $2 > $3.txt
	echo "Merged File is "
	cat $3.txt
elif [ ! -s $2 ]
then
	echo "File2 is empty."
	cat $1 > $3.txt
	echo "Merged File is "
	cat $3.txt
else
	cat $1 > $3.txt
	cat $2 >> $3.txt
	echo "Merged File is "
	cat $3.txt

fi
#cat $1 > $3.txt
#cat $2 >> $3.txt
#echo "Merged File is "
#cat $3.txt
exit
