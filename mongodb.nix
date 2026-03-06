{ config, pkgs, ... }:

{
  virtualisation.oci-containers = {
    backend = "docker";
    containers.mongodb = {
      image = "mongo:latest";
      ports = [ "27017:27017" ];
      volumes = [ "mongodb_data:/data/db" ];
    };
  };

  home-manager.users.bar = { pkgs, ... }: {
    home.packages = [ pkgs.mongodb-compass ];
  };
}
