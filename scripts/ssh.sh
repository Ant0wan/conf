#!/bin/sh
set -o errexit
if [ -f /etc/fedora-release ]; then
	sudo dnf install -y ssh
elif [ -f /etc/lsb-release ] || [ -f /etc/os-release ] ; then
	sudo apt-get update
	sudo apt-get install -y ssh
else
	echo "Unsupported distribution. This script only supports Fedora and Ubuntu."
	exit 1
fi
if test -e "$HOME"/.ssh/github; then
	echo "SSH already configure."
	exit 0
fi
if ! command -v bw >/dev/null 2>&1; then
	echo "BitWarden CLI is required."
	script_dir=$(dirname "$0")
	. "$script_dir/bitwarden.sh"
fi
if test -z "$BW_SESSION"; then
    BW_SESSION=$(bw login --raw)
    export BW_SESSION
fi
_jq() {
	echo "${key}" | base64 --decode | jq -r "${1}"
}
mkdir -p "$HOME"/.ssh
eval "$(ssh-agent -s)"
for key in $(bw get item ssh | jq -r '.fields[] | @base64'); do
	_jq '.value' | base64 --decode >"$HOME"/.ssh/"$(_jq '.name')"
	case "$(_jq '.name')" in
	*".pub")
		chmod 0644 "$HOME"/.ssh/"$(_jq '.name')"
		;;
	*)
		chmod 0600 "$HOME"/.ssh/"$(_jq '.name')"
		ssh-add "$HOME"/.ssh/"$(_jq '.name')"
		;;
	esac
done
sudo systemctl restart sshd
bw logout
