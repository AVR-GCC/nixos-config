# Nixos Nexus

A personal NixOS flake configuration for a single-machine, single-user setup. It declaratively manages the full system — from hardware and desktop environment to shell, editor, and AI-assisted development workflow — all in one reproducible flake.

## Overview

This configuration targets an `x86_64-linux` machine (`bar-nixos`) running the Cinnamon desktop environment on X11. It uses [Home Manager](https://github.com/nix-community/home-manager) as a NixOS module to manage user-level dotfiles and programs, and [NixVim](https://github.com/nix-community/nixvim) for a fully Nix-defined Neovim setup.

### Flake Inputs

| Input | Source | Channel |
|---|---|---|
| nixpkgs | `NixOS/nixpkgs` | `nixos-25.11` |
| home-manager | `nix-community/home-manager` | `release-25.11` |
| nixvim | `nix-community/nixvim` | `nixos-25.11` |

All inputs follow `nixpkgs` to ensure a single consistent package set.

## Repository Structure

```
.
├── build.sh                     # Build and deploy script
├── local.env                    # Local secrets and env vars (git-ignored)
├── flake.nix                    # Flake entry point
├── flake.lock                   # Pinned dependency versions
├── configuration.nix            # System-level NixOS configuration
├── hardware-configuration.nix   # Auto-generated hardware config
├── home.nix                     # Home Manager user configuration
└── nixvim/
    ├── nixvim.nix               # NixVim editor configuration
    ├── plugins.nix              # Plugin definitions
    ├── keymaps.nix              # Keybinding definitions
    └── lua/
        ├── close-tab.lua        # Smart buffer/tab closing
        ├── exit-terminal.lua    # Terminal mode exit helper
        ├── filter-terminal-buffer.lua  # Hides terminal buffers from bufferline
        ├── open-terminal.lua    # Opens a bottom-split terminal
        ├── ref-code-for-ai.lua  # Sends selected code to opencode AI pane
        └── toggle-ai-pane.lua   # Toggles opencode AI tmux pane
```

## Setup

### Prerequisites

- A running NixOS installation with flakes enabled
- `git` available on the system

### 1. Clone the repository

```sh
git clone git@github.com:AVR-GCC/nixos-config.git
cd nixos-config
```

### 2. Create `local.env`

The build requires a `local.env` file in the project root. This file is git-ignored and must be created manually.

```sh
cp local.env.example local.env  # or create it from scratch
```

`local.env` must define the following variables:

| Variable | Required | Description |
|---|---|---|
| `FLAKE_PATH` | **Yes** | Absolute path to this repository (e.g. `~/workspace/nixos-config/`). Used throughout the configuration to resolve imports at Nix evaluation time. The build will fail without it. |
| `ANTHROPIC_API_KEY` | No | Anthropic API key for the [opencode](https://opencode.ai) AI assistant integration. If provided, it is exported as a session variable for the user. Not required for the system to build and function. |

Example `local.env`:

```sh
FLAKE_PATH=~/workspace/nixos-config/
ANTHROPIC_API_KEY=sk-ant-api03-your-key-here
```

### 3. Build and apply

Make the build script executable and run it:

```sh
chmod +x build.sh
./build.sh
```

This sources `local.env`, then runs `sudo nixos-rebuild switch --flake .#bar-nixos --impure`, passing `FLAKE_PATH` and `ANTHROPIC_API_KEY` through to the Nix evaluation environment.

The `--impure` flag is required because the configuration uses `builtins.getEnv` to read environment variables at evaluation time for resolving file imports and injecting secrets.

## What's Included

### System (`configuration.nix`)

- **Desktop**: Cinnamon on X11 with LightDM
- **Keyboard**: US + Israeli layouts (Alt+Shift toggle)
- **Locale**: `en_IL` with Hebrew-Israel regional overrides
- **Timezone**: `Asia/Jerusalem`
- **Audio**: PipeWire
- **Printing**: CUPS
- **Fonts**: Nerd Fonts (Iosevka)
- **Packages**: Brave, Firefox, Git, tmux, Flameshot, qBittorrent, unrar, vcmi

### User (`home.nix`)

- **Shell**: Zsh with Oh My Zsh (`nanotech` theme, `git` and `sudo` plugins)
- **Terminal multiplexer**: tmux (256color, truecolor)
- **Editor**: NixVim (see below)
- **Git tools**: lazygit

### Editor (`nixvim/`)

A fully declarative Neovim configuration via NixVim:

- **Theme**: Tokyo Night
- **LSP**: `nixd` (Nix language server)
- **Completion**: nvim-cmp with LSP, buffer, and path sources
- **Navigation**: Telescope (fuzzy finder), Neo-tree (file explorer), bufferline
- **Syntax**: Treesitter
- **UI**: lualine, which-key, web-devicons
- **Git**: LazyGit integration (`<leader>lg`)
- **Terminal**: Integrated bottom-split terminal (`<leader>h`)

#### Key Bindings

| Key | Mode | Action |
|---|---|---|
| `<Space>` | — | Leader key |
| `<leader>e` | Normal | Toggle file explorer |
| `<leader>h` | Normal | Open terminal (bottom split) |
| `<leader>lg` | Normal | Open LazyGit |
| `<leader>ff` | Normal | Find files |
| `<leader>fw` | Normal | Live grep |
| `<leader>fb` | Normal | Browse buffers |
| `<leader>fh` | Normal | Search help tags |
| `<leader>x` | Normal | Close current buffer |
| `<leader>r` | Normal | Replace word under cursor |
| `<Tab>` / `<S-Tab>` | Normal | Next / previous buffer |
| `<Esc>` | Normal | Clear search highlights |
| `<C-w>` | Terminal | Exit terminal mode |
| `<leader>ai` | Normal | Toggle opencode AI tmux pane |
| `<leader>ai` | Visual | Send selected code to opencode AI pane |

### Opencode AI Integration

The NixVim config includes a tmux-based integration with [opencode](https://opencode.ai), an AI coding assistant:

- `<leader>ai` in normal mode toggles a 25%-width right-side tmux pane running `opencode`.
- `<leader>ai` in visual mode yanks the selection and sends it — along with the file path and line range — to the opencode pane for context-aware assistance.
- Requires `tmux` to be the active terminal multiplexer.

## Customization

To adapt this configuration for your own machine:

1. Replace `hardware-configuration.nix` with one generated for your hardware (typically found at `/etc/nixos/hardware-configuration.nix` after a NixOS install).
2. Update the hostname and user references (`bar`, `bar-nixos`) throughout `flake.nix`, `configuration.nix`, and `home.nix`.
3. Adjust locale, timezone, keyboard layouts, and package lists to your preference.
4. Set `FLAKE_PATH` in `local.env` to wherever you cloned the repository.

## License

This is a personal configuration repository. Use it as a reference or starting point for your own NixOS setup.
