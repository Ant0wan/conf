#!/bin/bash
set -o errexit

if test $# -eq 0; then
	selection="$(find scripts/ -type f -printf "%f\n" | awk -F '.' '{ print $1 }' | sort | sk --multi --bind 'right:select-all,left:deselect-all,space:toggle+up' --preview="batcat --color=always scripts/{}.sh --color=always" --preview-window 'right:70%')"
else
	selection="$(echo "$@" | tr ' ' '\n' | sort -u | tr '\n' ' ' | xargs echo | sort)"
	echo "$selection"
fi

for i in $selection; do
	[ -e "scripts/$i.sh" ] && bash "scripts/$i.sh"

	if test -e "bashrc.d/$i"; then
		mkdir -p "$HOME/.bashrc.d/"
		cp "bashrc.d/$i" "$HOME/.bashrc.d/$i"
	fi
done

if test -n "$BW_SESSION"; then
    bw logout
    unset BW_SESSION
fi

rm -rf "${download_path}"
