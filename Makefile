all: init link defaults brew other_apps

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
