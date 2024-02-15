{ config, lib, pkgs, ... }:
let inherit (lib) types mkIf mkDefault mkOption;
in {
  options.my-config = {
    dev_tools.enable = mkOption {
      description = "Collection of dev tools";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.my-config.dev_tools.enable {
    environment.systemPackages = with pkgs; [
      gh
      glab
      yamlfmt
    ];
  };
}
