{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ejiek";
  home.homeDirectory = "/home/ejiek";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  #programs.home-manager.enable = true;
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      airline
      copilot-vim
      gruvbox-community
      vim-nix
      yankring
    ];
  };

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
