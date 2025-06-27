#!/bin/sh
if test -e "$HOME"/.gitconfig; then
	echo "Git already configured."
	exit 0
fi
if ! command -v git >/dev/null 2>&1; then
	echo "Git is required."
	script_dir=$(dirname "$0")
	. "$script_dir/git.sh"
fi
if ! command -v bw >/dev/null 2>&1; then
	echo "BitWarden CLI is required."
	script_dir=$(dirname "$0")
	. "$script_dir/bitwarden.sh"
fi
githubsource="https://raw.githubusercontent.com/Ant0wan/conf/main/"
if [ "$(basename $(pwd))" = "scripts" ]; then
	cp "$(dirname $(pwd))"/gitconfig "$HOME"/.gitconfig
elif test -e "$0"; then
	cp gitconfig "$HOME"/.gitconfig
else
	wget "${githubsource}gitconfig" -O "$HOME"/.gitconfig
fi
mkdir -p ~/.git-templates/hooks
# Could copy all hooks from there
if [ "$(basename $(pwd))" = "scripts" ]; then
	cp "$(dirname $(pwd))"/gitignore "$HOME"/.gitignore
elif test -e "$0"; then
	cp gitignore "$HOME"/.gitignore
else
	wget "${githubsource}gitignore" -O "$HOME"/.gitignore
fi
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
