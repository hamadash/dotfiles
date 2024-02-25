all: init link defaults brew other_apps vscode karabiner_elements

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

karabiner_elements:
	karabiner_elements/sync.sh
