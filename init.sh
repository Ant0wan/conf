#!/usr/bin/env bash
set -o errexit
set -o nounset

sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm -y
sudo dnf update -y
sudo dnf install ffmpeg-libs -y




BW_SESSION=$(bw login --raw)
export BW_SESSION

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

for key in $(bw get item gpg | jq -r '.fields[] | @base64'); do
	_jq '.value' | base64 --decode >"$(_jq '.name')"
	SIGNING_KEY="${SIGNING_KEY:+$SIGNING_KEY }$(gpg --import "$(_jq '.name')" 2>&1 | head -n 1 | grep -Eo '[0-9A-Z]{16}+')"
	export SIGNING_KEY
	rm "$(_jq '.name')"
done
sed -i "s/{{signing_key}}/${SIGNING_KEY%% *}/g" "$HOME"/.gitconfig
