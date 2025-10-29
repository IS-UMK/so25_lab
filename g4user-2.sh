#!/bin/bash


grnames=( $(id -nG $1) ) 
echo $?


grids=( $(id -G $1) )

n=${#grnames[*]}

for ((i=0; i<n;i++))
do
   echo ${grids[i]} ${grnames[i]}
done




