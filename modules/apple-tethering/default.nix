{ config, lib, pkgs, ... }:
let inherit (lib) types mkIf mkDefault mkOption;
in {
  options.my-config = {
    apple-tethering.enable = mkOption {
      description = "Enable support for wired tethering from apple devices";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.my-config.apple-tethering.enable {
    environment.systemPackages = with pkgs; [
      libimobiledevice
    ];
    services.usbmuxd.enable = true;
  };
}
