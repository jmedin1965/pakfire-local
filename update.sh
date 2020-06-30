#!/bin/bash

[ -z "$1" -o ! -d "$1" ] && error Usage $(/usr/bin/basename "$0") \<package\>

dir="$(/usr/bin/dirname "$0")"

"$dir/uninstall.sh" "$1" || exit 0
"$dir/install.sh" "$1" || exit 0
