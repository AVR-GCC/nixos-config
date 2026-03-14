{ config, pkgs, ... }:

{
  home-manager.users.bar = { pkgs, ... }: {
    home.packages = with pkgs; [
      pkg-config
      rustup
      gcc
      vscode-extensions.vadimcn.vscode-lldb
    ];

    home.sessionVariables = {
      RUSTFLAGS = "-L${pkgs.postgresql.lib}/lib";
    };

    programs.nixvim.plugins = {
      lsp.servers.rust_analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;
      };

      dap = {
        adapters = {
          servers = {
            "codelldb" = {
              port = 13000;
              executable = {
                command = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
                args = ["--port" "13000"];
              };
            };
          };
        };

        configurations = {
          rust = [
            {
              type = "codelldb";
              request = "launch";
              name = "Debug Rust";
              program = "\${workspaceFolder}/target/debug/\${workspaceFolderBasename}";
              args = [];
              cwd = "\${workspaceFolder}";
            }
          ];
        };
      };
    };
  };
}
