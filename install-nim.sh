#!/usr/bin/env bash

install_nim() {
  curl https://nim-lang.org/choosenim/init.sh -sSf | sh;
  choosenim --stable;
  export PATH="${PATH}:${HOME}/.nimble/bin";
}

install_nim;
