# makelib
# makes .o file from .asm file
# and copies it to given pat ( lib_path)
# not fancy script

# example: simply run it and give it a .asm file
#	./makelib.bash any.asm

lib_path="$HOME/assembly/lib"
suffix="_dbg"
file=$1
name="${file%.*}"
if [ "$file" == "" ]
then
	echo "there is no file with ext. '.asm'"
	exit 127
fi

echo "> building $file with debug"
exit=$((nasm -f elf32 -g "$name".asm -o "$name$suffix".o) 2>&1 )
if [ "$exit" != "" ]
then
	echo "$exit"
	exit 0
fi

echo "> building $file without debug"
exit=$((nasm -f elf32 "$name".asm -o "$name".o) 2>&1 )
if [ "$exit" != "" ]
then
	echo "$exit"
	exit 0
fi


$(mv "$name".o "$lib_path")
$(mv "$name$suffix".o "$lib_path")
echo created as $lib_path/$name.o
echo created as $lib_path/"$name$suffix".o
