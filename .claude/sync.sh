#!/bin/zsh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_SET_DIR="${HOME}/.claude"

# Link CLAUDE.md
ln -fnsv "${SCRIPT_DIR}/CLAUDE.md" "${CLAUDE_SET_DIR}/CLAUDE.md"

# Link settings.json
ln -fnsv "${SCRIPT_DIR}/settings.json" "${CLAUDE_SET_DIR}/settings.json"

SUB_DIRS=(skills agents rules)
for dir in "${SUB_DIRS[@]}"; do
    dest_dir="${CLAUDE_SET_DIR}/${dir}"
    mkdir -p "${dest_dir}"
    for file in "${SCRIPT_DIR}/${dir}"/*.md; do
        ln -fnsv "${file}" "${dest_dir}/$(basename "${file}")"
    done
done
