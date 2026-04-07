#!/usr/bin/env bash
set -euo pipefail

# Bootstrap Neovim package directory (pack/vendor/start) by cloning plugin
# repositories referenced in lua/plugins/*.lua. This is a convenience helper for
# users migrating from lazy.nvim to pack-based plugin management.
#
# Usage: ./scripts/bootstrap-pack-plugins.sh [--config]
#   --config : install into $XDG_CONFIG_HOME/nvim/pack/vendor/start (default)
#   otherwise installs into $XDG_DATA_HOME/site/pack/vendor/start

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PLUGINS_DIR="$ROOT_DIR/nvim/lua/plugins"

if [ "$1" = "--data" ] || [ "$1" = "--xdg-data" ]; then
  TARGET_BASE="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/pack/vendor/start"
else
  TARGET_BASE="${XDG_CONFIG_HOME:-$HOME/.config}/nvim/pack/vendor/start"
fi

mkdir -p "$TARGET_BASE"

echo "Installing plugins to: $TARGET_BASE"

shopt -s nullglob
for f in "$PLUGINS_DIR"/*.lua; do
  # attempt to extract the first string literal inside the returned table, e.g. "owner/repo"
  repo=$(sed -n "1,120p" "$f" | tr '\n' ' ' | sed -E "s/.*return[^{]*\{[[:space:]]*\"([^\"]+)\".*/\1/p" | tr -d '\r')
  if [ -z "$repo" ]; then
    echo "Skipping $f: could not find repo string"
    continue
  fi
  name=$(basename "$repo")
  dest="$TARGET_BASE/$name"
  if [ -d "$dest" ]; then
    echo "Already installed: $name"
    continue
  fi
  echo "Cloning $repo -> $dest"
  git clone --depth 1 "https://github.com/$repo.git" "$dest" || {
    echo "Failed to clone $repo" >&2
    continue
  }
  # run make if present
  if [ -f "$dest/Makefile" ] || [ -f "$dest/makefile" ]; then
    echo "Running make for $name"
    (cd "$dest" && make) || echo "make failed for $name" >&2
  fi
done

echo "Done. Start Neovim; pack-based plugins will be on runtimepath." 
