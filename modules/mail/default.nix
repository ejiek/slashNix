{ config, lib, pkgs, ... }:
let inherit (lib) types mkIf mkDefault mkOption;
in {
  options.my-config = {
    mail.enable = mkOption {
      description = "Enable ejiek'a mail setup";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.my-config.mail.enable {
    home-manager.users.ejiek = {
      programs.aerc = {
        enable = true;
      };
      home.packages = with pkgs; [
        protonmail-bridge
      ];
    };
  };
}
