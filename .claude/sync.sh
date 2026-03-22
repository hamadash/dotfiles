#!/bin/zsh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_SET_DIR="${HOME}/.claude"

# Link CLAUDE.md
ln -fnsv "${SCRIPT_DIR}/CLAUDE.md" "${CLAUDE_SET_DIR}/CLAUDE.md"

# Link settings.json
ln -fnsv "${SCRIPT_DIR}/settings.json" "${CLAUDE_SET_DIR}/settings.json"

# 再帰的にシンボリックリンク
SUB_DIRS=(skills agents rules)

for dir in "${SUB_DIRS[@]}"; do
    src_dir="${SCRIPT_DIR}/${dir}"
    dest_dir="${CLAUDE_SET_DIR}/${dir}"

    mkdir -p "${dest_dir}"

    (
        cd "${src_dir}"

        find . -mindepth 1 | while read -r path; do
            rel_path="${path#./}"
            target="${dest_dir}/${rel_path}"

            if [ -d "$path" ]; then
                mkdir -p "$target"
            else
                ln -fnsv "${src_dir}/${rel_path}" "$target"
            fi
        done
    )
done
