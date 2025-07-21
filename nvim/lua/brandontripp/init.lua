-- below requiring the remap file from dir to automatically source source 
require("brandontripp.remap")
require("brandontripp.set")


-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("brandontripp.plugins")

-- possibly the settings below for the side spacing 
-- vim.api.nvim_command('hi DiagnosticHint guibg=NONE')
-- vim.api.nvim_command('hi DiagnosticInfo guibg=NONE')
-- vim.api.nvim_command('hi DiagnosticWarn guibg=NONE')
-- vim.api.nvim_command('hi DiagnosticError guibg=NONE')

-- Add this to your Neovim configuration
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    -- Add error handling for treesitter
    local ok, hl = pcall(require, "vim.treesitter.highlighter")
    if ok then
      local self = hl.active[args.buf]
      if self and self.tree then
        self.tree:register_cbs({
          on_error = function(err)
            vim.schedule(function()
              vim.notify("TreeSitter error: " .. err, vim.log.levels.WARN)
            end)
          end,
        })
      end
    end
  end,
})

-- Ensure .templ files are recognized as templ filetype
vim.cmd([[ autocmd BufRead,BufNewFile *.templ set filetype=templ ]])







-- Function to run formatters
-- local function format_python()
--     -- Get the current buffer's file path
--     local file = vim.fn.expand('%:p')
--
--     -- Run autopep8
--     vim.fn.system('autopep8 --in-place --aggressive --aggressive ' .. file)
--
--     -- Run black
--     vim.fn.system('black ' .. file)
--
--     -- Run isort
--     vim.fn.system('isort ' .. file)
--
--     -- Reload the buffer to show changes
--     vim.cmd('e!')
-- end

-- Set up autocommand for Python files
-- vim.api.nvim_create_autocmd("BufWritePost", {
--     pattern = "*.py",
--     callback = function()
--         format_python()
--     end,
-- })
