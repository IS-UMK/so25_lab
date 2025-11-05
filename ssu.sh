#!/bin/bash

cmd=cat

if [ "$1" == "-s" ]
then
   cmd=sort
fi

n=0
users=""
IFS=:

while read user x uid gid name home shell
do
   if [ $uid -ge 1000 ]
   then
      users="${users}${user}\n"
      let n++
   fi
done < /etc/passwd

echo "liczba uzytkownikow systemu: $n"
echo -e -n "${users}"  | $cmd
