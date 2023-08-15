{ config, lib, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
    };
  };
}
