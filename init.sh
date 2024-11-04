#!/bin/bash
set -o errexit

selection="$(find scripts/ -type f -printf "%f\n" | awk -F '.' '{ print $1 }' | sort | bin/sk --multi --bind 'right:select-all,left:deselect-all,space:toggle+up' --preview="bin/bat --color=always scripts/{}.sh --color=always")"

if test $# -eq 0; then
	_prompt
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
