{ config, lib, pkgs, ... }:
let inherit (lib) types mkIf mkDefault mkOption;
in {
  options.my-config = {
    nu.enable = mkOption {
      description = "Enable my customized git";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.my-config.nu.enable {
    home-manager.users.ejiek = {
      programs.nushell = {
        enable = true;
        extraConfig = ''
        alias nwitch = sudo nixos-rebuild switch --flake '/home/ejiek/.slashNix/flake.nix#e220'
        alias ntest = sudo nixos-rebuild test --flake '/home/ejiek/.slashNix/flake.nix#e220'
        '';
      };

      home.packages = [ pkgs.nu_scripts ];
    };
  };
}
