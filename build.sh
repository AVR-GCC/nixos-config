#!/bin/sh
source "$(dirname "$0")/local.env"
sudo --flake "$(dirname "$0")#bar-nixos" --impure
