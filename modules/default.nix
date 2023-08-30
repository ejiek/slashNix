{ config, lib, pkgs, ... }: {
  imports = [
    ./alacritty
    ./bat
    ./boot
    ./fileSystems
    ./git
    ./hyprland
    ./networking
    ./nu
    ./nvim
    ./obsidian
    ./opentabletdriver
    ./pass
    ./podman
    ./qutebrowser
    ./rbw
    ./rofi
    ./starship
    ./steam
    ./tailscale
    ./unfree
    ./zsh
    ];
}
