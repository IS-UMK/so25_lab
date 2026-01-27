#!/bin/bash

if [ ! -e "$1" ]
then
   echo "Plik $1 nie istnieje"
   exit 1
fi

file=$(realpath "$1")

while [ "$file" != "/" ]
do
   inode=$(stat -c "%i" "$file")
   bname=$(basename "$file")
   dname=$(dirname "$file")
   printf "%-15s %-20s %10d\n" "$bname" "$dname" $inode
   file="$dname"
done





