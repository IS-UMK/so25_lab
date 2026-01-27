#!/bin/bash

if [ ! -d "$1" ]
then
   echo "$1 nie jest katalogiem"
   exit 1
fi

list=$(ls -a "$1")

declare -A types
types=([-f]="Regular files:" [-d]="Directories:"  [-L]="Symbolic links:" [-b]="Block devices:" [-c]="Character devices:" [-p]="Named pipes:" [-S]="Sockets:")

for type in -f -d -L -b -c -p -S
do
   n=0
   output=""
   while read file
   do
      if [ $type != -L ] && [ -L "$1/$file" ] 
      then
         continue
      fi
      if [ "$type" "$1/$file" ]
      then
         let n++
         output="${output}${file}\n"
      fi
   done <<< "${list}"

   echo ${types[$type]} $n
   echo -e "${output}"
done