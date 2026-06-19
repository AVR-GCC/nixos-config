#!/usr/bin/env bash
set -e

# ============================================================
# CONFIGURATION — fill these in before running
# ============================================================
GITHUB_USER="AVR-GCC"
GITHUB_REPO="nixos-config"
GIT_EMAIL="ogoun.d@gmail.com"
# ============================================================

FLAKE_PATH="$HOME/workspace/nixos-config"
 
# echo "==> Generating SSH key..."
# ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f "$HOME/.ssh/id_ed25519" -N ""
 
echo ""
echo "======================================================"
echo "  ACTION REQUIRED: Add this SSH key to GitHub"
echo "======================================================"
echo ""
cat "$HOME/.ssh/id_ed25519.pub"
echo ""
echo "  1. Copy the key above"
echo "  2. Go to: https://github.com/settings/ssh/new"
echo "  3. Paste it in and click 'Add SSH key'"
echo ""
read -rp "Press Enter once you have added the key to GitHub..."
 
# echo "==> Testing GitHub SSH connection..."
# ssh -o StrictHostKeyChecking=accept-new -T git@github.com 2>&1 || true
 
echo "==> Cloning repository..."
cd "$HOME"
# mkdir "workspace"
cd "workspace"
REPO="git@github.com:$GITHUB_USER/$GITHUB_REPO.git"
echo $REPO
nix --extra-experimental-features "nix-command flakes" run nixpkgs#git -- clone  $REPO
cd "$GITHUB_REPO"

echo "==> Creating local.env..."
touch local.env
read -rp "Enter your Anthropic API key: " ANTHROPIC_API_KEY
LOCAL_ENV="FLAKE_PATH=$FLAKE_PATH
ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY"
echo $LOCAL_ENV > local.env
 
echo "==> Making build.sh executable..."
chmod +x "build.sh"
 
echo "==> Running build.sh..."
./build.sh bar-nixos
