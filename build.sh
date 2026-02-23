#!/bin/sh
source "$(dirname "$0")/local.env"
sudo ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY" FLAKE_PATH="$FLAKE_PATH" nixos-rebuild switch --flake "$(dirname "$0")#bar-nixos" --impure
