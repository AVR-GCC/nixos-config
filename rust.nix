{ config, pkgs, ... }:

{
  home-manager.users.bar = { pkgs, ... }: {
    home.packages = with pkgs; [
      pkg-config
      rustup
      gcc
      lldb
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
          executables = {
            "lldb" = {
              # command = "${pkgs.lldb}/bin/lldb-dap";
              command = "/nix/store/yx7x8kzpqjnkz8xvwvj7mvw6nw1k0b8w-lldb-21.1.7/bin/lldb-dap";
            };
          };
        };

        configurations = {
          rust = [
            {
              type = "lldb";
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
