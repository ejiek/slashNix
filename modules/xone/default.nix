{ config, lib, pkgs, ... }:
let inherit (lib) types mkIf mkDefault mkOption;
in {
  options.my-config = {
    xone.enable = mkOption {
      description = "Enable dirvers for Xbox One controller (with wireless dongle)";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.my-config.xone.enable {
    hardware.xone.enable = true;
    boot.extraModulePackages = with config.boot.kernelPackages; [
      xone
    ];
    pkgs.allowUnfreePackages = [ "xow_dongle-firmware" ];
  };
}
