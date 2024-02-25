#!/bin/zsh

# GitHub SSH
echo -e "\033[0;34m- GitHub SSH Setup...\033[0m"
SSH_KEY_PATH="$HOME/.ssh"
ssh-keygen -N '' -f ${SSH_KEY_PATH}/id_rsa
pbcopy < ${SSH_KEY_PATH}/id_rsa.pub
echo "SSH key copied to clipboard. Paste it into GitHub."
sleep 1; echo "Open the GitHub settings page:"
sleep 1; open https://github.com/settings/ssh/new
