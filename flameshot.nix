{ config, pkgs, ... }:
{
  home-manager.users.bar = { pkgs, ... }: {
    home.packages = with pkgs; [
      flameshot
    ];

    systemd.user.services.flameshot = {
      Unit = {
        Description = "Flameshot screenshot tool";
        After = [ "graphical-session.target" ];
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.flameshot}/bin/flameshot";
        Restart = "on-failure";
      };
    };
  };
}
