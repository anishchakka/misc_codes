#! /bin/bash

# file with list of file names
file=$1

while IFS= read -r line
do
	if [ ! -f "$line" ]; then
	    echo "$line does not exist."
	fi
done < "$file"