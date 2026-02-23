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
  bufferline.enable = true;
  telescope = {
    enable = true;
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
}
