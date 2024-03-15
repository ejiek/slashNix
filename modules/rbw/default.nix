{ config, lib, pkgs, ... }:
let inherit (lib) types mkIf mkDefault mkOption;
in {
  options.my-config = {
    rbw.enable = mkOption {
      description = "Enable bitwarden for rofi";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.my-config.rbw.enable {
    home-manager.users.ejiek = {
      programs.rbw = {
        enable = true;
        settings = {
          email = "ejiek@pm.me";
          pinentry = pkgs.pinentry-curses;
        };
      };
      home.packages = with pkgs; [
        rofi-rbw-wayland
      ];
    };
  };
}
