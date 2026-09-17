.PHONY: export-dbx install bootstrap-basic bootstrap-devtools install-homebrew-formulas configure reconfigure cleanup debug-zsh debug-bash

install: bootstrap-basic \
	bootstrap-devtools \
	install-homebrew-formulas \
	configure


bootstrap-basic:
	./scripts/bootstrap-basic


bootstrap-devtools:
	./scripts/bootstrap-devtools


install-homebrew-formulas: bootstrap-devtools
	./scripts/install-homebrew-formulas


configure: install-homebrew-formulas
	./scripts/configure


reconfigure:
	./scripts/configure


export-dbx:
	./scripts/export-dbx-connections


cleanup:
	rm -rf $$HOME/.oh-my-zsh $$HOME/.zshrc.pre-oh-my-zsh $$HOME/.zshrc $$HOME/.bash_profile $$HOME/.dotfiles/.bin
	find $$HOME -maxdepth 1 \( -iname '.bash_profile.backup*' -o -iname '.zshrc.backup*' \) -delete


debug-zsh: SHELL:=/bin/zsh
debug-zsh:
	source $$HOME/.dotfiles/configs/.zshrc; true && printenv


debug-bash: SHELL:=/bin/bash
debug-bash:
	source $$HOME/.dotfiles/configs/.bash_profile && printenv
