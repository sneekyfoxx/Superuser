#!/usr/bin/env bash

install_nim() {
  curl https://nim-lang.org/choosenim/init.sh -sSf | sh;
  export PATH="${PATH}:${HOME}/.nimble/bin";
  choosenim stable;
}

install_nim;
