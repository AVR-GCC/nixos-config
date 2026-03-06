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

    plugins = import "${builtins.getEnv "FLAKE_PATH"}/nixvim/plugins.nix" { inherit pkgs; };

    extraPlugins = [ pkgs.vimPlugins.satellite-nvim ];

    extraConfigLua = ''
      package.path = package.path .. ";${builtins.getEnv "FLAKE_PATH"}/nixvim/lua/?.lua"
      require("extra-config")
    '';
  }
