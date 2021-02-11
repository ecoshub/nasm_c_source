# makelib
# makes .o file from .asm file
# and copies it to given pat ( lib_path)
# not fancy script

# example: simply run it in directory that has a .asm file
#	./makelib.bash

lib_path="/home/eco/assembly/lib"
file=$(ls | grep ".*\.\(asm\)")
if [ "$file" == "" ]
then
	echo "there is no file with ext. '.asm'"
	exit 127
fi

name="${file%.*}"
echo "> building $file"
exit=$((nasm -f elf32 -g "$name".asm) 2>&1 )
if [ "$exit" != "" ]
then
	echo "$exit"
	exit 0
fi

exit=$(mv "$name".o "$lib_path")
if [ "$exit" != "" ]
then
	echo "$exit"
	exit 0
fi

echo "created as $lib_path/$name.o"
