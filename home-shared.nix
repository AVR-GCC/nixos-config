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
    lsof
    dbeaver-bin
    pkg-config
    postgresql.lib
    postgresql
    rustup
    gcc
    lldb
    nodejs
    vscode-js-debug
    oh-my-zsh
    lazygit
    flameshot
    brave
    git
    tmux
    qbittorrent
    copyq
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

  programs.nixvim =  import "${builtins.getEnv "FLAKE_PATH"}/nixvim/nixvim.nix" { inherit pkgs; };

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
    PKG_CONFIG_PATH = "${pkgs.postgresql.lib}/lib/pkgconfig";
    LD_LIBRARY_PATH = "${pkgs.postgresql.lib}/lib";
    RUSTFLAGS = "-L${pkgs.postgresql.lib}/lib";
    EDGE_PATH = "${pkgs.brave}/bin/brave";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
