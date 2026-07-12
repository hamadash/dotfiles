#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WEZTERM_CONF_DIR="${HOME}/.config/wezterm"

mkdir -p "${WEZTERM_CONF_DIR}"

find "${WEZTERM_CONF_DIR}" -mindepth 1 -delete

# require() されない参照/バックアップ用ファイルはリンク対象から除外する
is_excluded() {
	case "$1" in
	keybinds_default.lua) return 0 ;;
	*) return 1 ;;
	esac
}

for file in "${SCRIPT_DIR}"/*.lua "${SCRIPT_DIR}"/*.json; do
	[ -e "$file" ] || continue
	filename="$(basename "$file")"
	if is_excluded "$filename"; then
		continue
	fi
	ln -fnsv "$file" "${WEZTERM_CONF_DIR}/${filename}"
done
