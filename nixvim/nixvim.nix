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
      vim.g.opencode_opts = { port = 4321 }
      package.path = package.path .. ";${builtins.getEnv "FLAKE_PATH"}/nixvim/lua/?.lua"
      require("dapui").setup({
        layouts = {
          {
            elements = {
              { id = "watches",     size = 0.10 },
              { id = "breakpoints", size = 0.15 },
              { id = "stacks",      size = 0.30 },
              { id = "scopes",      size = 0.45 },
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl",    size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom",
          },
        },
      })
      require("snippets")
      require("luasnip.loaders.from_vscode").lazy_load()
      require('satellite').setup({
        current_only = false,
        winblend = 50,
        zindex = 40,
        excluded_filetypes = { "neo-tree", "NvimTree", "TelescopePrompt", "terminal", "toggleterm", "nofile" },
        width = 2,
        handlers = {
          cursor = { enable = true },
          diagnostic = {
            enable = true,
            signs = { "-", "=" },
            min_severity = vim.diagnostic.severity.HINT,
          },
          gitsigns = { enable = true },
          marks = { enable = false },
          quickfix = { enable = false },
          search = { enable = false },
        },
      })
    '';
  }
