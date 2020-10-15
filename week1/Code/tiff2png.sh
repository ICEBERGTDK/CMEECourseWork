#!/bin/bash

if [ -z "$1" -o ! -e "$1" ]
then 
	echo "Please enter a correct filename"
else
	for f in $1/*.tif;
		do
			echo "Converting $f";
			convert "$f" "${f%tif}jpg";
		done
fi
