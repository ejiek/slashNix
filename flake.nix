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
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, rust-overlay }@inputs:
    let
      mkHost = hostName: system:
          nixpkgs.lib.nixosSystem {
            inherit system;
            pkgs = import nixpkgs {
              config.allowUnfree = true;
            };

            specialArgs = {
              inherit rust-overlay inputs;
            };
            modules = [
              ./modules

              # Shared by all hosts
              ./configuration.nix

              # Host specific
              ./hosts/${hostName}

              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
              }
            ];
          };
    in {
      nixosConfigurations = {
        ePower = mkHost "ePower" "x86_64-linux";
        eFrame = mkHost "eFrame" "x86_64-linux";
      };
    };
}
