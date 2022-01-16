#!/bin/bash

echo '$interfaceName:$IPaddress:$default'
default=`ip r | grep default | awk '{print $5}'`
for interface in $(ip a | grep '<' | awk '{print substr($2, 1, length($2)-1)}')
do
	echo -n $interface:$(ip a show $interface | grep inet | grep -v inet6 | awk '{print $2}')
	for interf in $default
       	do
		if [ $interf = $interface ] 
		then
			echo -n :default
			break
		fi
	done
	echo
done

