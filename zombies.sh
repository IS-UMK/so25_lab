#!/bin/bash

function create_zombies 
{
   for i in $(seq $1)
   do
      sleep 1 &
   done

   wait
}

create_zombies ${1-10} &
pid=$!

sleep 0.3

kill -19 $pid

# sleep 1.3

# ps -o s,pid,ppid,args

while true
do
   sleep 0.1
done
