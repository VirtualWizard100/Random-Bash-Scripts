#!/bin/bash

echo "Please type in the instruction that you wan to search for:"

read instruction

for file in $(find / -type f);
do
	File=$(file $file | grep ELF)

	if [$File != ""];
	then
		objdump -M intel -d --section .text $file | grep $instruction | xargs -0 echo >> Payload.txt
	fi

done
