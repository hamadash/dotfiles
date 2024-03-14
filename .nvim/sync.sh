#!/bin/zsh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
NVIM_CONF_DIR="${HOME}/.config/nvim"

ln -fnsv "${SCRIPT_DIR}/init.vim" "${NVIM_CONF_DIR}/init.vim"
