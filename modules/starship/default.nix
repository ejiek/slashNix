{ config, lib, pkgs, ... }:
let inherit (lib) types mkIf mkDefault mkOption;
in {
  options.my-config = {
    starship.enable = mkOption {
      description = "Enable my customized git";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.my-config.starship.enable {
    home-manager.users.ejiek = {
      programs.starship = {
        enable = true;
        enableZshIntegration = true;
        enableNushellIntegration = true;
      };
    };
  };
}
