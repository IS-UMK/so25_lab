#!/bin/bash

IFS=:

while read user x uid gid name home shell
do
   if [[ "$user" =~ $1 ]]
   then
      echo "User: $user"
      echo "Name: $name"
      echo "Home: $home"
      echo "Shell: $shell"
      echo "Last login: TODO"

      if [ -r ${home}/.plan ]
      then
         cat ${home}/.plan
      else
         echo "No Plan."
      fi

      echo 
   fi
done < /etc/passwd
