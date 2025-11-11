#!/bin/bash

TEST=0

echo "$1 $2"

if [[ $# -lt 2 ]];
then
	echo "Usage: find.sh path pattern";
	exit 1;
fi

for path in $(find $1 -type f);
do
	if [ $TEST -eq 1 ];
	then
		echo $path;
	fi

	if [ $path == "" ];
	then
		echo "find not working";
		exit 1;
	fi

	perl -ne 'print "$ARGV $.: $_" if $_ =~ /'$2'/' $path 2>/dev/null
done

