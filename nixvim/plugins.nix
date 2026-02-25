{ ... }:

{
  lsp = {
    enable = true;
    servers.nixd.enable = true;
  };
  cmp = {
    enable = true;
    settings.sources = [
      { name = "nvim_lsp"; }
      { name = "buffer"; }
      { name = "path"; }
    ];
    settings.mapping = {
      "<C-Space>" = "cmp.mapping.complete()";
      "<CR>" = "cmp.mapping.confirm({ select = true })";
      "<Tab>" = "cmp.mapping.select_next_item()";
      "<S-Tab>" = "cmp.mapping.select_prev_item()";
      "<C-e>" = "cmp.mapping.abort()";
    };
  };
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
  which-key.enable = true;
  treesitter = {
    enable = true;
    settings.indent.enable = true;
  };
  alpha = import "${builtins.getEnv "FLAKE_PATH"}/nixvim/alpha.nix" {};
}
