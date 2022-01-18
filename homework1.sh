#!/bin/bash

default=`ip r | grep default | awk '{print $5}'`
for interface in $(ip a | grep '<' | awk '{print substr($2, 1, length($2)-1)}')
do
	echo -n -e '\033[0;31m'$interface'\033[0m':'\033[0;35m'$(ip a show $interface | grep inet | grep -v inet6 | awk '{print $2}')'\033[0m'
	for interf in $default
       	do
		if [ $interf = $interface ] 
		then
			echo -n -e ':\033[0;32mdefault\033[0m'
			break
		fi
	done
	echo
done

