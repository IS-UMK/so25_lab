#!/bin/bash

function signal_handle
{
   echo "Received signal $1 $2"
}

signal=2

# ustawienie pulapki dla sygnalu 2
trap "signal_handle $signal $(kill -l $signal)" $signal

# TODO: dokonczyc ustawianie pulapki dla pozostalych sygnalow standarowych (od 1 do 31)

while true
do
   sleep 0.1
done











