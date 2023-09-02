{ config, lib, pkgs, ... }: {
  imports = [
    ./alacritty
    ./apple-tethering
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
    ./zathura
    ./zsh
    ];
}
