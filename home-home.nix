{ config, pkgs, ... }:

{
  imports = [ ./home-shared.nix ];

  home.packages = with pkgs; [
    pkg-config
    rustup
    gcc
    lldb
  ];

  home.sessionVariables = {
    # EDITOR = "emacs";
    RUSTFLAGS = "-L${pkgs.postgresql.lib}/lib";
  };
}
