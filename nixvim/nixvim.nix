{ pkgs, ... }:

{
    enable = true;
    colorschemes.gruvbox-material.enable = true;

    clipboard = {
      register = "unnamedplus";
      providers.xclip.enable = true;
    };

    opts = {
      number = true;
      relativenumber = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
    };

    globals.mapleader = " ";

    keymaps = import "${builtins.getEnv "FLAKE_PATH"}/nixvim/keymaps.nix" {};

    extraPackages = with pkgs; [ nixd ripgrep opencode lsof ];

    plugins = import "${builtins.getEnv "FLAKE_PATH"}/nixvim/plugins.nix" {};

    extraConfigLua = ''
      vim.g.opencode_opts = { port = 4321 }
      package.path = package.path .. ";${builtins.getEnv "FLAKE_PATH"}/nixvim/lua/?.lua"
    '';
  }
