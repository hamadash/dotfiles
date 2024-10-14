#!/bin/zsh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

ln -fnsv "${SCRIPT_DIR}/.cspell.json" "${HOME}/.cspell.json"

