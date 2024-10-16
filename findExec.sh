#!/bin/bash

echo "Please type in the instruction that you want to search for:"

read instruction

for file in $(find / -type f);
do
	File=$(file $file | grep ELF)

	if [$File != ""];
	then
		objdump -M intel -d --section .text $file | grep $instruction | perl -pe '$_ = "'$file' $.: $_"' | xargs -0 echo >> Payload.txt
	fi

done
