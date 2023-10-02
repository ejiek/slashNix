{ config, lib, pkgs, ... }:
let inherit (lib) types mkIf mkDefault mkOption;
in {
  options.my-config = {
    bluetooth.enable = mkOption {
      description = "Enable bluetooth with some extras";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.my-config.bluetooth.enable {
    hardware.bluetooth.enable = true;


    home-manager.users.ejiek = {
      services.mpris-proxy.enable = true;
      home.packages = with pkgs; [
        bluetuith
      ];
    };
  };
}
