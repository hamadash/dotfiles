#!/bin/zsh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WEZTERM_CONF_DIR="${HOME}/.config/wezterm"

mkdir -p "${WEZTERM_CONF_DIR}"

rm -rf "${WEZTERM_CONF_DIR}/"{,.[!.],..?}*

ln -fnsv "${SCRIPT_DIR}/wezterm.lua" "${WEZTERM_CONF_DIR}/wezterm.lua"
ln -fnsv "${SCRIPT_DIR}/keybinds.lua" "${WEZTERM_CONF_DIR}/keybinds.lua"

