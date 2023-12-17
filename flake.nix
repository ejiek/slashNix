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
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixos-hardware
    , ...
    } @inputs:
    let
      inherit (self) outputs;
      stateVersion = "23.05";
      elib = import ./lib { inherit inputs outputs stateVersion; };
    in
    {
      homeConfigurations = {
        "ejiek@ePower" = elib.mkHome { hostname = "ePower"; username = "ejiek"; };
        "ejiek@eFrame" = elib.mkHome { hostname = "eFrame"; username = "ejiek"; };
        # steamdeck
        # pi4
      };
      nixosConfigurations = {
        ePower = elib.mkHost { hostname = "ePower"; username = "ejiek"; };
        eFrame = elib.mkHost { hostname = "eFrame"; username = "ejiek"; };
      };

      devShells = elib.forAllSystems ( system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./shell.nix { inherit pkgs; }
      );

      # Custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };

      # Custom packages; accessible via 'nix build', 'nix shell', etc
      packages = elib.forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./pkgs { inherit pkgs; }
      );
    };

#      mkHost = hostName: system:
#        (({ my-config, zfs-root, pkgs, system, ... }:
#          nixpkgs.lib.nixosSystem {
#            inherit system;
#            modules = [
#              # Take modules into account
#              ./modules
#
#              # Host specific
#              (if (builtins.pathExists
#                ./hosts/${hostName}/configuration.nix) then
#                (import ./hosts/${hostName}/configuration.nix { inherit pkgs nixos-hardware rust-overlay; })
#              else
#                { })
#
#              # Entry point
#              (({ my-config, zfs-root, pkgs, lib, ... }: {
#                inherit my-config zfs-root;
#                system.configurationRevision = if (self ? rev) then
#                  self.rev
#                else
#                  throw "refuse to build: git tree is dirty";
#                system.stateVersion = "23.05";
#                imports = [
#                  "${nixpkgs}/nixos/modules/installer/scan/not-detected.nix"
#                  # "${nixpkgs}/nixos/modules/profiles/hardened.nix"
#                  # "${nixpkgs}/nixos/modules/profiles/qemu-guest.nix"
#                ];
#              }) {
#                inherit my-config zfs-root pkgs;
#                lib = nixpkgs.lib;
#              })
#
#              # home-manager
#              home-manager.nixosModules.home-manager
#              {
#                home-manager.useGlobalPkgs = true;
#                home-manager.useUserPackages = true;
#              }
#
#              # Shared config
#              (import ./configuration.nix { inherit pkgs; })
#            ];
#          })
#
#        # configuration input
#          (import ./hosts/${hostName} {
#            system = system;
#            pkgs = nixpkgs.legacyPackages.${system};
#          }));
#    in {
#      nixosConfigurations = {
#        ePower = mkHost "ePower" "x86_64-linux";
#        eFrame = mkHost "eFrame" "x86_64-linux";
#      };
#    };
}
