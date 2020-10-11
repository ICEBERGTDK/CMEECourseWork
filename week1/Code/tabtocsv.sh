#!/bin/sh
# Author: dengkui.tang20@imperial.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas
#
# Saves the output into a  .csv file
# Arguments: 1 -> tab delimited file
# Date: Oct 2020

echo "Creating a comma delimited version of $1 ..."
#while  "$1"-z"Test.txt"
if [ -z "$1" ]
then
	echo "Please enter a correct filename $1"
elif [ -f $1.csv ]
then 
	echo "The csv file is already exist. Do you want to replace it?" $ans
	read ans
	if [ $ans == "y" ]
	then
		cat $1 | tr -s "\t" "," > $1.csv
		echo "Done!"
	else
		echo "ok."
	fi
elif [[ $1 == *.csv ]]
then
	echo "The file is already a csv file."
elif [ ! -s $1 ]
then
	echo "The file is empty."
else
	cat $1 | tr -s "\t" "," >> $1.csv
	echo "Done!"
fi

exit
