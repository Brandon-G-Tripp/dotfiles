return {
  -- Theme
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    config = function()
      require('rose-pine').setup({
          -- Optional: configure variant (auto, main, moon, or dawn)
          variant  = 'auto',
          -- Make background transparent
          disable_background = true,
          enable_italics = true,
      })

      vim.cmd('colorscheme rose-pine')
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    end,
  },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- Treesitter (configuration kept separate)
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
  },

  -- LSP
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      -- {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      -- {'rafamadriz/friendly-snippets'},
      {'saadparwaiz1/cmp_luasnip'},
    }
  },

  -- Other plugins
  'joerdav/templ.vim',
  'voldikss/vim-floaterm',
  'nvim-treesitter/playground',
  'ThePrimeagen/harpoon',
  'mbbill/undotree',
  'alexghergh/nvim-tmux-navigation',
  'ThePrimeagen/vim-be-good',
  'tpope/vim-surround',
  'tpope/vim-fugitive',
  'tpope/vim-commentary',
  'sunaku/vim-dasht',
}
