#!/bin/sh
set -e
cd "$(dirname "$0")"
PWD="$(pwd)"

clone_dir() {
	local dir=${1:-home}
	local to=${2:-$HOME}

	[ "$dir" != "home" ] && mkdir -p "$to/.${dir#home/}"
	for f in $dir/*; do
		if [ -d "$f" ]; then
			clone_dir "$f" "$to"
		elif [ -f "$f" ]; then
			ln -sf "$PWD/$f" "$to/.${f#home/}"
		fi
	done
}

for d in */; do
	clone_dir "${d%/}"
done
