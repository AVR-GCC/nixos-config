{ config, pkgs, ... }:

{
  home-manager.users.bar = { pkgs, ... }: {
    home.packages = with pkgs; [
      nodejs
    ];

    programs.nixvim = {
      plugins.lsp.servers.ts_ls = {
        enable = true;
        settings.typescript.preferences.includeCompletionsForModuleExports = true;
        settings.javascript.preferences.includeCompletionsForModuleExports = true;
      };

      plugins.dap =
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
              port = 9229;
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
          adapters = {
            # executables = {
            #   "node" = {
            #     command = "node";
            #     args = [ "${pkgs.vscode-js-debug}/lib/node_modules/js-debug/dist/src/dapDebugServer.js" "9230" ];
            #   };
            # };

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
            javascriptreact = nodeConfig;
          };
        };
    };
  };
}
