#!/bin/bash

node='Node 0'
zone='Normal'
a=false
s=false
file=/proc/buddyinfo

while getopts ":f:asn:z:" opt
do
   case $opt in 
      f) file="$OPTARG" ;;
      a) a=true ;;
      s) s=true ;;
      n) node="$OPTARG" ;;
      z) zone="$OPTARG" ;;
   esac
done

shift $((OPTIND-1))

orders="$*"

if $a 
then
   orders=$(seq 0 10)
fi

# grep "^${node}, zone \+${zone} " "${file}" | sed "s/^.*${zone}//"

buddy=( $(grep "^${node}, zone \+${zone} " "${file}" | sed "s/^.*${zone}//" )   )

pagesize=$(getconf PAGE_SIZE)

function buddy_size
{
   o=$1
   n=$2
   echo "scale=2; 2^$o * $pagesize * $n / 2^20" | bc
}


total=0
for order in ${orders}
do
   x=$(buddy_size $order ${buddy[$order]})
   echo $order ${buddy[$order]} $x
   total=$(echo "$total + $x" | bc -l )
done

if $s
then
   echo $total
fi

