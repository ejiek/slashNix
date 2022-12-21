{
  config,
  pkgs,
  home-manager,
  ...
}:

{
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
}
