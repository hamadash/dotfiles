#!/bin/zsh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONF_DIR="${HOME}/.config/gh"

mkdir -p "${CONF_DIR}"

ln -fnsv "${SCRIPT_DIR}/config.yml" "${CONF_DIR}/config.yml"

