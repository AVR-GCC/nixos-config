{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "bar";
  home.homeDirectory = "/home/bar";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    oh-my-zsh
    lazygit
  ];

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "nanotech";
      plugins = [ "git" "sudo" ];
    };
    shellAliases = {
      tmux = "tmux -u";
    };
    envExtra = ''
      export TERM=xterm-256color
    '';
  };

  programs.nixvim = {
    enable = true;
    colorschemes.tokyonight.enable = true;

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

    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = ":Neotree toggle<CR>";
        options.desc = "Toggle file tree";
      }
      {
        mode = "n";
        key = "<leader>h";
        action.__raw = ''
        function()
          vim.cmd("botright " .. math.floor(vim.o.lines * 0.3) .. "split")
          vim.cmd("terminal")
          vim.defer_fn(function()
            vim.cmd("startinsert")
          end, 1)
        end
        '';
        options.desc = "Open horizontal terminal";
      }
      {
        mode = "t";
        key = "<C-w>";
        action.__raw = ''
        function()
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
        end
        '';
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
        key = "<leader>ai";
        action.__raw = ''
          function()
            local cwd = vim.fn.getcwd()
            local check = vim.fn.system("tmux list-panes -a -F '#{pane_current_command}' | grep -c opencode")
            check = check:gsub("%s+", "")
            if check ~= "0" then
              vim.fn.system("tmux list-panes -a -F '#{pane_id} #{pane_current_command}' | grep opencode | awk '{print $1}' | xargs tmux kill-pane -t")
            else
              vim.fn.system("tmux split-window -h -l 25% -c '" .. cwd .. "' 'opencode'")
            end
          end
        '';
        options.desc = "Toggle opencode tmux pane";
      }
    ];

    extraPackages = with pkgs; [ nixd ripgrep opencode lsof ];

    plugins = {
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
    };

    extraConfigLua = ''
      vim.g.opencode_opts = { port = 4321 }
    '';
  };

  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"
      set -g terminal-overrides ",*256col*:Tc"
    '';
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/bar/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    ANTHROPIC_API_KEY = builtins.getEnv "ANTHROPIC_API_KEY";
    FLAKE_PATH = builtins.getEnv "FLAKE_PATH";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
