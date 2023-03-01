{
  config,
  pkgs,
  home-manager,
  ...
}:

{
  programs.bat = {
    enable = true;
    config = {
      theme = "gruvbox-light";
    };
  };
}
