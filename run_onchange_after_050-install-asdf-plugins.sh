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

if command -v asdf >/dev/null 2>&1; then
  if [[ -f "${HOME}/.asdf_plugin_repos" ]]; then
    echo-info "adding asdf plugin repos"
    while IFS=',' read -r plugin repo; do
      echo-run asdf plugin add ${plugin} ${repo} || true
    done <"${HOME}/.asdf_plugin_repos"
    echo-info "adding asdf plugins"
    cat "${HOME}/.tool-versions" | grep '\S' | while read -r line; do
      plugin_name=$(echo "${line}" | cut -d ' ' -f1)
      plugin_version=$(echo "${line}" | cut -d ' ' -f2)
      echo-info "installing plugin ${plugin_name} ${plugin_version}"
      echo-run asdf install "${plugin_name}" "${plugin_version}" || true
      echo-run asdf global "${plugin_name}" "${plugin_version}"
      echo-run asdf reshim "${plugin_name}" "${plugin_version}"
    done
  else
    echo-error "${HOME}/.asdf_plugin_repos not found"
  fi
fi

if [ -n "$GITHUB_WORKFLOW" ]; then
  echo-info "::endgroup::"
else
  echo-info "asdf plugins added/updated"
fi
