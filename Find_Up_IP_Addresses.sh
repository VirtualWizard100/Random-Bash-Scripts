#!/bin/bash

#You can change the input and output files to argv arguements

if [ ! -f 172-16-10-addresses.txt ];
then
	seq 1 255 | xargs -I {} echo "172.16.10."{} >> 172-16-10-addresses.txt;
fi

if [ ! -f 172-16-10-up-addresses.txt ];
then
	touch 172-16-10-up-addresses.txt;
fi

while true;
do
	for Address in $(nmap -sP -iL 172-16-10-addresses.txt | grep -B1 "Host is up" | awk '{ print $5 }' | grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}");
	do
		if ! grep -q -F "$Address" 172-16-10-up-addresses.txt;
		then
			echo "Found new address: ${Address}";
			echo $Address >> 172-16-10-up-addresses.txt;
		fi
	done
done
