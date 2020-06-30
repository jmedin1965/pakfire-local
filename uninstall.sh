#!/bin/bash

error()
{
	echo "$@" > /dev/stderr
	exit 1
}

[ -z "$1" -o ! -d "$1" ] && error Usage $(/usr/bin/basename "$0") \<package\>

[ -e "$1/ROOTFILES" ] || error "Error: package not installed, use install.sh"

/etc/init.d/barios-fd stop

while read file
do
	echo uninstall file: $file
	/bin/rm -f "$file" || error "Error: unable to uninstall $file, aborting"
done <<< "$(/bin/cat "$1/ROOTFILES")"

/bin/rm -f "$1/ROOTFILES"
/bin/rm -rf /var/lib/bareos

/sbin/ldconfig

