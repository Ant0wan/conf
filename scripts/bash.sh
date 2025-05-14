#!/bin/sh
set -o errexit
set -o nounset

append_rc() {
		printf '
# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

' >> ~/.bashrc
}

if test -e ~/.bashrc; then
	if ! grep -Fxq '	for rc in ~/.bashrc.d/*; do' ~/.bashrc; then
		append_rc
	fi
else
	if test -e /etc/skel/.bashrc; then
		cp /etc/skel/.bashrc ~
		append_rc
	else
		if [ "$(basename $(pwd))" = "scripts" ]; then
			cp "$(dirname $(pwd))"/bashrc "$HOME"/.bashrc
		elif test -e "$0"; then
			cp bashrc "$HOME"/.bashrc
		else
			githubsource="https://raw.githubusercontent.com/Ant0wan/conf/main/"
			wget "${githubsource}bashrc" -O "$HOME"/.bashrc
		fi
	fi
fi
mkdir -p "$HOME"/.bashrc.d/
