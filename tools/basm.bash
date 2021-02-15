#! /bin/bash
# basm [build assembly]
# find .asm file
# assemble it with nasm -m32
# search given arguments in $lib_path and add them to linker

# example: there is a sandbox.asm file and it needs printx.o file
# if printx.o file is in std lib path ( in this case $lib_path ) than it generates the linker
# end executes it
#      ./basm.bash printx
#
# if no need for external libs than
#      ./basm.bash 

file=$(ls | grep ".*\.\(asm\)")
if [ "$file" == "" ]
then
	echo "there is no file with ext. '.asm'"
	exit 127
fi

name="${file%.*}"
lib_path="/home/eco/assembly/lib"
libs=""

args=("$@") 
ELEMENTS=${#args[@]} 

for (( i=0;i<$ELEMENTS;i++)); do
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
