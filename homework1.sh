#!/bin/bash

echo '$interfaceName:$IPaddress:$default'
default=`ip r | grep default | awk '{print $5}'`
for interface in $(ip a | grep '<' | awk '{print substr($2, 1, length($2)-1)}')
do
	echo -n $interface:$(ip a show $interface | grep inet | grep -v inet6 | awk '{print $2}')
	if [ $default = $interface ] 
	then
		echo :default
	else
		echo
	fi
done

