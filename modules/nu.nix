{
  config,
  pkg,
  ...
}:

{
  programs.nushell = {
    enable = true;
    extraConfig = ''
      alias nwitch = sudo nixos-rebuild switch --flake '/home/ejiek/.slashNix/flake.nix#e220'
      alias ntest = sudo nixos-rebuild test --flake '/home/ejiek/.slashNix/flake.nix#e220'
    '';
  };
}

