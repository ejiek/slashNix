{
  config,
  pkgs,
  home-manager,
  ...
}:

{
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      airline
      copilot-vim
      {
        plugin = gruvbox-community;
        config = ''
          set termguicolors
          colorscheme gruvbox
          set background=light
        '';
      }
      vim-nix
      yankring
    ];

  };
}
