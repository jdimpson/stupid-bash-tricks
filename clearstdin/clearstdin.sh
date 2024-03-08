#!/bin/bash

clearstdin() {
	while read -r -t 0; do read -n 256 -r; done
}

main() {
	local SEC;
	SEC=5;
	echo "sleeping for $SEC seconds. In that time, anything typed will be ignored";
	sleep $SEC;
	clearstdin;
	#read -e -i "default" -p "type something and hit ENTER: " INP;
	read -e -p "type something and hit ENTER: " INP;
	echo;
	echo "you said $INP";
	echo;
}

while true; do
	main;
done
