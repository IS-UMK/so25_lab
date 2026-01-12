#!/bin/bash

file=/tmp/pipe-server-$$
echo "[server] fifo created: $file"


mkfifo $file

trap "rm -f $file" EXIT


function worker
{
   echo "[worker] Start"
   while true
   do
      while read cmd < "$1"
      do
         echo "[worker] recived: $cmd"
         tab=( $cmd )
         if type ${tab[0]} &> /dev/null
         then
            $cmd > "$1"
         else 
            echo "error: unknown command" > "$1"
         fi
      done
   done
}

while true
do
   echo "[server] listening"
   while read line < $file
   do
      echo "[servwr] recived: $line"
      if [ -p "$line" ]
      then
         worker "$line" &
      fi
   done
done
