#!/bin/zsh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LAZYGIT_CONF_DIR="${HOME}/Library/Application Support/lazygit"

ln -fnsv "${SCRIPT_DIR}/config.yml" "${LAZYGIT_CONF_DIR}/config.yml"

