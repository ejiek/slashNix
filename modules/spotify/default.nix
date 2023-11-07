{ config, lib, pkgs, ... }:
let inherit (lib) types mkIf mkDefault mkOption;
in {
  options.my-config = {
    spotify.enable = mkOption {
      description = "Enable obsidian";
      type = types.bool;
      default = false;
    };
    spotify.discovery = mkOption {
      description = "Spotify Connect";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.my-config.spotify.enable {
    environment.systemPackages = with pkgs; [ spotify ];
    nixpkgs.allowUnfreePackages = [ "spotify" ];
    networking.firewall = {
      allowedTCPPorts = [ 57621 ];
      allowedUDPPorts = [ 5353 ];
    };
  };
}
