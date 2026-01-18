SHELL := /bin/bash

.PHONY: bootstrap install link unlink mac linux test update lang-cpp lang-python fonts all

bootstrap:
	./bootstrap.sh

install:
	./install.sh $$(uname -s | tr '[:upper:]' '[:lower:]')

link:
	cd stow && stow -t ~ --restow zsh starship git eza nvim

unlink:
	cd stow && stow -t ~ -D zsh starship git eza nvim

mac:
	brew bundle --file=./Brewfile
	bash ./os/darwin/defaults/apply.sh
	bash ./os/darwin/iterm2/configure.sh

linux:
	bash ./os/linux/postinstall.sh

update:
	bash ./bin/dotfile update

test:
	bash ./test/test_install.sh

lang-cpp:
	@echo "[C++] Installing toolchain"
	@if [ "$$(uname)" = "Darwin" ]; then \
		xcode-select --install || true; \
		brew install cmake ninja ccache pkg-config llvm vcpkg; \
	else \
		sudo apt update && sudo apt install -y build-essential clang cmake ninja-build ccache pkg-config git; \
		if [ ! -d "$$HOME/vcpkg" ]; then git clone https://github.com/microsoft/vcpkg.git $$HOME/vcpkg && $$HOME/vcpkg/bootstrap-vcpkg.sh; fi; \
	fi
	cd stow && stow -t ~ --restow zsh

lang-python:
	@echo "[Python] Installing toolchain"
	@if [ "$$(uname)" = "Darwin" ]; then \
		brew install pyenv pipx uv || true; \
	else \
		command -v pyenv >/dev/null || curl https://pyenv.run | bash; \
		python3 -m pip install --user pipx || true; \
	fi
	cd stow && stow -t ~ --restow zsh

fonts:
	bash ./os/darwin/fonts/install.sh || true

all: bootstrap install
