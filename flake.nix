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

    outputs = inputs @ { self, nixpkgs, home-manager, ...}: {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager;
        }
      );
    };
}
