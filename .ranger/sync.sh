#!/bin/zsh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
RANGER_CONF_DIR="${HOME}/.config/ranger"

ln -fnsv "${SCRIPT_DIR}/commands_full.py" "${RANGER_CONF_DIR}/commands_full.py"
ln -fnsv "${SCRIPT_DIR}/commands.py" "${RANGER_CONF_DIR}/commands.py"
ln -fnsv "${SCRIPT_DIR}/rc.conf" "${RANGER_CONF_DIR}/rc.conf"
ln -fnsv "${SCRIPT_DIR}/rifle.conf" "${RANGER_CONF_DIR}/rifle.conf"
ln -fnsv "${SCRIPT_DIR}/scope.sh" "${RANGER_CONF_DIR}/scope.sh"
