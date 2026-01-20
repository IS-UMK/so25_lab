#!/bin/bash

s=true
m=false
h=false
d=false
a=false

while getopts  ":amhd" opt
do
   case $opt in
      a) s=false; a=true ;;
      m) s=false; m=true ;;
      h) s=false; h=true ;;
      d) s=false; d=true ;;
   esac
done

shift $((OPTIND-1))

t1=$(uptime -s)
t2="$1"
if [ -z "$t2" ] 
then
   t2=$(date +"%Y-%m-%d %H:%M:%S")
fi

t1=$(date -d "$t1" +"%s" )
t2=$(date -d "$t2" +"%s" )

xs=$((t2-t1))
xm=$(echo "$xs/60" | bc -l)
xh=$(echo "$xm/60" | bc -l)
xd=$(echo "$xh/24" | bc -l)

LC_ALL=C

if $s
then
   printf "uptime %.2f s\n" $xs
fi
if $m
then
   printf "uptime %.2f m\n" $xm
fi

if $h
then
   printf "uptime %.2f h\n" $xh
fi

if $d
then
   printf "uptime %.2f d\n" $xd
fi

if $a
then
   printf "uptime %.2f s\n" $xs
   printf "       %.2f m\n" $xm
   printf "       %.2f h\n" $xh
   printf "       %.2f d\n" $xd
fi









