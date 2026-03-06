{ config, pkgs, ... }:

{
  home-manager.users.bar = { pkgs, ... }: {
    home.packages = with pkgs; [
      # pkgs.mongodb-compass
      pkg-config
      rustup
      gcc
      lldb
    ];
    home.sessionVariables = {
      RUSTFLAGS = "-L${pkgs.postgresql.lib}/lib";
    };
  };
}
