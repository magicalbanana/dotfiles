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

plugin_repos=(
  "https://github.com/Antiarchitect/asdf-helm.git"
  "https://github.com/Banno/asdf-kubectl.git"
  "https://github.com/andweeb/asdf-delta.git"
  "https://github.com/aphecetche/asdf-tmux.git"
  "https://github.com/asdf-vm/asdf-elixir.git"
  "https://github.com/asdf-vm/asdf-erlang.git"
  "https://github.com/asdf-vm/asdf-nodejs.git"
  "https://github.com/asdf-vm/asdf-ruby.git"
  "https://github.com/azmcode/asdf-jq.git"
  "https://github.com/bartlomiejdanek/asdf-github-cli.git"
  "https://github.com/cLupus/asdf-sqlite.git"
  "https://github.com/cmur2/asdf-broot.git"
  "https://github.com/code-lever/asdf-rust.git"
  "https://github.com/danhper/asdf-python.git"
  "https://github.com/itspngu/asdf-usql.git"
  "https://github.com/jfreeland/asdf-kubespy.git"
  "https://github.com/johnlayton/asdf-trdsql.git"
  "https://github.com/jthegedus/asdf-gcloud"
  "https://github.com/kajisha/asdf-ghq.git"
  "https://github.com/kennyp/asdf-golang.git"
  "https://github.com/kompiro/asdf-fzf.git"
  "https://github.com/looztra/asdf-gitui.git"
  "https://github.com/looztra/asdf-k9s.git"
  "https://github.com/luizm/asdf-shfmt.git"
  "https://github.com/mattysweeps/asdf-concourse.git"
  "https://github.com/nyrst/asdf-exa.git"
  "https://github.com/richin13/asdf-neovim.git"
  "https://github.com/spencergilbert/asdf-k3d.git"
  "https://github.com/sudermanjr/asdf-yq.git"
  "https://gitlab.com/craigfurman/asdf-go-jsonnet.git"
  "https://gitlab.com/wt0f/asdf-bat.git"
  "https://gitlab.com/wt0f/asdf-dyff.git"
  "https://gitlab.com/wt0f/asdf-fd.git"
  "https://gitlab.com/wt0f/asdf-kubectx"
  "https://gitlab.com/wt0f/asdf-ripgrep.git"
)

if command -v asdf >/dev/null 2>&1; then
  # add plugin repositories
  for ((i = 0; i < ${#plugin_repos[@]}; i++)); do
    plugin_repo="${plugin_repos[i]}"
    echo-run asdf plugin add ${plugin_repo} || true
  done
  echo-run asdf install
fi

if [ -n "$GITHUB_WORKFLOW" ]; then
  echo-info "::endgroup::"
else
  echo-info "asdf plugins added/updated"
fi
