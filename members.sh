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
pusers=$(grep "^.*:.*:.*:$gid:" /etc/passwd | cut -d : -f 1)

# lista urzytkownikow dodanych do grupy
susers=$(grep "^.*:.*:$gid:" /etc/group | cut -f 4 -d : | tr ',' '\n')

users=""

if $p 
then
   users+="${pusers}\n" 
fi

if $s 
then
   users+="${susers}\n" 
fi

if [ $p == false ] && [ $s == false ]
then
   users="${pusers}\n${susers}\n"
fi

echo -n -e "${users}" | sort
