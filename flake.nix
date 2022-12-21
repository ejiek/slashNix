{
  description = "A very basic flake";

    inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
      home-manager = {
        url = 
        github:nix-community/home-manager;
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

    outputs = { self, nixpkgs, home-manager }: 
      let 
        system = "x86_64-linux";
        pkgs = import nixpkgs {
          inherit system;
          cofig.allowUnfree = true;
        };
        lib = nixpkgs.lib;
      in {
        nixosConfigurations = {
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
        };
      };
}
