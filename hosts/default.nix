{ lib, inputs, nixpkgs, home-manager, ... }:

let 
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    cofig.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in {
  e220 = lib.nixosSystem {
    inherit system;
    modules = [
      ./configuration.nix
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.ejiek = import ./home.nix;
        
      }
    ];
  };
}
