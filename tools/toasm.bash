#! /bin/bash

file=$1
name="${file%.*}"
$(gcc -fno-asynchronous-unwind-tables -s -c -o "$name".o "$name".c && objdump -D "$name".o > "$name".s)
$(rm "$name".o)
