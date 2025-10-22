#!/bin/bash

echo "Host: $(hostname -f) ($(hostname -i))" 
nazwa=$(grep 'PRETTY_NAME' /etc/os-release | cut -d = -f 2 | tr -d \")
echo "Nazwa dystrybucji i numer wydania: ${nazwa}"
echo "Architektura systemu: $(uname -m)"
