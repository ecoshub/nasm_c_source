#! /bin/bash
# basm [build assembly]
# assembles the .asm file with nasm -m32
# search given arguments in $lib_path and add them to linker

# example: there is a sandbox.asm file and it needs printx.o file
# if printx.o file is in std lib path ( in this case $lib_path ) than it generates the linker
# end executes it
#      ./basm.bash sandbox.asm printx
#
# if no need for external libs than
#      ./basm.bash sandbox.asm 

if [ "$#" == 0 ]; then
    echo "specify the .asm file"
	exit 127
fi

file=$1
name="${file%.*}"

env_path=$(cat ../.env)
tokens=(${env_path//=/ })
lib_path="$HOME/${tokens[1]}"

libs=""

args=("$@") 
ELEMENTS=${#args[@]} 

for (( i=1;i<$ELEMENTS;i++)); do
	libs+="$lib_path/${args[${i}]}.o"
	if [ "$i" != "$(expr $ELEMENTS - 1)" ]
	then
		# add a place between libs
		libs+=" "
	fi
done

echo "> building $file"
exit=$((nasm -f elf32 -g "$name".asm) 2>&1 )
if [ "$exit" != "" ]
then
	echo "$exit"
	exit 0
fi

echo "> linking with $libs"
if [ "$libs" == "" ]
then
	exit=$((ld -m elf_i386 -o "$name" "$name".o) 2>&1 )
else
	exit=$((ld -m elf_i386 -o "$name" "$name".o $libs) 2>&1 )
fi

if [ "$exit" != "" ]
then
	echo "$exit"
	exit 0
fi
echo "> done."
