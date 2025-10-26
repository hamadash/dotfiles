#!/bin/zsh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
STARSHIP_CONF_DIR="${HOME}/.config"

ln -fnsv "${SCRIPT_DIR}/starship.toml" "${STARSHIP_CONF_DIR}/starship.toml"

