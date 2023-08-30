{ config, lib, pkgs, ... }:
let inherit (lib) types mkIf mkDefault mkOption;
in {
  options.my-config = {
    opentabletdriver.enable = mkOption {
      description = "Enable OpenTabletDriver";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.my-config.opentabletdriver.enable {
    hardware.opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
  };
}
