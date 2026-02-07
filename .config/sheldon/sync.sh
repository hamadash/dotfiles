#!/bin/zsh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SHELDON_CONFIG_DIR="${HOME}/.config/sheldon"

rm -rf "${SHELDON_CONFIG_DIR}/"{,.[!.],..?}*

ln -fnsv "${SCRIPT_DIR}/plugins.toml" "${SHELDON_CONFIG_DIR}/plugins.toml"
