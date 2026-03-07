{
  description = "Nixos Nexus";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ... }: {
    nixosConfigurations.bar-nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./postgres.nix
        ./node.nix
        ./rust.nix
        ./copyq.nix
        ./flameshot.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.users.bar = import ./home.nix;
          home-manager.sharedModules = [ nixvim.homeModules.nixvim ];
        }
      ];
    };
    nixosConfigurations.bar-work = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./postgres.nix
        ./mongodb.nix
        ./redis.nix
        ./node.nix
        ./copyq.nix
        ./flameshot.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.users.bar = import ./home.nix;
          home-manager.sharedModules = [ nixvim.homeModules.nixvim ];
        }
      ];
    };
  };
}
