#!/bin/sh
SCRIPT_DIR="$(dirname "$0")"
source "$SCRIPT_DIR/local.env"
cp /etc/nixos/hardware-configuration.nix "$SCRIPT_DIR/hardware-configuration.nix"
sudo ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY" FLAKE_PATH="$FLAKE_PATH" nixos-rebuild switch --flake "$SCRIPT_DIR#bar-nixos" --impure
