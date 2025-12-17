#!/bin/bash

LC_ALL=C

sort_opts="-k 3 -n -r"
dane=$(ps -eo user,uid,pmem,pcpu,comm | sed 1d)

s=false
u=false

while getopts ":suncmf:" opt
do
   case $opt in
     s) s=true ;; 
     u) u=true ;; 
     n) sort_opts="" ;;
     c) sort_opts="-k 2 -n -r" ;; 
     m) sort_opts="-k 4 -n -r";; 
     f) dane=$(sed 1d "$OPTARG") ;;
   esac
done

declare -A tpc
declare -A tpcpu
declare -A tpmem

while read user uid pmem pcpu comm
do
   $s && [ "$uid" -ge 1000 ] && continue       #  pomijaj zwyklych uzytkonikow, gdy opcja -s i uid >= 1000
   $u && [ "$uid" -lt 1000 ] && continue       #  pomijaj konta systemowe, gdy opcja -u i uid < 1000
   tpc[$user]=$((tpc[$user] + 1))
   tpcpu[$user]=$( echo "scale=1; ${tpcpu[$user]:-0.0} + $pcpu" | bc )
   tpmem[$user]=$( echo "scale=1; ${tpmem[$user]:-0.0} + $pmem" | bc )
done <<< "${dane}"

for user in ${!tpc[*]}
do
   printf "%-10s %5d %5.1f %5.1f\n" $user ${tpc[$user]} ${tpcpu[$user]} ${tpmem[$user]}
done  | sort ${sort_opts}
