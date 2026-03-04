#!/bin/sh
SCRIPT_DIR="$(dirname "$0")"
source "$SCRIPT_DIR/local.env"

CONFIG="${1:-bar-nixos}"
cp /etc/nixos/hardware-configuration.nix "$SCRIPT_DIR/hardware-configuration.nix"
git -C "$SCRIPT_DIR" add -Af
if ! git -C "$SCRIPT_DIR" diff --cached --quiet; then
  git -C "$SCRIPT_DIR" commit -m "temp: add hardware-configuration.nix for build"
  TEMP_COMMITTED=1
fi
sudo ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY" FLAKE_PATH="$FLAKE_PATH" nixos-rebuild switch --flake "$SCRIPT_DIR#$CONFIG" --impure
if [ -n "$TEMP_COMMITTED" ]; then
  git -C "$SCRIPT_DIR" reset --soft HEAD~1
  git -C "$SCRIPT_DIR" reset hardware-configuration.nix
fi
