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
    environment.systemPackages = with pkgs; [
      bottom
      figlet
      file
      gomuks
      hdparm
      ipcalc
      ldns
      lolcat
      nix-tree
      nvd # https://gitlab.com/khumba/nvd
      ripgrep
      speedtest-go
      tmate
      vhs
      wget
      whois
      yt-dlp
      zellij
    ];
  };
}
