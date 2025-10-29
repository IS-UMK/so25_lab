#!/bin/bash

gn=( $(id -nG $1 ) )
gid=( $(id -G $1 ) )

n=${#gn[*]}

for ((i=0; i<n; i++))
do
   echo ${gid[i]} ${gn[i]}
done

