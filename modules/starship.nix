{
  config,
  pkg,
  ...
}:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
