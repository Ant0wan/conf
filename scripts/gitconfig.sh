#!/bin/sh
if test -e "$HOME"/.gitconfig; then
	echo "Git already configured."
	exit 0
fi
if ! command -v git >/dev/null 2>&1; then
	echo "Git is required."
	script_dir=$(dirname "$0")
	. "$script_dir/git.install.sh"
fi
if ! command -v bw >/dev/null 2>&1; then
	echo "BitWarden CLI is required."
	script_dir=$(dirname "$0")
	. "$script_dir/bitwarden.install.sh"
fi
githubsource="https://raw.githubusercontent.com/Ant0wan/conf/main/"
wget "${githubsource}gitconfig" -O "$HOME"/.gitconfig
mkdir -p ~/.git-templates/hooks
# Could copy all hooks from there
wget "${githubsource}gitignore" -O "$HOME"/.gitignore
if test -z "$BW_SESSION"; then
	BW_SESSION=$(bw login --raw)
	export BW_SESSION
fi
_jq() {
	echo "${key}" | base64 --decode | jq -r "${1}"
}
for key in $(bw get item gpg | jq -r '.fields[] | @base64'); do
	_jq '.value' | base64 --decode >"$(_jq '.name')"
	SIGNING_KEY="${SIGNING_KEY:+$SIGNING_KEY }$(gpg --import "$(_jq '.name')" 2>&1 | head -n 1 | grep -Eo '[0-9A-Z]{16}+')"
	export SIGNING_KEY
	rm "$(_jq '.name')"
done
sed -i "s/{{signing_key}}/${SIGNING_KEY%% *}/g" "$HOME"/.gitconfig
bw logout
