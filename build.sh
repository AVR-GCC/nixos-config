#!/bin/sh
SCRIPT_DIR="$(dirname "$0")"
source "$SCRIPT_DIR/local.env"
cp /etc/nixos/hardware-configuration.nix "$SCRIPT_DIR/hardware-configuration.nix"
git -C "$SCRIPT_DIR" add -f hardware-configuration.nix
git -C "$SCRIPT_DIR" commit -m "temp: add hardware-configuration.nix for build"
sudo ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY" FLAKE_PATH="$FLAKE_PATH" nixos-rebuild switch --flake "$SCRIPT_DIR#bar-nixos" --impure
git -C "$SCRIPT_DIR" reset --soft HEAD~1
git -C "$SCRIPT_DIR" reset hardware-configuration.nix
