#! /bin/bash

# if transferring excel txt file to unix, use the below command
# sed -i sed 's/\r$//' input_file.txt

# file with list of file names
file=$1

while IFS= read -r line
do
	if [ ! -f "$line" ]; then
	    echo "$line does not exist."
	fi
done < "$file"
