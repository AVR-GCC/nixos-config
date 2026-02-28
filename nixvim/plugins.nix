{ pkgs, ... }:

{
  lsp = {
    enable = true;
    servers = {
      nixd.enable = true;
      rust_analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;
      };
      ts_ls = {
        enable = true;
        settings.typescript.preferences.includeCompletionsForModuleExports = true;
        settings.javascript.preferences.includeCompletionsForModuleExports = true;
      };
    };
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
      "<C-y>" = "cmp.mapping.confirm({ select = true })";
      "<C-n>" = "cmp.mapping.select_next_item()";
      "<C-p>" = "cmp.mapping.select_prev_item()";
      "<C-e>" = "cmp.mapping.abort()";
    };
  };

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

  which-key.enable = true;
  treesitter = {
    enable = true;
    settings.indent.enable = true;
  };
  alpha = import "${builtins.getEnv "FLAKE_PATH"}/nixvim/alpha.nix" {};

  dap = 
    let
      nodeConfig = [
        {
          type = "pwa-node";
          request = "launch";
          name = "Launch file";
          program = "\${file}";
          cwd = "\${workspaceFolder}";
        }
        {
          type = "pwa-node";
          request = "attach";
          name = "Attach to process";
          port = 8081;
          cwd = "\${workspaceFolder}";
          sourceMaps = true;
          sourceMapPathOverrides = {
            "../../app/*" = "\${workspaceFolder}/app/*";
            "../app/*" = "\${workspaceFolder}/app/*";
          };
          # outFiles = [ "\${workspaceFolder}/**/*.js" "\${workspaceFolder}/**/*.jsx" ];
          # resolveSourceMapLocations = [ "\${workspaceFolder}/**" "!**/node_modules/**" ];
        }
      ];
    in
      {
      enable = true;
      adapters = {
        executables = {
          "lldb" = {
            # command = "${pkgs.lldb}/bin/lldb-dap";
            command = "/nix/store/yx7x8kzpqjnkz8xvwvj7mvw6nw1k0b8w-lldb-21.1.7/bin/lldb-dap";
          };
          "node" = {
            command = "node";
            args = [ "${pkgs.vscode-js-debug}/lib/node_modules/js-debug/dist/src/dapDebugServer.js" "9230" ];
          };
        };
        servers."pwa-node" = {
          host = "localhost";
          port = 9230;
          executable = {
            command = "node";
            args = [ "${pkgs.vscode-js-debug}/lib/node_modules/js-debug/dist/src/dapDebugServer.js" "9230" ];
          };
        };
      };
      configurations = {
        javascript = nodeConfig;
        typescript = nodeConfig;
        typescriptreact = nodeConfig;
        rust = [
          {
            type = "lldb";
            request = "launch";
            name = "Debug Rust";
            program = "\${workspaceFolder}/target/debug/LifeInOrderBackend";
            # program = "\${workspaceFolder}/target/debug/\${workspaceFolderBasename}";
            args = [];
            cwd = "\${workspaceFolder}";
          }
        ];
      };
    };


  dap-ui.enable = true;
  dap-virtual-text.enable = true;
}
