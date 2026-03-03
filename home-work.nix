{ config, pkgs, ... }:

{
  imports = [ ./home-shared.nix ];

  home.packages = with pkgs; [
    mongodb-compass
    redisinsight
  ];
}
