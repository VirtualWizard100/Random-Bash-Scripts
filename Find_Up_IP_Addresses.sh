#!/bin/bash

#You can change the input and output files to argv arguements

if [ $# -lt 3 ];
then
	echo "Usage: Find_Up_IP_Addresses.sh empty_infile outfile address_subnet (Example: \"172.16.10.\")";
	exit 1;
fi

if [ ! -f $1 ];
then
	seq 1 255 | xargs -I {} echo $3{} >> $1;
fi

if [ ! -f $2 ];
then
	touch $2;
fi

while true;
do
	for Address in $(nmap -sP -iL $1 | grep -B1 "Host is up" | awk '{ print $5 }' | grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}");
	do
		if ! grep -q -F "$Address" $2;
		then
			echo "Found new address: ${Address}";
			echo $Address >> $2;
		fi
	done
done
