#!/usr/bin/env bash

install_nim() {
  curl https://nim-lang.org/choosenim/init.sh -sSf | sh;
  echo -e '\nexport PATH="${PATH}:${HOME}/.nimble/bin"' >> "${HOME}/.zshrc";
  choosenim stable;
}

install_nim;
