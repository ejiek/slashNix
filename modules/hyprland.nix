{ config, lib, pkgs, hyprland, ... }:

{
  programs.hyprland = {
    enable = true;
  };

  programs.tofi = {
    enable = true;
  };
}
