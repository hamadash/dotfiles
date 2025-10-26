#!/bin/zsh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_SET_DIR="${HOME}/.claude"

# Link CLAUDE.md
ln -fnsv "${SCRIPT_DIR}/CLAUDE.md" "${CLAUDE_SET_DIR}/CLAUDE.md"

# Link settings.json
ln -fnsv "${SCRIPT_DIR}/settings.json" "${CLAUDE_SET_DIR}/settings.json"

CLAUDE_COMMANDS_DIR="${CLAUDE_SET_DIR}/commands"
mkdir -p "${CLAUDE_COMMANDS_DIR}"
for command_file in "${SCRIPT_DIR}"/commands/*.md; do
    file_name=$(basename "${command_file}")
    ln -fnsv "${command_file}" "${CLAUDE_COMMANDS_DIR}/${file_name}"
done
