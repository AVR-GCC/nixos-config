{ ... }:

[
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
    mode = "n";
    key = "<Tab>";
    action = ":bnext<CR>";
    options.desc = "Next buffer";
  }
  {
    mode = "n";
    key = "<S-Tab>";
    action = ":bprev<CR>";
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
]
