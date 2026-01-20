#!/bin/bash

unit=s

while getopts  ":amhd" opt
do
   case $opt in
      a|m|h|d) unit=$opt
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

xs=$((t2-t1))                  # czas w sekundach
xm=$(echo "$xs/60" | bc -l)    # czas w minutach
xh=$(echo "$xm/60" | bc -l)    # czas w godzinach
xd=$(echo "$xh/24" | bc -l)    # czas w dniach

LC_ALL=C

[[ "$unit" == s ]] &&  printf "uptime %.2f s\n" $xs
[[ "$unit" == m ]] &&  printf "uptime %.2f m\n" $xm
[[ "$unit" == h ]] &&  printf "uptime %.2f h\n" $xh
[[ "$unit" == d ]] &&  printf "uptime %.2f d\n" $xd

if [[ $unit == a ]]
then
   printf "uptime %.2f s\n" $xs
   printf "       %.2f m\n" $xm
   printf "       %.2f h\n" $xh
   printf "       %.2f d\n" $xd
fi
