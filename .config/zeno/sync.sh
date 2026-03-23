#!/bin/zsh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ZENO_CONFIG_DIR="${HOME}/.config/zeno"

mkdir -p "${ZENO_CONFIG_DIR}"

rm -rf "${ZENO_CONFIG_DIR}/"{,.[!.],..?}*

ln -fnsv "${SCRIPT_DIR}/config.yml" "${ZENO_CONFIG_DIR}/config.yml"
