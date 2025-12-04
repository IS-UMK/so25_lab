#!/bin/bash

regex="$1"

if [ ! "$regex" ]
then
   regex='.*'
fi

file=$(find /usr/include/ -name unistd_64.h | sed 1q)

if [ ! -r "$file" ]
then
	echo "Plik unistd_64.h nie zostal znaleziony."
	exit 1
fi

sed -n 's/^#define __NR_//p' "${file}" | sed -E -n  "/${regex}/p" 




