#!/usr/bin/env bash

declare src="./bin";
declare des="$HOME/.local/bin";
declare fallback="/usr/bin";
declare user="$(whoami)";
declare system="$(uname -s)";
declare arch="$(uname -m)";

installer() {
  if [[ -d "$src" ]] && [[ -f "$src/superuser" ]]; then
    if [[ -d "$des" ]]; then
      sudo install -v -m 4754 -t "$des" "$src/superuser";
      exit 1;

    else
      sudo install -v -m 4754 -t "$fallback" "$src/superuser";
      exit 1;
    fi;
  else
    echo -e "Failed to locate 'superuser' binary.\n";
    exit 0;
  fi;
};

if [[ "$system" == "Linux" ]] && [[ "$arch" == "x86_64" ]]; then
  installer;
else
  echo -e "Platform not supported.\nSystem Requirements:\n - OS: Linux\n - Arch: x86_64\n";
  exit 0;
fi
