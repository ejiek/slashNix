{ config, lib, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
      hidpi = false;
    };
  };

  environment.systemPackages = with pkgs; [ tofi ];
}
