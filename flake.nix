{
  description = "ejiek's personal NixOS setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    pelp = {
      url = "github:ejiek/pelp/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, rust-overlay, pelp }:
    let
      mkHost = hostName: system:
        (({ my-config, zfs-root, pkgs, system, ... }:
          nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              # Take modules into account
              ./modules

              # Host specific
              (if (builtins.pathExists
                ./hosts/${hostName}/configuration.nix) then
                (import ./hosts/${hostName}/configuration.nix { inherit pkgs nixos-hardware rust-overlay pelp; })
              else
                { })

              # Entry point
              (({ my-config, zfs-root, pkgs, lib, ... }: {
                inherit my-config zfs-root;
                system.configurationRevision = if (self ? rev) then
                  self.rev
                else
                  throw "refuse to build: git tree is dirty";
                system.stateVersion = "23.11";
                imports = [
                  "${nixpkgs}/nixos/modules/installer/scan/not-detected.nix"
                  # "${nixpkgs}/nixos/modules/profiles/hardened.nix"
                  # "${nixpkgs}/nixos/modules/profiles/qemu-guest.nix"
                ];
              }) {
                inherit my-config zfs-root pkgs;
                lib = nixpkgs.lib;
              })

              # home-manager
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
              }

              # Shared config
              (import ./configuration.nix { inherit pkgs; })
            ];
          })

        # configuration input
          (import ./hosts/${hostName} {
            system = system;
            pkgs = nixpkgs.legacyPackages.${system};
          }));
    in {
      nixosConfigurations = {
        ePower = mkHost "ePower" "x86_64-linux";
        eFrame = mkHost "eFrame" "x86_64-linux";
        eTower = mkHost "eTower" "x86_64-linux";
      };
    };
}
