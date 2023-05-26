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
      set softtabstop=2
      set shiftwidth=2

      set nowrap

      " Undo tree for the win
      set noswapfile
      set nobackup
      set undodir=~/.local/share/nvim/undodir
      set undofile

      set nohlsearch
      set incsearch

      set scrolloff=5
      set sidescrolloff=5

      set colorcolumn=80

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
    extraLuaConfig = ''
      vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
      vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

      vim.keymap.set("n", "<C-d>", "<C-d>zz")
      vim.keymap.set("n", "<C-u>", "<C-u>zz")
      vim.keymap.set("n", "n", "nzz")
      vim.keymap.set("n", "N", "Nzz")

      -- clipboard management
      vim.keymap.set("x", "<leader>p", '"_dP')
      vim.keymap.set("n", "<leader>y", "\"+y")
      vim.keymap.set("v", "<leader>y", "\"+y")
      vim.keymap.set("n", "<leader>Y", "\"+Y")
      vim.keymap.set("n", "<leader>d", "\"_d")
      vim.keymap.set("v", "<leader>d", "\"_d")
    '';
    plugins = with pkgs.vimPlugins; [
      {
        plugin = airline;
        config = ''
          let g:airline_powerline_fonts = 1
        '';
      }
      {
        plugin = copilot-lua;
        type = "lua";
        config = ''
          require("copilot").setup({
            suggestion = { enable = false },
            panel = { enable = false },
          })
        '';
      }
      {
        plugin = copilot-cmp;
        type = "lua";
        config = ''
          require("copilot_cmp").setup()
        '';
      }
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
          vim.keymap.set("n", "<Alt-g>", ui.toggle_quick_menu)

          vim.keymap.set("n", "<Alt-a>", function() ui.nav_file(1) end)
          vim.keymap.set("n", "<Alt-s>", function() ui.nav_file(2) end)
          vim.keymap.set("n", "<Alt-d>", function() ui.nav_file(3) end)
          vim.keymap.set("n", "<Alt-f>", function() ui.nav_file(4) end)

          vim.keymap.set("n", "C-k", "<cmd>cnext<CR>zz")
          vim.keymap.set("n", "C-j", "<cmd>cprev<CR>zz")
          vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
          vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

          vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
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
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      luasnip
      {
        plugin = lsp-zero-nvim;
        type = "lua";
        config = ''
          local lsp = require("lsp-zero")

          lsp.preset("recommended")

          local cmp = require('cmp')
          local cmp_select = {behavior = cmp.SelectBehavior.Select}
          local cmp_mappings = lsp.defaults.cmp_mappings({
            ['<C-p>'] = cmp.mapping.select_prev_item(cpm_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cpm_select),
            ['<C-y>'] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = false,
            }),
          })

          lsp.setup_nvim_cmp({
            mapping = cmp_mappings
          })

          lsp.on_attach(function(client, bufnr)
            lsp.default_keymaps({ buffer = bufnr })
          end)

          lsp.setup_servers({
            'tsserver',
            'eslint',
            'rust_analyzer',
            'nil_ls',
            'pyright',
            'gopls',
            'bashls',
          })

          lsp.setup()

          cmp.setup({
            sources = {
              {name = 'copilot'},
              {name = 'nvim_lsp'},
            }
          })
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
    # language servers
    nodePackages.typescript-language-server
    nodePackages.eslint
    rust-analyzer
    nil
    nodePackages.pyright
    gopls
    nodePackages.bash-language-server
    shellcheck
  ];
}
