{ config, lib, pkgs, ... }:
let inherit (lib) types mkIf mkDefault mkOption;
in {
  options.my-config = {
    warp.enable = mkOption {
      description = "Enable Warp terminal";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.my-config.warp.enable {
    environment.systemPackages = with pkgs; [ warp-terminal ];
    nixpkgs.allowUnfreePackages = [ "warp-terminal" ];
  };
}
