{ config, lib, pkgs, ... }:
let inherit (lib) types mkIf mkDefault mkOption;
in {
  options.my-config = {
    tailscale.enable = mkOption {
      description = "Enable tailscale";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.my-config.tailscale.enable {
    services.tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };
  };
}
