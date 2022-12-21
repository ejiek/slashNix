{
  config,
  pkgs,
  ...
}:

{
  programs.git = {
    enable = true;
    userEmail = "ejiek@pm.me";
    userName = "Vlad Petrov";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
}
