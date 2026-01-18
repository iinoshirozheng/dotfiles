SHELL := /bin/bash

.PHONY: bootstrap install link unlink mac linux test update fonts all

# Entry point
bootstrap:
	./bootstrap.sh

# Delegate everything to dotfile CLI
install:
	./bin/dotfile install

link:
	./bin/dotfile link

unlink:
	./bin/dotfile unlink

mac:
	./bin/dotfile install

linux:
	./bin/dotfile install

update:
	./bin/dotfile update

test:
	./bin/dotfile test

fonts:
	@echo "Fonts are now installed via 'make install' or 'dotfile install'"

all: bootstrap install
