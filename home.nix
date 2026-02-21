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
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    lazygit
  ];
  programs.nixvim = {
    enable = true;
    colorschemes.tokyonight.enable = true;

    clipboard = {
      register = "unnamedplus";
      providers.xclip.enable = true;
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
    ];
    extraPackages = with pkgs; [ nixd ripgrep ];
    plugins = {
      lsp = {
        enable = true;
        servers.nixd.enable = true;
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
    };
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
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
