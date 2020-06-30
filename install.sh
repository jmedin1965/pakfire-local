#!/bin/bash

error()
{
	echo "$@" > /dev/stderr
	exit 1
}

[ -z "$1" -o ! -d "$1" ] && error Usage $(/usr/bin/basename "$0") \<package\>

[ -e "$1/ROOTFILES" ] && error "Error: package already installed, use uninstall.sh or update.sh"

pushd .

cd "$1/files" || error "Unable to change dir to $1/files"

while read file
do
	file="${file#.}"
	if [ -n "$file" -a ! -d ".$file" ]
	then
		echo install file: $file
		/bin/mkdir -p "$(/usr/bin/dirname "$file")"
		/bin/cp -a ".$file" "$file"
		echo $file >> ../ROOTFILES
	fi
done <<< "$(/bin/find)"

cd ..
[ -x "./post-install.sh" ] && "./post-install.sh"

popd
