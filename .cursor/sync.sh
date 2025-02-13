#!/bin/zsh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
VSCODE_SET_DIR="${HOME}/Library/Application Support/Cursor/User"

# Link settings.json
ln -fnsv "${SCRIPT_DIR}/settings.json" "${VSCODE_SET_DIR}/settings.json"

# Link keybindings.json
ln -fnsv "${SCRIPT_DIR}/keybindings.json" "${VSCODE_SET_DIR}/keybindings.json"

# Install extensions using the code command
if [ "$(which code)" != "" ]; then
  cat < "${SCRIPT_DIR}/extensions" | while read -r line
  do
    cursor --install-extension "$line"
  done
else
  echo "Install the code command from the command palette to add your extensions."
fi
