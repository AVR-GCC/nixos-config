{ config, pkgs, ... }:

{
  home-manager.users.bar = { pkgs, ... }: {
    home.packages = with pkgs; [
      dbeaver-bin
      postgresql.lib
      postgresql
    ];

    home.sessionVariables = {
      DBEAVER_ARGS = "-Dswt.dark=true";
      PKG_CONFIG_PATH = "${pkgs.postgresql.lib}/lib/pkgconfig";
      LD_LIBRARY_PATH = "${pkgs.postgresql.lib}/lib";
    };
  };

  services.postgresql = {
    enable = true;
    ensureUsers = [{
      name = "bar";
      # This grants the user the admin rights needed to mess with the postgres DB
      ensureClauses = {
        superuser = true;
        createdb = true;
        createrole = true;
      };
    }];
    # 1. Tell Postgres to use SSL and where to find the certs
    settings = {
      ssl = "on";
      ssl_cert_file = "/var/lib/postgresql/server.crt";
      ssl_key_file = "/var/lib/postgresql/server.key";
    };
    authentication = pkgs.lib.mkOverride 10 ''
      # type  database  user  address         auth-method
      local   all       all                   trust
      host    all       all   127.0.0.1/32    trust
      host    all       all   ::1/128         trust
    '';
  };

  systemd.services.postgresql.preStart = pkgs.lib.mkAfter ''
    if [ ! -f /var/lib/postgresql/server.crt ]; then
      ${pkgs.openssl}/bin/openssl req -new -x509 -days 3650 -nodes -text \
        -out /var/lib/postgresql/server.crt \
        -keyout /var/lib/postgresql/server.key \
        -subj "/CN=localhost"

      # Postgres requires strict permissions on the private key
      chmod 0600 /var/lib/postgresql/server.key
    fi
  '';
}
