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
    extraConfig = ''
      set rnu
      set nu
    '';
    plugins = with pkgs.vimPlugins; [
      {
        plugin = airline;
        config = ''
          let g:airline_powerline_fonts = 1
        '';
      }
      copilot-vim
      coc-markdownlint
      coc-ltex
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
      {
        plugin = telescope-nvim;
        config = ''
          let g:telescope_previewer = 'bat'
          let mapleader = "\<Space>"
          nnoremap <leader>ff <cmd>Telescope find_files<cr>
          nnoremap <leader>fg <cmd>Telescope live_grep<cr>
          nnoremap <leader>fb <cmd>Telescope buffers<cr>
          nnoremap <leader>fh <cmd>Telescope help_tags<cr>
        '';
      }
      nvim-treesitter
      vim-devicons
      vim-fugitive
      # vim-rhubarb
      vim-signify
      vim-startify
    ];
    coc = {
      enable = true;
      settings = {
          "markdownlint.config" = {
            "default" = true;
            "line-length" = false;
          };
          "ltex.ltex-ls.path" = "${pkgs.ltex-ls}";
          "ltex.java.path" = "${pkgs.jre_headless}";
      };
    };
  };

  home.packages = with pkgs; [
    # telescope dependencies
    bat
    fd
    fzf
    ltex-ls
    ripgrep
    # TODO: get rid of node_Packages for every line
    nodePackages.coc-css
    nodePackages.coc-eslint
    nodePackages.coc-html
    nodePackages.coc-json
    nodePackages.coc-prettier
    nodePackages.coc-python
    nodePackages.coc-rust-analyzer
    nodePackages.coc-sh
    nodePackages.coc-tsserver
    nodePackages.coc-vimlsp
    nodePackages.coc-yaml
  ];
}
