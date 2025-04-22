return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    require('telescope').setup {
      pickers = {
        find_files = {
          theme = "ivy"
        }
      },
      extensions = {
        fzf = {}
      }
    }

    require('telescope').load_extension('fzf')

    --fh - find help tags
    vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags)
    -- pf -- using primes mapping instead of Tj's fd - find directory
    vim.keymap.set("n", "<space>pf", require('telescope.builtin').find_files)

    -- en - edit neovim
    vim.keymap.set("n", "<space>en", function()
      require('telescope.builtin').find_files {
        cwd = vim.fn.stdpath("config")
      }
    end)
    -- ep - edit packages
    vim.keymap.set("n", "<space>ep", function()
      require('telescope.builtin').find_files {
        cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
      }
    end)

    -- this if from primes but adjusted for grep search all including hidden files
    -- now using <space>fg for find grep which uses float window multigrep
    vim.keymap.set('n', '<leader>ps', function()
      require('telescope.builtin').grep_string({
        search = vim.fn.input("Grep All > "),
        additional_args = { "--hidden", "--no-ignore" },
        file_ignore_patterns = {
          "node_modules",
          ".git"
        },
        hidden = true,
        no_ignore = true,
      });
    end)

    require "config.telescope.multigrep".setup()
  end
}

