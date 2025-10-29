#!/bin/bash

if [ "$1" == "-n" ]
then
   printenv | wc -l
   exit 0
fi

for var in "$@"
do
   # TODO: tutaj dokonczyc wypisywanie zmiennych
   echo $var=$(printenv $var)
done

