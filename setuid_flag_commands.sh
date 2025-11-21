#!/bin/bash

if [ $# -eq 1 ] && [ $1 == "-h" ];
then
	echo -e "Flags:\n\tDefault ~ Displays all commands with the setuid flag set and rwx for user in /usr/bin, and /usr/sbin\n\n\t-h ~ Displays this help message\n\n\t-f ~ Outputs all commands with the setuid flag set into a file called setuid_commands.txt\n";
	exit 0;
elif [ $# -gt 1 ];
then
	echo "Usage: setuid_flag_commands.sh [-f|-h]" >&2;
	exit 1;
fi

if [ -f setuid_commands.txt ];
then
	rm setuid_commands.txt;
fi

for setuid_command in $(seq 0 5 | xargs -I {} find /usr/bin /sbin /usr/sbin -type f -perm 475{});
do
	if [ $# -eq 1 ] && [ $1 == "-f" ];
	then
		echo $(ls -l $setuid_command) >> setuid_commands.txt;
	else
		echo $(ls -l $setuid_command);
	fi
done
