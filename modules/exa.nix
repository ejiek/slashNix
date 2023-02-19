{ pkgs, ... }:

environment.systemPackages = [ pkgs.exa ]; # Add exa to system packages

# Define a shell function to alias ls to exa
shellInit = ''
  alias ls=exa
'';
