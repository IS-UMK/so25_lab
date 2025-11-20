#!/bin/bash

s=false
p=false

while getopts ":sp" opt; do
   case $opt in
      s) s=true 
      ;;
      p) p=true
      ;;
      \?) echo "Bledna opcja -$OPTARG" 
         exit 1
         ;;
   esac
done

shift $((OPTIND-1))

gid=$1

if [[ ! "$1" =~ ^[0-9]+$ ]]
then
   gid=$(grep ^$1: /etc/group | cut -f 3 -d :)
fi

# lista urzytkownikow grupy podstawowej
gp=$(grep "^.*:.*:.*:$gid:" /etc/passwd | cut -d : -f 1)

# lista urzytkownikow dodanych do grupy
gs=$(grep "^.*:.*:$gid:" /etc/group | cut -f 4 -d : | tr ',' '\n')

if $p 
then
   echo "$gp" 
elif $s 
then
   echo "$gs" 
else
   echo -n -e "$gp\n$gs" 
fi | sort
