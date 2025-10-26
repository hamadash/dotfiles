#!/bin/zsh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONF_DIR="${HOME}/.config/borders"

mkdir "${CONF_DIR}/"

rm -rf "${CONF_DIR}/"{,.[!.],..?}*

ln -fnsv "${SCRIPT_DIR}/bordersrc" "${CONF_DIR}/bordersrc"
