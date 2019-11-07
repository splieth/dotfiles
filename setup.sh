#!/usr/bin/env zsh

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".idea" \
		--exclude "setup.sh" \
		--exclude "README.md" \
		--exclude "Brewfile" \
		-avh --no-perms . ~;
	source ~/.zshrc;
}

doIt;
unset doIt;
