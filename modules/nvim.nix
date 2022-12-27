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
      {
        plugin = airline;
        config = ''
          let g:airline_powerline_fonts = 1
        '';
      }
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
