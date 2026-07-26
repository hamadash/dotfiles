#!/bin/zsh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MISE_CONFIG_DIR="${HOME}/.config/mise"

mkdir -p "${MISE_CONFIG_DIR}"

rm -rf "${MISE_CONFIG_DIR}/"{,.[!.],..?}*

ln -fnsv "${SCRIPT_DIR}/config.toml" "${MISE_CONFIG_DIR}/config.toml"
