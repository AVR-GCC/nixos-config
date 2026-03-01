{ config, pkgs, ... }:

{
  imports = [ ./home-shared.nix ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    redisinsight
  ];
}
