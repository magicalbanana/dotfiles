#!/bin/sh

set -e

if command -v zinit >/dev/null 2>&1; then
  echo "Skipping zinit install since it's already available"
  exit
fi

if [ ! -d "${HOME}/.zinit/bin" ]; then
  mkdir -p "${HOME}/.zinit/bin"
  git clone https://github.com/zdharma/zinit.git "${HOME}/.zinit/bin"
fi