#!/bin/zsh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CODEX_SET_DIR="${HOME}/.codex"

ln -fnsv "${SCRIPT_DIR}/AGENTS.md" "${CODEX_SET_DIR}/AGENTS.md"
ln -fnsv "${SCRIPT_DIR}/config.toml" "${CODEX_SET_DIR}/config.toml"

