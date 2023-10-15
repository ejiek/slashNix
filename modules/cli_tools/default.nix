{ config, lib, pkgs, ... }:
let inherit (lib) types mkIf mkDefault mkOption;
in {
  options.my-config = {
    cli_tools.enable = mkOption {
      description = "Collection of cli tools";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.my-config.cli_tools.enable {
    environment.systemPackages = with pkgs [
      figlet
      gh
      gomuks
      hdparm
      joshuto
      lolcat
      ripgrep
      tmate
      vhs
      wget
      yt-dlp
      zellij
    ]
  };
}