{ ... }:

[
  {
    mode = "i";
    key = "<Find>";
    action = "<Esc>^i";
    options.desc = "Go to start of line";
  }
  {
    mode = "i";
    key = "<Select>";
    action = "<Esc>$a";
    options.desc = "Go to end of line";
  }
  {
    mode = "n";
    key = "<leader>e";
    action = ":Neotree toggle<CR>";
    options.desc = "Toggle file tree";
  }
  {
    mode = "n";
    key = "<leader>h";
    action.__raw = builtins.readFile "${builtins.getEnv "FLAKE_PATH"}/nixvim/lua/open-terminal.lua";
    options.desc = "Open horizontal terminal";
  }
  {
    mode = "t";
    key = "<C-w>";
    action.__raw = builtins.readFile "${builtins.getEnv "FLAKE_PATH"}/nixvim/lua/exit-terminal.lua";
    options.desc = "Exit terminal mode";
  }
  {
    mode = "i";
    key = "<Tab>";
    action = "<C-t>";
    options.desc = "Indent line";
  }
  {
    mode = "n";
    key = "<Tab>";
    action.__raw = builtins.readFile "${builtins.getEnv "FLAKE_PATH"}/nixvim/lua/next-tab.lua";
    options.desc = "Next buffer";
  }
  {
    mode = "n";
    key = "<S-Tab>";
    action.__raw = builtins.readFile "${builtins.getEnv "FLAKE_PATH"}/nixvim/lua/prev-tab.lua";
    options.desc = "Previous buffer";
  }
  {
    mode = "n";
    key = "<leader>lg";
    action = ":LazyGit<CR>";
    options.desc = "Lazy git";
  }
  {
    mode = "n";
    key = "<leader>gb";
    action = "<cmd>Gitsigns blame_line<CR>";
    options = {
      desc = "Git blame line";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>gB";
    action = "<cmd>Gitsigns blame<CR>";
    options = {
      desc = "Git blame file";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<Esc>";
    action = ":noh<CR>";
    options.desc = "Clear search highlights";
  }
  {
    mode = "n";
    key = "<leader>x";
    action.__raw = builtins.readFile "${builtins.getEnv "FLAKE_PATH"}/nixvim/lua/close-tab.lua";
    options.desc = "Close tab";
  }
  {
    mode = "n";
    key = "<leader>ai";
    action.__raw = builtins.readFile "${builtins.getEnv "FLAKE_PATH"}/nixvim/lua/toggle-ai-pane.lua";
    options.desc = "Toggle opencode tmux pane";
  }
  {
    mode = "v";
    key = "<leader>ai";
    action.__raw = builtins.readFile "${builtins.getEnv "FLAKE_PATH"}/nixvim/lua/ref-code-for-ai.lua";
    options.desc = "Toggle opencode tmux pane";
  }
  {
    mode = "n";
    key = "<leader>r";
    action = "viw\"_dhp";
    options.desc = "Replace word";
  }
  {
    mode = "n";
    key = "<leader>gd";
    action = ":lua vim.lsp.buf.definition()<CR>";
    options.desc = "Go to definition";
  }
  {
    mode = "n";
    key = "<leader>rn";
    action = ":lua vim.lsp.buf.rename()<CR>";
    options.desc = "Rename symbol";
  }
  {
    mode = "n";
    key = "<leader>ca";
    action = ":lua vim.lsp.buf.code_action()<CR>";
    options.desc = "Code action";
  }
  {
    mode = "n";
    key = "<leader>db";
    action = ":DapToggleBreakpoint<CR>";
    options.desc = "Toggle breakpoint";
  }
  {
    mode = "n";
    key = "<leader>dc";
    action = ":DapContinue<CR>";
    options.desc = "Continue";
  }
  {
    mode = "n";
    key = "<leader>du";
    action.__raw = ''function() require("dapui").toggle() end'';
    options.desc = "Toggle DAP UI";
  }
  {
    mode = "n";
    key = "<leader>ds";
    action = "<cmd>lua require('dap').step_over()<cr>";
    options = {
      desc = "DAP Step Over";
    };
  }
  {
    mode = "n";
    key = "<leader>di";
    action = "<cmd>lua require('dap').step_into()<cr>";
    options = {
      desc = "DAP Step Into";
    };
  }
  {
    mode = "n";
    key = "<leader>dk";
    action = "<cmd>lua require('dap').terminate()<cr>";
    options = {
      desc = "DAP Kill process";
    };
  }
]
