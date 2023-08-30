{ config, lib, pkgs, ... }:
let inherit (lib) types mkIf mkDefault mkOption;
in {
  options.my-config = {
    rofi.enable = mkOption {
      description = "Enable my customized rofi";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.my-config.rofi.enable {
    home-manager.users.ejiek = {
      programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        pass = {
          enable = true;
          stores = [ "/home/ejiek/.local/share/password-store" ];
        };
        plugins = with pkgs; [
          rofi-emoji
        ];

      };

      home.packages = with pkgs; [
        rofimoji
      ];
    };
  };
}
