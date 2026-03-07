{ config, pkgs, ... }:

{
  services.redis.servers."" = {
    enable = true;
    port = 6379;
  };

  home-manager.users.bar = { pkgs, ... }: {
    home.packages = [ pkgs.redisinsight ];
  };
}
