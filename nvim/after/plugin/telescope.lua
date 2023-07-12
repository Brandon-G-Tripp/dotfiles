local builtin = require('telescope.builtin')
-- below pf for project find 
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
-- below to just find files in git, skipping node modules for example 
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
-- mapping for ps project search
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
