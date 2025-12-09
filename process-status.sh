#!/bin/bash

dane=$(ps -e -o user,s,pid,tgid,lwp,nlwp,rss,args | sed 1d)
user=""

while getopts ":f:u:" opt
do
   case $opt in
      f) dane=$(sed 1d "$OPTARG") 
      ;;
      u) user="$OPTARG"
   esac
done

# echo "${dane}"

if [ "$user" ]
then
   for state in R S T D I Z
   do
      awk -v state="$state" -v user="$user" -v n=0 '$2 == state && $1 == user {n+=$6} END {print state"="n}' <<< "${dane}" 
   done
else
   echo "TODO: nie skonczone"
fi







