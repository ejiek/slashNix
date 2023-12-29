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
      gh
      gomuks
      hdparm
      ldns
      lolcat
      nix-tree
      nvd # https://gitlab.com/khumba/nvd
      ripgrep
      tmate
      vhs
      wget
      yt-dlp
      zellij
    ];
  };
}
