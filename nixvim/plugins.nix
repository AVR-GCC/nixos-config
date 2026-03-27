{ pkgs, ... }:

{
  treesitter = {
    enable = true;
    settings.indent.enable = true;
    nixvimInjections = true;
    grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
  };

  lsp = {
    enable = true;
    servers = {
      nixd.enable = true;
    };
  };

  cmp = {
    enable = true;
    settings = {
      sources = [
        { name = "nvim_lsp"; }
        { name = "luasnip"; }
        { name = "buffer"; }
        { name = "path"; }
      ];
      mapping = {
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-y>" = "cmp.mapping.confirm({ select = true })";
        "<C-n>" = "cmp.mapping.select_next_item()";
        "<C-p>" = "cmp.mapping.select_prev_item()";
        "<C-e>" = "cmp.mapping.abort()";
      };
    };
  };

  gitsigns = {
    enable = true;
    settings.current_line_blame = true;
    settings.current_line_blame_opts.virt_text = false;
  };

  friendly-snippets.enable = true;
  rainbow-delimiters.enable = true;
  nvim-autopairs.enable = true;
  lualine.enable = true;
  neo-tree.enable = true;
  lazygit.enable = true;
  web-devicons.enable = true;
  bufferline = {
    enable = true;
    settings.options.custom_filter.__raw = builtins.readFile "${builtins.getEnv "FLAKE_PATH"}/nixvim/lua/filter-terminal-buffer.lua";
  };

  telescope = {
    enable = true;
    settings.defaults.layout_strategy = "vertical";
    settings.defaults.layout_config.prompt_position = "top";
    settings.defaults.sorting_strategy = "ascending";
    keymaps = {
      "<leader>ff" = "find_files";
      "<leader>fw" = "live_grep";
      "<leader>fb" = "buffers";
      "<leader>fh" = "help_tags";
    };
  };
  grug-far = {
    enable = true;
  };

  which-key.enable = true;
  alpha = import "${builtins.getEnv "FLAKE_PATH"}/nixvim/alpha.nix" {};

  dap = {
    enable = true;
  };

  dap-ui.enable = true;
  dap-virtual-text.enable = true;

  lsp-signature = {
    enable = true;
    settings = {
      hint_enable = false;
      handler_opts.border = "rounded";
    };
  };
}
