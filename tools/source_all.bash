#! /bin/bash

source_path="$HOME/assembly/source"

find "$source_path" -name '*.asm' -exec ./makelib.bash {} \;
