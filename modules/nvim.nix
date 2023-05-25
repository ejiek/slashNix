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
    defaultEditor = true;
    extraConfig = ''
      " Show current line and distance from it
      set rnu
      set nu

      " Tabbulation
      set autoindent   " Indent according to previous line.
      set expandtab
      set tabstop=2
      set shiftwidth=2

      " Show tabs and trailing whitespace
      set list
      set listchars=tab:▸\ ,trail:·

      " migh not be needed with vimlastplace
      set viminfo='10,\"100,:20,%,n~/.viminfo

      " Fixes file creation in netrw
      set shell=/etc/profiles/per-user/ejiek/bin/zsh

      " Better window navigation
      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l
      " Split vetically with ctrl+| and horizontally with ctrl+/

      nnoremap <leader>pv :Explore<cr>
    '';
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
      {
        plugin = telescope-nvim;
        config = ''
          let g:telescope_previewer = 'bat'
          " mapleader defined here because extraConfig is evaluated after plugins
          let mapleader = "\<Space>"
          nnoremap <leader>ff <cmd>Telescope find_files<cr>
          nnoremap <leader>fg <cmd>Telescope git_files<cr>
          nnoremap <leader>fl <cmd>Telescope live_grep<cr>
        '';
      }
      nvim-cmp
      {
        plugin = nvim-treesitter;
        type = "lua";
        config = ''
          require'nvim-treesitter.configs'.setup {
            highlight = {
              enable = true,
            },
            additional_vim_regex_highlighting = false,
          }
        '';
      }
      nvim-treesitter-parsers.bash
      nvim-treesitter-parsers.css
      nvim-treesitter-parsers.dockerfile
      nvim-treesitter-parsers.git_config
      nvim-treesitter-parsers.git_rebase
      nvim-treesitter-parsers.gitcommit
      nvim-treesitter-parsers.gitignore
      nvim-treesitter-parsers.go
      nvim-treesitter-parsers.html
      nvim-treesitter-parsers.javascript
      nvim-treesitter-parsers.json
      nvim-treesitter-parsers.lua
      nvim-treesitter-parsers.markdown
      nvim-treesitter-parsers.nix
      nvim-treesitter-parsers.python
      nvim-treesitter-parsers.rust
      nvim-treesitter-parsers.sql
      nvim-treesitter-parsers.terraform
      nvim-treesitter-parsers.latex
      nvim-treesitter-parsers.toml
      nvim-treesitter-parsers.typescript
      nvim-treesitter-parsers.yaml
      {
        plugin = harpoon;
        type = "lua";
        config = ''
          local mark = require("harpoon.mark")
          local ui = require("harpoon.ui")

          vim.keymap.set("n", "<leader>a", mark.add_file)
          vim.keymap.set("n", "<C-d>", ui.toggle_quick_menu)

          vim.keymap.set("n", "<C-j>", function() ui.nav_file(1) end)
          vim.keymap.set("n", "<C-k>", function() ui.nav_file(2) end)
          vim.keymap.set("n", "<C-l>", function() ui.nav_file(3) end)
          vim.keymap.set("n", "<C-Semicolon>", function() ui.nav_file(4) end)
        '';
      }
      vim-devicons
      {
        plugin = vim-fugitive;
        type = "lua";
        config = ''
          vim.keymap.set("n", "<leader>gs", ":Git<CR>")
          vim.keymap.set("n", "<leader>gb", ":Git blame<CR>")
        '';
      }
      # vim-rhubarb
      vim-signify
      vim-lastplace
      {
        plugin = undotree;
        type = "lua";
        config = ''
          vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")
        '';
      }
    ];
  };

  home.packages = with pkgs; [
    # telescope dependencies
    bat
    fd
    fzf
    ripgrep
  ];
}
