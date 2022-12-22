{
  config,
  pkgs,
  ...
}:

# There is an option in gitconf to alter config for a given path
# it is useful to separate a work account from a personal one.
# It's not implemented in this config yet.
#
# ```
# [includeIf "gitdir:~/work/ocado"]
#   path = ~/.config/git/ocado.conf
# ```

{
  programs.git = {
    enable = true;
    userEmail = "ejiek@pm.me";
    userName = "Vlad Petrov";
    aliases = {
      lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n%C(white)%s%C(reset) %C(dim green)- %an%C(reset)' --all";
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      pull = {
        ff = "only";
      };
    };
    ignores = [
      "*.swp"
      ".envrc"
    ];
  };
}
