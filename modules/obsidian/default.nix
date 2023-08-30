{ config, lib, pkgs, ... }:
let inherit (lib) types mkIf mkDefault mkOption;
in {
  options.my-config = {
    obsidian.enable = mkOption {
      description = "Enable obsidian";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.my-config.obsidian.enable {
    environment.systemPackages = with pkgs; [ obsidian ];
    nixpkgs.allowUnfreePackages = [ "obsidian" ];
  };
}
