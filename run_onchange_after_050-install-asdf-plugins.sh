#!/usr/bin/env bash

set -e

. "${HOME}/.shtils"

if [ -n "$GITHUB_WORKFLOW" ]; then
  echo-info "::group::Adding asdf plugins"
else
  echo-info "adding asdf plugins"
fi

if [ ! -d "${HOME}/.asdf" ]; then
  git clone -b v0.9.0 --single-branch https://github.com/asdf-vm/asdf.git "${HOME}/.asdf"
fi

. "${HOME}/.asdf/asdf.sh"

plugins=(
  "bat;https://gitlab.com/wt0f/asdf-bat.git"
  "broot;https://github.com/cmur2/asdf-broot.git"
  "concourse;https://github.com/mattysweeps/asdf-concourse.git"
  "delta;https://github.com/andweeb/asdf-delta.git"
  "dyff;https://gitlab.com/wt0f/asdf-dyff.git"
  "elixir;https://github.com/asdf-vm/asdf-elixir.git"
  "erlang;https://github.com/asdf-vm/asdf-erlang.git"
  "exa;https://github.com/nyrst/asdf-exa.git"
  "fd;https://gitlab.com/wt0f/asdf-fd.git"
  "fzf;https://github.com/kompiro/asdf-fzf.git"
  "gcloud;https://github.com/jthegedus/asdf-gcloud"
  "ghq;https://github.com/kajisha/asdf-ghq.git"
  "github-cli;https://github.com/bartlomiejdanek/asdf-github-cli.git"
  "gitui;https://github.com/looztra/asdf-gitui.git"
  "go-jsonnet;https://gitlab.com/craigfurman/asdf-go-jsonnet.git"
  "golang;https://github.com/kennyp/asdf-golang.git"
  "golangci-lint;git@github.com:hypnoglow/asdf-golangci-lint.git"
  "helm;https://github.com/Antiarchitect/asdf-helm.git"
  "jq;https://github.com/azmcode/asdf-jq.git"
  "k3d;https://github.com/spencergilbert/asdf-k3d.git"
  "k9s;https://github.com/looztra/asdf-k9s.git"
  "kubectl;https://github.com/Banno/asdf-kubectl.git"
  "kubectx;https://gitlab.com/wt0f/asdf-kubectx"
  "kubespy;https://github.com/jfreeland/asdf-kubespy.git"
  "lua;https://github.com/Stratus3D/asdf-lua.git"
  "neovim;https://github.com/richin13/asdf-neovim.git"
  "nodejs;https://github.com/asdf-vm/asdf-nodejs.git"
  "python;https://github.com/danhper/asdf-python.git"
  "ripgrep;https://gitlab.com/wt0f/asdf-ripgrep.git"
  "ruby;https://github.com/asdf-vm/asdf-ruby.git"
  "rust;https://github.com/code-lever/asdf-rust.git"
  "shfmt;https://github.com/luizm/asdf-shfmt.git"
  "sqlite;https://github.com/cLupus/asdf-sqlite.git"
  "tmux;https://github.com/aphecetche/asdf-tmux.git"
  "trdsql;https://github.com/johnlayton/asdf-trdsql.git"
  "usql;https://github.com/itspngu/asdf-usql.git"
  "vim;https://github.com/tsuyoshicho/asdf-vim.git"
  "yq;https://github.com/sudermanjr/asdf-yq.git"
)

if command -v asdf >/dev/null 2>&1; then
  for ((i = 0; i < ${#plugins[@]}; i++)); do
    IFS=';' read -r plugin_name plugin_repo <<<"${plugins[i]}"
    echo-run asdf plugin add ${plugin_name} ${plugin_repo} || true
    echo-run asdf install ${plugin_name} || true
    unset IFS
  done
fi

if [ -n "$GITHUB_WORKFLOW" ]; then
  echo-info "::endgroup::"
else
  echo-info "asdf plugins added/updated"
fi
