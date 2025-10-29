#!/bin/bash

LC_ALL=C
echo "Host: $(hostname -f) ($(hostname -i))" 
nazwa=$(grep 'PRETTY_NAME' /etc/os-release | cut -d = -f 2 | tr -d \")
echo "Nazwa dystrybucji i numer wydania: ${nazwa}"
echo "Architektura systemu: $(uname -m)"
echo "Rodzaj i wersja systemu operacyjnego:"  # TODO
echo "Model procesora: $(grep  'model name' /proc/cpuinfo | head -n 1 | cut -d : -f 2)"
echo "Liczba procesorow: $(grep -c 'model name' /proc/cpuinfo)"

tab=( $(grep 'MemTotal:' /proc/meminfo) )
memKiB=${tab[1]}
memGiB=$(echo "scale=4; ${memKiB} / 2^20" | bc)
printf "Pamiec RAM w KiB (GiB): %d (%.4f)\n" ${memKiB} $memGiB
