#!/bin/bash

echo $(ac -p | LC_ALL=C sort -n -k 2 -r | grep -v '|<root\>' | head -n 2  | tail -n 1)
