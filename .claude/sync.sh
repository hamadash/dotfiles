#!/bin/zsh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_SET_DIR="${HOME}/.claude"

# Link CLAUDE.md
ln -fnsv "${SCRIPT_DIR}/CLAUDE.md" "${CLAUDE_SET_DIR}/CLAUDE.md"

# Link settings.json
ln -fnsv "${SCRIPT_DIR}/settings.json" "${CLAUDE_SET_DIR}/settings.json"

CLAUDE_SKILLS_DIR="${CLAUDE_SET_DIR}/skills"
mkdir -p "${CLAUDE_SKILLS_DIR}"
for skill_file in "${SCRIPT_DIR}"/skills/*.md; do
    file_name=$(basename "${skill_file}")
    ln -fnsv "${skill_file}" "${CLAUDE_SKILLS_DIR}/${file_name}"
done
