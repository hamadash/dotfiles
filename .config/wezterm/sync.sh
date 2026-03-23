#!/bin/zsh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WEZTERM_CONF_DIR="${HOME}/.config/wezterm"

mkdir -p "${WEZTERM_CONF_DIR}"

rm -rf "${WEZTERM_CONF_DIR}/"{,.[!.],..?}*

ln -fnsv "${SCRIPT_DIR}/wezterm.lua" "${WEZTERM_CONF_DIR}/wezterm.lua"
ln -fnsv "${SCRIPT_DIR}/keybinds.lua" "${WEZTERM_CONF_DIR}/keybinds.lua"
ln -fnsv "${SCRIPT_DIR}/appearance.lua" "${WEZTERM_CONF_DIR}/appearance.lua"
ln -fnsv "${SCRIPT_DIR}/workspace.lua" "${WEZTERM_CONF_DIR}/workspace.lua"
ln -fnsv "${SCRIPT_DIR}/workspaces.json" "${WEZTERM_CONF_DIR}/workspaces.json"
