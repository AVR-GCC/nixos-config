{ config, pkgs, ... }:
{
  home-manager.users.bar = { pkgs, ... }: {
    home.packages = with pkgs; [
      copyq
    ];

    systemd.user.services.copyq = {
      Unit = {
        Description = "CopyQ clipboard manager";
        After = [ "graphical-session.target" ];
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.copyq}/bin/copyq";
        Restart = "on-failure";
      };
    };
  };
}
