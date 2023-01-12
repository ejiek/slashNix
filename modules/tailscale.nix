{
  config,
  pkgs,
  ...
}:

{
  service.tailscale = {
    enable = true;
  };
}
