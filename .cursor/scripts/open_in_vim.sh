#!/bin/bash

workspace_root="$1"
file_path="$2"
line="$3"

# iTerm で Vim を開く (osascript を使う)
osascript <<EOF
tell application "iTerm"
    activate
    tell current window
        create tab with default profile
        tell current session
            write text "cd '$workspace_root' && vim +'$line' '$file_path'"
        end tell
    end tell
end tell
EOF
