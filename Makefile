all: init link defaults brew other_apps vscode

init:
	.bin/init.sh

link:
	.bin/link.sh

defaults:
	.bin/defaults.sh

brew:
	.bin/brew.sh

other_apps:
	.bin/other_apps.sh

vscode:
	.vscode/sync.sh

neovim:
	.nvim/sync.sh
