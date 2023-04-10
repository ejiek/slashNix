{ config, lib, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
      hidpi = false;
    };
  };
  programs.tofi = {
    enable = true;
  };
}
