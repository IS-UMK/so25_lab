#!/bin/bash

function suma
{
   local n=0
   for x
   do
      n=$((n+x))
   done
   echo $n
}

f=/proc/interrupts
cmd=cat

while getopts ":sf:" opt
do
   case $opt in
      s) cmd="sort -nrk 1"  ;;
      f) f="$OPTARG" ;;
      \?) echo "Nieznana opcja: -$OPTARG" >&2
      ;;
   esac
done
shift $((OPTIND -1))

# echo "f=$f"
# echo "s=$s"

ncpu=$(head -n 1 "$f"  | wc -w)

while read -a linia
do
   if [[ ${linia[0]} =~ ^[0-9]+:$ ]]
   then
      nirq=$(suma ${linia[*]:1:$ncpu})
      name=${linia[*]:$((ncpu+3))}
      irq=${linia[0]%:}
      printf "%-10d %-10s %s\n" ${nirq} ${irq} "${name}"
   fi
done < "$f" | ${cmd}

linia=( $( grep '^LOC:' "$f" ) )
nirq=$(suma ${linia[*]:1:$ncpu})
name=${linia[*]:$((ncpu+1))}
printf "%-10d %s\n" ${nirq} "${name}"

